#!/usr/bin/env bash
set -ex

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source $CARGO_HOME/env
