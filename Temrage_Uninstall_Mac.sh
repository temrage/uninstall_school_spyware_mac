#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check for sudo privileges
check_sudo() {
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo privileges. Please run again with sudo."
    exit 1
  fi
}

# Check for sudo privileges
check_sudo

# Remove Proxy settings, including PAC (Automatic Proxy Config) settings
echo "Removing proxy settings..."
network_services=$(networksetup -listallnetworkservices | grep -v "*")

# Iterate over each network service
for service in $network_services; do
  echo "Checking $service for proxy settings..."

  # Check if the service is valid
  if networksetup -getwebproxy "$service" >/dev/null 2>&1; then
    # Clear HTTP and HTTPS proxies
    networksetup -setwebproxy "$service" "" "0"
    networksetup -setsecurewebproxy "$service" "" "0"
    networksetup -setwebproxystate "$service" off
    networksetup -setsecurewebproxystate "$service" off
    
    # Clear PAC (Automatic Proxy Config) setting
    networksetup -setautoproxyurl "$service" ""
    networksetup -setautoproxystate "$service" off
    echo "Proxy settings removed for $service."
  else
    echo "No proxy settings to remove for $service."
  fi
done
echo "Proxy settings, including PAC, removed."

# Remove Securly Certificate
echo "Removing Securly certificate..."
securly_cert=$(security find-certificate -a -c "securly.com" /Library/Keychains/System.keychain | grep "alis" | awk -F\" '{print $4}')
if [ -n "$securly_cert" ]; then
  security delete-certificate -c "$securly_cert" /Library/Keychains/System.keychain
  echo "Securly certificate removed."
else
  echo "No Securly certificate found."
fi

# Remove any MDM profiles
echo "Checking for MDM profiles..."
mdm_profiles=$(profiles -P | grep "attribute: name" | awk -F': ' '{print $2}' | grep -i "MDM")

if [ -n "$mdm_profiles" ]; then
  echo "MDM profiles found. Removing..."
  while IFS= read -r profile; do
    profile_id=$(profiles -P | grep -B 1 "$profile" | head -1 | awk -F': ' '{print $2}')
    echo "Removing profile: $profile_id ($profile)"
    profiles -R -p "$profile_id"
  done <<< "$mdm_profiles"
  echo "MDM profiles removed."
else
  echo "No MDM profile found."
fi

# Remove ManageEngine Folder
manage_engine_path="/Library/ManageEngine"
if [ -d "$manage_engine_path" ]; then
  echo "Removing ManageEngine folder..."
  rm -rf "$manage_engine_path"
  echo "ManageEngine folder removed."
else
  echo "No ManageEngine folder found."
fi

# Empty Trash
echo "Emptying Trash..."
rm -rf ~/.Trash/*
echo "Trash emptied."


echo "Process complete."
