#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NR_DIR="${ROOT_DIR}/contrib/nr"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <nr-source-archive-url>"
  echo "Example: $0 https://.../nr-v5.1.tar.gz"
  exit 1
fi

ARCHIVE_URL="$1"
WORK_DIR="$(mktemp -d /tmp/p1-nr-XXXXXX)"
ARCHIVE_PATH="${WORK_DIR}/nr.tar.gz"
EXTRACT_DIR="${WORK_DIR}/extract"

echo "Downloading NR archive..."
curl -L --fail "${ARCHIVE_URL}" -o "${ARCHIVE_PATH}"
mkdir -p "${EXTRACT_DIR}"
tar -xf "${ARCHIVE_PATH}" -C "${EXTRACT_DIR}"

NR_HELPER_PATH="$(find "${EXTRACT_DIR}" -type f -path '*/helper/nr-helper.h' | head -n 1 || true)"
if [[ -z "${NR_HELPER_PATH}" ]]; then
  echo "Could not locate helper/nr-helper.h in archive."
  exit 1
fi
NR_SRC="$(dirname "$(dirname "${NR_HELPER_PATH}")")"

rm -rf "${NR_DIR}"
mkdir -p "${ROOT_DIR}/contrib"
cp -a "${NR_SRC}" "${NR_DIR}"

echo "NR module installed at ${NR_DIR}"
echo "Reconfigure and build:"
echo "  cd ${ROOT_DIR}"
echo "  python3 ns3 configure --enable-examples --disable-werror"
echo "  python3 ns3 build"
echo "Verify P0 demos:"
echo "  python3 ns3 run lena-simple-epc"
echo "  python3 ns3 run cttc-nr-demo"
