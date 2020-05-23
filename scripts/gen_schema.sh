#!/bin/env bash

set -euo pipefail
IFS=$'\n\t'

uri=$(pg_tmp -w 300)
sqitch deploy -t "${uri}"
squealgen "${uri}" Schema fetchtree | ormolu > $(git rev-parse --show-toplevel)/fetchtree/src/Schema.hs
