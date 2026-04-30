#!/bin/bash
# Build roboto-urdf Debian package (Architecture: all)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine Board Type (Optional, for filename distinction)
BOARD=${1:-"robopi1"}

PACKAGE="roboto-urdf"
VERSION="1.1.0"
PREFIX="/opt/roboparty"
INSTALL_DIR="${PREFIX}/share"
# Board suffix in version to avoid pool conflict (e.g. 1.1.0-robopi1)
DEB_VERSION="${VERSION}-${BOARD}"
DEB_DIR="${PACKAGE}_${DEB_VERSION}"

echo ">>> Building ${PACKAGE} ${DEB_VERSION} for ${BOARD}"

# Clean previous staging directory and deb file
rm -rf "${DEB_DIR}" "${PACKAGE}_${VERSION}_${BOARD}.deb" "${PACKAGE}_${DEB_VERSION}.deb"
mkdir -p "${DEB_DIR}/DEBIAN"
mkdir -p "${DEB_DIR}${INSTALL_DIR}"

# Find all directories that contain robot descriptions (e.g., atom01_description)
if [ "$BOARD" == "robopi1" ]; then
    for dir in atom01_description/; do
        if [ -d "$dir" ]; then
            robot_name="rpo"
            echo ">>> Including robot description: ${robot_name}..."
            mkdir -p "${DEB_DIR}${INSTALL_DIR}/${robot_name}"
            
            # Copy standard assets if they exist
            for asset in urdf meshes mjcf; do
                if [ -d "${dir}${asset}" ]; then
                    cp -r "${dir}${asset}" "${DEB_DIR}${INSTALL_DIR}/${robot_name}/"
                fi
            done
            
            # Also copy README and other metadata if present
            [ -f "${dir}README.md" ] && cp "${dir}README.md" "${DEB_DIR}${INSTALL_DIR}/${robot_name}/"
        fi
    done
fi

if [ "$BOARD" == "robopi2" ]; then
    for dir in rp1_description/; do
        if [ -d "$dir" ]; then
            robot_name=$(basename "$dir")
            echo ">>> Including robot description: ${robot_name}..."
            mkdir -p "${DEB_DIR}${INSTALL_DIR}/${robot_name}"
            
            # Copy standard assets if they exist
            for asset in urdf meshes mjcf; do
                if [ -d "${dir}${asset}" ]; then
                    cp -r "${dir}${asset}" "${DEB_DIR}${INSTALL_DIR}/${robot_name}/"
                fi
            done
            
            # Also copy README and other metadata if present
            [ -f "${dir}README.md" ] && cp "${dir}README.md" "${DEB_DIR}${INSTALL_DIR}/${robot_name}/"
        fi
    done
fi

# Copy DEBIAN maintainer scripts
[ -f debian/postinst ] && cp debian/postinst "${DEB_DIR}/DEBIAN/"
[ -f debian/postrm ] && cp debian/postrm "${DEB_DIR}/DEBIAN/"
chmod 755 "${DEB_DIR}/DEBIAN/postinst" 2>/dev/null || true
chmod 755 "${DEB_DIR}/DEBIAN/postrm" 2>/dev/null || true

# Generate Control file
# We keep Package: roboto-urdf so it's consistent, but allow board-specific metadata in description
sed -e "s/VERSION_PLACEHOLDER/${DEB_VERSION}/g" \
    debian/control > "${DEB_DIR}/DEBIAN/control"

# Append board info to description
echo " Board-Target: ${BOARD}" >> "${DEB_DIR}/DEBIAN/control"

# Build deb
echo ">>> Executing dpkg-deb build..."
dpkg-deb --root-owner-group --build "${DEB_DIR}"

echo ">>> Success! Generated ${PACKAGE}_${DEB_VERSION}.deb"
