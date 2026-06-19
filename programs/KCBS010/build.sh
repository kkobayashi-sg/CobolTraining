#!/bin/bash
set -xEeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)
BINDIR="${SCRIPTDIR}"
COPYLIBDIR=$(realpath "${SCRIPTDIR}/../../copylib")
DIRNAME=$(basename "${SCRIPTDIR}")

# コンパイル
SRCFILE="KCBS010.COB"
SONAME=$(basename -s .COB $SRCFILE).so
cobc -m -o "${SCRIPTDIR}/${SONAME}" -I"${DIRNAME}" -I"${COPYLIBDIR}" "${SRCFILE}"

# コンパイル
SRCFILE="TEST-KCBS010.COB"
BINNAME=$(basename -s .COB $SRCFILE)
cobc -x -o "${SCRIPTDIR}/${BINNAME}" -I"${DIRNAME}" -I"${COPYLIBDIR}" "${SRCFILE}"
