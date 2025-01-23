#!/bin/bash

# Enable debugging
set -x

# Variables for package URLs and file paths
VPN_PKG_URL="https://<your_storage_account>.blob.core.windows.net/<container>/cisco-secure-client-macos-5.1.7.80-core-vpn-webdeploy-k9.pkg"
UMBRELLA_PKG_URL="https://<your_storage_account>.blob.core.windows.net/<container>/cisco-secure-client-macos-5.1.7.80-umbrella-webdeploy-k9.pkg"
VPN_PKG_NAME="cisco-secure-client-macos-5.1.7.80-core-vpn-webdeploy-k9.pkg"
UMBRELLA_PKG_NAME="cisco-secure-client-macos-5.1.7.80-umbrella-webdeploy-k9.pkg"
ORGINFO_URL="https://<your_blob_or_web_url>/Orginfo.json"

# Function to download and install a package
download_and_install() {
    local url=$1
    local pkg_name=$2
    local dest="/tmp/$pkg_name"

    echo "Downloading $pkg_name..."
    curl -L -o "$dest" "$url"
    if [ $? -ne 0 ]; then
        echo "Failed to download $pkg_name."
        exit 1
    fi

    echo "Installing $pkg_name..."
    chmod +r "$dest"
    sudo installer -verbose -pkg "$dest" -target /
    if [ $? -ne 0 ]; then
        echo "Failed to install $pkg_name."
        exit 1
    fi

    echo "$pkg_name installed successfully."
}

# Check if Cisco Secure Client VPN is installed
if [ -d "/opt/cisco/secureclient/vpn" ]; then
    echo "Cisco Secure Client VPN is already installed."
else
    download_and_install "$VPN_PKG_URL" "$VPN_PKG_NAME"
fi

# Check if Cisco Umbrella is installed
if [ -d "/opt/cisco/secureclient/umbrella" ]; then
    echo "Cisco Umbrella is already installed."
else
    download_and_install "$UMBRELLA_PKG_URL" "$UMBRELLA_PKG_NAME"
fi

# Disable VPN functionality
echo "Disabling VPN functionality..."
VPN_DISABLE_SCRIPT="/tmp/disable_vpn.sh"
cat <<'EOF' > "$VPN_DISABLE_SCRIPT"
#!/bin/bash

file_name="VPNDisable_ServiceProfile.xml"
xml_content='<?xml version="1.0" encoding="utf-8"?>
<AnyConnectProfile xmlns="http://schemas.xmlsoap.org/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://schemas.xmlsoap.org/encoding/ AnyConnectProfile.xsd">
  <ClientInitialization>
    <ServiceDisable>true</ServiceDisable>
  </ClientInitialization>
</AnyConnectProfile>'

destination_dir="/opt/cisco/secureclient/vpn/profile/"
mkdir -p "$destination_dir"
echo "$xml_content" > "$destination_dir$file_name"
EOF

sudo bash "$VPN_DISABLE_SCRIPT"
if [ $? -eq 0 ]; then
    echo "VPN functionality disabled successfully."
else
    echo "Failed to disable VPN functionality."
    exit 1
fi

# Configure Umbrella with Orginfo.json
echo "Configuring Umbrella..."
UMBRELLA_CONFIG_SCRIPT="/tmp/configure_umbrella.sh"
cat <<EOF > "$UMBRELLA_CONFIG_SCRIPT"
#!/bin/bash

file_url="$ORGINFO_URL"
destination_dir="/opt/cisco/secureclient/umbrella/"
sudo mkdir -p "\$destination_dir"
sudo curl -L -o "\$destination_dir/Orginfo.json" "\$file_url"
EOF

sudo bash "$UMBRELLA_CONFIG_SCRIPT"
if [ $? -eq 0 ]; then
    echo "Umbrella configured successfully."
else
    echo "Failed to configure Umbrella."
    exit 1
fi

# Cleanup temporary files
rm -f "/tmp/$VPN_PKG_NAME" "/tmp/$UMBRELLA_PKG_NAME" "$VPN_DISABLE_SCRIPT" "$UMBRELLA_CONFIG_SCRIPT"

echo "Deployment completed successfully."
