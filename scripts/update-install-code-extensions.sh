#!/usr/bin/env bash

DIR=$(dirname $0)

code --list-extensions |
xargs -L 1 echo code --install-extension > $DIR/install-code-extensions.sh
