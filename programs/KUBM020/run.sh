#!/bin/bash
set -Eeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)

PROGRAMNAME=$(basename "${SCRIPTDIR}")
BINDIR="${SCRIPTDIR}"
PROGRAM="${BINDIR}/${PROGRAMNAME}"

export ITF="${SCRIPTDIR}/KUBM020I.dat"
export OTF="${SCRIPTDIR}/KUBM020O.dat"

${PROGRAM} | iconv -f cp932
