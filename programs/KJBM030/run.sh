#!/bin/bash
set -Eeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)

PROGRAMNAME=$(basename "${SCRIPTDIR}")
BINDIR="${SCRIPTDIR}"
PROGRAM="${BINDIR}/${PROGRAMNAME}"

export ITF="${SCRIPTDIR}/KJBM030I.dat"
export IMF="${SCRIPTDIR}/KJBM030M.dat"
export OTF="${SCRIPTDIR}/KJBM030O.dat"

${PROGRAM} | iconv -f cp932
