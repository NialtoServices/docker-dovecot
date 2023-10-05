# Docker container for Dovecot

This container uses the Alpine Linux base image and installs the Dovecot IMAP/POP3 server, along with a minimal
bootstrap script which sets up the container at runtime for Dovecot.

## Getting Started

The Dovecot configuration files are stored in the `/etc/dovecot` directory which you can mount as a volume with your
custom configuration files.

## Bootstrap Phase

When the container is started, the `bootstrap` script is used as the entrypoint, which simply executes init scripts
stored in the `/etc/dovecot/bootstrap.d` directory before starting the `dovecot` process through the `exec` command.

## License

This project is licensed under the Apache-2.0 License - see the LICENSE file for details.
