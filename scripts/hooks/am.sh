#!/bin/bash
set -e
wget -qO- https://github.com/ivan-hc/AM/raw/main/INSTALL|sudo bash -
#wget -qO /opt/am/APP-MANAGER https://github.com/ivan-hc/AM/raw/snapshot-20250305/APP-MANAGER
wget -qO /opt/am/APP-MANAGER https://github.com/ivan-hc/AM/raw/dev/APP-MANAGER