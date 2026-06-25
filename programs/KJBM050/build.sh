#!/bin/bash
set -xEeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)
BINDIR="${SCRIPTDIR}"
COPYLIBDIR="${SCRIPTDIR}/../../copylib"
DIRNAME=$(basename "${SCRIPTDIR}")

# コンパイル
SRCFILE="${DIRNAME}.COB"
BINFILE=$(basename -s .COB $SRCFILE)

cobc -x -o "${BINDIR}/${BINFILE}" -I"${COPYLIBDIR}" "${SRCFILE}"
