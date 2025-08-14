# syntax=docker/dockerfile:1
#
# Copyright 2025 Nialto Services Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM alpine:3.21

LABEL org.opencontainers.image.description="Dovecot"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.source="https://github.com/NialtoServices/docker-dovecot"

ARG DOVECOT_VERSION="2.3.21"

RUN apk upgrade --no-cache

RUN \
addgroup --system --gid 820 dovecot && \
addgroup --system --gid 821 dovenull && \
addgroup --system --gid 850 vmail && \
adduser --system --uid 820 --ingroup dovecot --gecos dovecot --disabled-password --no-create-home --home /var/spool/mail --shell /sbin/nologin dovecot && \
adduser --system --uid 821 --ingroup dovenull --gecos dovenull --disabled-password --no-create-home --home /dev/null --shell /sbin/nologin dovenull && \
adduser --system --uid 850 --ingroup vmail --gecos vmail --disabled-password --no-create-home --home /var/mail --shell /sbin/nologin vmail

RUN \
apk add --no-cache \
tini \
ca-certificates \
dovecot~=$DOVECOT_VERSION \
dovecot-ldap~=$DOVECOT_VERSION \
dovecot-lmtpd~=$DOVECOT_VERSION \
dovecot-lua~=$DOVECOT_VERSION \
dovecot-mysql~=$DOVECOT_VERSION \
dovecot-pgsql~=$DOVECOT_VERSION \
dovecot-pigeonhole-plugin~=$DOVECOT_VERSION \
dovecot-pigeonhole-plugin-ldap~=$DOVECOT_VERSION \
dovecot-pop3d~=$DOVECOT_VERSION \
dovecot-sql~=$DOVECOT_VERSION \
dovecot-sqlite~=$DOVECOT_VERSION \
dovecot-submissiond~=$DOVECOT_VERSION

COPY bin/bootstrap /usr/local/sbin/bootstrap

ENTRYPOINT ["/usr/local/sbin/bootstrap"]
