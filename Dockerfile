FROM node:25.9.0-slim

ENV TZ="Europe/London"

USER root

# curl + unzip for the AWS CLI download, Java for the Allure report generator.
RUN apt-get update -qq \
    && apt-get install -qqy --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

WORKDIR /app

# Dependencies first so source edits do not invalidate the install layer.
# --ignore-scripts skips the husky "prepare" hook, which has no git repo here.
# Only chromium is configured in playwright.config.ts and runs headless, so
# install just the headless shell rather than firefox, webkit and full chromium.
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts --no-audit --no-fund \
    && npx playwright install --with-deps --only-shell chromium \
    && rm -rf /var/lib/apt/lists/*

COPY . .
COPY --chmod=755 entrypoint.sh ./
COPY --chmod=755 bin/publish-tests.sh ./bin/

ENTRYPOINT [ "./entrypoint.sh" ]

# This is downloading the linux amd64 aws cli. For M1 macs build and run with the --platform=linux/amd64 argument. eg docker build . --platform=linux/amd64
