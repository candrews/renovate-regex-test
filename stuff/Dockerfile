# syntax=docker.io/docker/dockerfile:1.14.0@sha256:4c68376a702446fc3c79af22de146a148bc3367e73c25a5803d453b6b3f722fb
# check=error=true

# For release notes: https://github.com/sigstore/cosign/releases
FROM gcr.io/projectsigstore/cosign:v2.5.0@sha256:e82eb6d42ccb6bc048d8d9e5e598e4d5178e1af6c00e54e02c9b0569c5f3ec11 AS cosign-bin

FROM koalaman/shellcheck-alpine:v0.10.0@sha256:5921d946dac740cbeec2fb1c898747b6105e585130cc7f0602eec9a10f7ddb63 AS shellcheck-bin

FROM aquasec/trivy:0.61.0@sha256:6967db29ce5294d054121e94b3cb1262de858af63b4547bb1bade66a4306f2e4 AS trivy-bin

FROM sonarsource/sonar-scanner-cli:11.2.1.1844_7.0.2@sha256:a3e91cb4a0a08fb99aa90807a6f9720c57e9279860d088b5f158a3a888e838ff AS scannercli

FROM python:3.12.10-alpine@sha256:c08bfdbffc9184cdfd225497bac12b2c0dac1d24bbe13287cfb7d99f1116cf43

COPY --from=shellcheck-bin /bin/shellcheck /usr/local/bin/shellcheck
COPY --from=cosign-bin /ko-app/cosign /usr/local/bin/cosign
COPY --from=trivy-bin /usr/local/bin/trivy /usr/local/bin/trivy
COPY --from=scannercli /opt/sonar-scanner /opt/sonar-scanner
COPY --chown=1005:1005 --chmod=644 settings.xml /home/secrel/.m2/settings.xml
COPY settings.xml /secrel/maven/settings.xml
COPY release-settings.xml /secrel/maven/release-settings.xml

ARG CHECKOV_VERSION=3.2.372
ARG VAULT_VERSION=1.19.1
