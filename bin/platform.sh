#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Resolve ROOT_DIR to the lis-dev parent folder
# Works locally AND in GitHub Actions
# ------------------------------------------------------------
if [ -z "${ROOT_DIR:-}" ]; then
	export ROOT_DIR="$(cd "$(dirname "$0")/../../" && pwd)"
fi

# ------------------------------------------------------------
# Resolve repo paths relative to lis-dev parent folder
# ------------------------------------------------------------
LIS_DEV_DIR="$ROOT_DIR/lis-dev"
LIS_DEV_PARENT_DIR="$ROOT_DIR"

COMMAND="${1:-help}"

ensure_network() {
	if ! docker network inspect lis-dev >/dev/null 2>&1; then
		echo "[platform] Creating lis-dev network..."
		docker network create lis-dev
	fi
}

pull_and_update_submodules() {
    echo "[platform] Pulling and updating lis-dev submodules..."
    ./.scripts/update-project.sh
    return $?
}

setup_etc_hosts() {
    echo "[platform] Setting up /etc/hosts entries..."
    ./.scripts/setup-hosts.sh
    return $?
}

setup_tls_certificates() {
    echo "[platform] Setting up TLS certificates..."
    ./.scripts/setup-certs.sh
    return $?
}

# With the sync skipped, every sibling-repo path the compose stack
# bind-mounts or builds from must already be checked out, or compose fails
# later with an opaque error. Fail here instead, naming the path, so a newly
# enabled include that needs another sibling repo is obvious. lis-dev's own
# .tools/ paths are left out: its data directories are created on first use
# and its certificates by setup-certs.sh, which runs after this check.
check_sibling_paths() {
    local missing=0 path
    while IFS= read -r path; do
        [ -n "$path" ] && [ ! -e "$path" ] && { echo "[platform] missing: $path" >&2; missing=1; }
    done < <(docker compose -p lis-dev config --format json 2>/dev/null \
        | jq -r '.services[] | (.volumes[]? | select(.type == "bind") | .source), (.build.context? // empty)' \
        | grep -v "^$LIS_DEV_DIR/.tools/" \
        | sort -u)
    if [ "$missing" = 1 ]; then
        echo "[platform] the compose stack reads from paths that are not checked out; add a checkout step for them or run without SKIP_REPO_SYNC" >&2
        return 1
    fi
}

start_platform() {
    cd "$LIS_DEV_DIR"

    # CI checks out the one sibling repo the stack reads (cattle-api) itself,
    # so it has no GitHub credentials for a full sync and skips it.
    if [ "${SKIP_REPO_SYNC:-}" = "true" ]; then
        echo "[platform] SKIP_REPO_SYNC=true, not syncing the lis-* repos"
        check_sibling_paths
    else
        pull_and_update_submodules
    fi
    setup_etc_hosts
    setup_tls_certificates

	echo "[platform] Starting lis-dev platform..."

	if [ "${CI:-}" = "true" ]; then
		echo "[platform] Using lis-dev compose file: docker-compose.yml detached"
		docker compose -p lis-dev up --build -d --wait-timeout 300 --quiet-pull
	else
		echo "[platform] Using lis-dev compose file: docker-compose.yml"
		docker compose -p lis-dev up --build --wait-timeout 300 --quiet-pull
	fi

	return $?
}

stop_platform() {
	echo "[platform] Stopping lis-dev platform..."
	cd "$LIS_DEV_DIR"
	docker compose -p lis-dev down || true
	return $?
}


case "$COMMAND" in
up)
    ensure_network
    start_platform
    ;;
down)
    stop_platform
    ;;
*)
    echo "Usage:"
    echo "  ./platform.sh up     # Start all lis-dev services"
    echo "  ./platform.sh down   # Stop all lis-dev services"
    ;;
esac
