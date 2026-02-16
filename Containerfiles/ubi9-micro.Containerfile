ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

ARG IMAGE_VERSION
ARG BUILD_DATE
ARG TARGETARCH
ARG GIT_COMMIT

LABEL org.opencontainers.image.title="Trusted UBI9 Micro" \
      org.opencontainers.image.maintainer="Ryan Craig <ryan.craig@infrashift.io>" \
      org.opencontainers.image.vendor="Infrashift" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${GIT_COMMIT}" \
      org.opencontainers.image.architecture="${TARGETARCH}" \
      io.infrashift.image.upstream.base="${UPSTREAM_BASE}" \
      io.infrashift.image.upstream.digest="${UPSTREAM_DIGEST}" \
      io.infrashift.image.variant="micro" \
      io.openshift.tags="ubi9,micro,vetted"

# No RUN commands here as Micro has no shell/dnf by default.
# It is designed to have binaries copied into it.

USER 1001