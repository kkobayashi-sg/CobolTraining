#!/bin/bash
set -Eeuo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)

PROGRAMNAME=$(basename "${SCRIPTDIR}")
BINDIR="${SCRIPTDIR}"
PROGRAM="${BINDIR}/${PROGRAMNAME}"

export ITF="${SCRIPTDIR}/../../data/KJBM050I.dat"
export OTF1="${SCRIPTDIR}/../../data/KJBM050O1.dat"
export OTF2="${SCRIPTDIR}/../../data/KJBM050O2.dat"

${PROGRAM} | iconv -f cp932
