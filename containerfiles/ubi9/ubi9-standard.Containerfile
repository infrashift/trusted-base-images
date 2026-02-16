ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

# Combine them for the FROM instruction
FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

ARG IMAGE_VERSION
ARG BUILD_DATE
ARG TARGETARCH
ARG GIT_COMMIT

LABEL org.opencontainers.image.title="Trusted UBI9 Standard" \
      org.opencontainers.image.maintainer="Ryan Craig <ryan.craig@infrashift.io>" \
      org.opencontainers.image.vendor="Infrashift" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${GIT_COMMIT}" \
      org.opencontainers.image.architecture="${TARGETARCH}" \
      io.infrashift.image.upstream.base="${UPSTREAM_BASE}" \
      io.infrashift.image.upstream.digest="${UPSTREAM_DIGEST}" \
      io.infrashift.image.variant="standard" \
      io.openshift.tags="ubi9,base,vetted"

# Security Hardening
RUN dnf clean all && rm -rf /var/cache/dnf

USER 1001