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

start_platform() {
    cd "$LIS_DEV_DIR"

    pull_and_update_submodules
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
