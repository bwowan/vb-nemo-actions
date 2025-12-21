#!/bin/bash

# Script to build Debian package for Nemo extensions
# This script creates the package structure and builds the .deb file

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/install"
PACKAGE_NAME="some-nemo-extensions"

# Clean up any previous build
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi

# 1. Create install folder
mkdir -p "$INSTALL_DIR"

# 2. Create path usr/share/nemo/actions inside install folder
mkdir -p "$INSTALL_DIR/usr/share/nemo/actions"

# 3. Copy all project files into usr/share/nemo/actions
# Copy .nemo_action files
cp "$SCRIPT_DIR"/*.nemo_action "$INSTALL_DIR/usr/share/nemo/actions/" 2>/dev/null || true

# Copy scripts directory
if [ -d "$SCRIPT_DIR/scripts" ]; then
    cp -r "$SCRIPT_DIR/scripts" "$INSTALL_DIR/usr/share/nemo/actions/"
    # Make scripts executable
    chmod +x "$INSTALL_DIR/usr/share/nemo/actions/scripts"/*.sh
fi

# 4. Create folder DEBIAN inside install
mkdir -p "$INSTALL_DIR/DEBIAN"

# 5. Create postinst file inside DEBIAN
cat > "$INSTALL_DIR/DEBIAN/postinst" << 'EOF'
#!/bin/bash
echo "Installation of audio and archive extensions for Nemo completed!"
EOF

# Make postinst executable
chmod +x "$INSTALL_DIR/DEBIAN/postinst"

# 6. Create control file inside DEBIAN
cat > "$INSTALL_DIR/DEBIAN/control" << 'EOF'
Package: some-nemo-extensions
Version: 1.0
Section: utils
Priority: optional
Architecture: all
Maintainer: vladimir.balabanov@gmail.com
Description: Some extensions for Nemo (archiver, audio)
 This package contains extensions for the Nemo file manager for working with archives and extracting audio tracks from video files.
EOF

# 7. Build debian package from install folder
cd "$SCRIPT_DIR"
dpkg-deb --build "$INSTALL_DIR" "${PACKAGE_NAME}.deb"

# 8. Remove all except DEB file
rm -rf "$INSTALL_DIR"

echo "Package built successfully: ${PACKAGE_NAME}.deb"