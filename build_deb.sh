#!/bin/bash
# Build roboto-urdf Debian package (Architecture: all)
set -e

PACKAGE="roboto-urdf"
VERSION="1.0.0"
PREFIX="/opt/roboparty"
INSTALL_DIR="${PREFIX}/urdf"
DEB_DIR="${PACKAGE}_${VERSION}_all"

echo ">>> Building ${PACKAGE} ${VERSION}"

# Clean previous staging directory and deb file
rm -rf "${DEB_DIR}" "${DEB_DIR}.deb"
mkdir -p "${DEB_DIR}/DEBIAN"
mkdir -p "${DEB_DIR}${INSTALL_DIR}"

# Copy urdf files
if [ -d "urdf" ]; then
    cp -r urdf/. "${DEB_DIR}${INSTALL_DIR}/"
fi

# Copy DEBIAN maintainer scripts
cp debian/postinst  "${DEB_DIR}/DEBIAN/"
cp debian/postrm    "${DEB_DIR}/DEBIAN/"
chmod 755 "${DEB_DIR}/DEBIAN/postinst" "${DEB_DIR}/DEBIAN/postrm"

# Generate Control file (Replace placeholders)
sed -e "s/VERSION_PLACEHOLDER/${VERSION}/g" \
    debian/control > "${DEB_DIR}/DEBIAN/control"

echo ">>> Executing dpkg-deb build..."
dpkg-deb --root-owner-group --build "${DEB_DIR}"

echo ">>> Success! Generated ${DEB_DIR}.deb"
