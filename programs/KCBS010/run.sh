#!/bin/bash
set -euo pipefail

SCRIPTDIR=$(cd $(dirname $0); pwd)

PROGRAMNAME="TEST-KCBS010"
BINDIR="${SCRIPTDIR}"
PROGRAM="${BINDIR}/${PROGRAMNAME}"

export OTF="${SCRIPTDIR}/result.dat"
${PROGRAM}
