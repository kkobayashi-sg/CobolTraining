#!/bin/bash
set -xEeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)
BINDIR="${SCRIPTDIR}"
COPYLIBDIR="${SCRIPTDIR}/../../copylib"
DIRNAME=$(basename "${SCRIPTDIR}")

# ƒRƒ“ƒpƒCƒ‹
SRCFILE="${DIRNAME}.cbl"
BINFILE=$(basename -s .cbl $SRCFILE)

esqlOC -Q -I "${COPYLIBDIR}" -I . -o "${DIRNAME}.cob" "${SRCFILE}"
cobc -x -o "${DIRNAME}" -I "${COPYLIBDIR}" -I. -Q "-Wl,--no-as-needed" -locsql "${DIRNAME}.cob"
