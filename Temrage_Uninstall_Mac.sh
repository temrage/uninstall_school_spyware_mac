#!/bin/bash

# Prompt for sudo at the beginning of the script
if [ "$EUID" -ne 0 ]; then
  echo "This script requires sudo privileges. Please enter your password."
  sudo "$0" "$@"
  exit
fi

# Remove Proxy settings, including PAC (Automatic Proxy Config) settings
echo "Removing proxy settings..."
network_services=$(networksetup -listallnetworkservices | grep -v "*")

for service in $network_services; do
  echo "Checking $service for proxy settings..."
  
  # Clear HTTP and HTTPS proxies
  networksetup -setwebproxy "$service" "" "0"
  networksetup -setsecurewebproxy "$service" "" "0"
  networksetup -setwebproxystate "$service" off
  networksetup -setsecurewebproxystate "$service" off
  
  # Clear PAC (Automatic Proxy Config) setting
  networksetup -setautoproxyurl "$service" ""
  networksetup -setautoproxystate "$service" off
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

# Remove MDM profile if present
echo "Checking for MDM profile..."
mdm_profile=$(profiles -P | grep "name: MDM Profile" | awk -F: '{print $2}' | xargs)
if [ -n "$mdm_profile" ]; then
  profiles -R -p "$mdm_profile"
  echo "MDM profile removed."
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

# Restart Mac
echo "Restarting Mac to complete the process..."
osascript -e 'tell app "System Events" to restart'

echo "Process complete."
