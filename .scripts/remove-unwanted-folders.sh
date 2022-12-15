#!/bin/bash
# Name: remove-unwanted-folders.sh
# Purpose: Remove snapd and GPUCache folders
# Author: Tales
# ------
function remove_unwanted_folders(){
	echo "Running post-script as $USER!"
	echo "Removing unwanted folders..."
	rm -rf $HOME/snap
	rm -rf $HOME/GPUCache
	echo "Done."
}
# main #
remove_unwanted_folders
