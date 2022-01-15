#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
(cd $SCRIPT_DIR && ./vendor/bin/premake/premake5 vs2019)
read -p "Press [Return] key to continue..."
