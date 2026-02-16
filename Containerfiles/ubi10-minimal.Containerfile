ARG UPSTREAM_BASE
ARG UPSTREAM_DIGEST

FROM ${UPSTREAM_BASE}@${UPSTREAM_DIGEST}

ARG IMAGE_VERSION
ARG BUILD_DATE
ARG TARGETARCH
ARG GIT_COMMIT

LABEL org.opencontainers.image.title="Trusted UBI10 Minimal" \
      org.opencontainers.image.maintainer="Ryan Craig <ryan.craig@infrashift.io>" \
      org.opencontainers.image.vendor="Infrashift" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.revision="${GIT_COMMIT}" \
      org.opencontainers.image.architecture="${TARGETARCH}" \
      io.infrashift.image.upstream.base="${UPSTREAM_BASE}" \
      io.infrashift.image.upstream.digest="${UPSTREAM_DIGEST}" \
      io.infrashift.image.variant="minimal" \
      io.openshift.tags="ubi10,minimal,vetted"

# Security Hardening: Minimal uses microdnf
RUN microdnf clean all && rm -rf /var/cache/yum

USER 1001
