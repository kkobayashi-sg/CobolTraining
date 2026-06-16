#!/bin/bash
set -Eeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)

PROGRAMNAME=$(basename "${SCRIPTDIR}")
BINDIR="${SCRIPTDIR}"
PROGRAM="${BINDIR}/${PROGRAMNAME}"

export ITF="${SCRIPTDIR}/KJBM011I.dat"
export OTF="${SCRIPTDIR}/KJBM011O.dat"

${PROGRAM} | iconv -f cp932
