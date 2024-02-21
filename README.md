# BackPortSync.sh

Backup Portable Sync - A simple script I use to help backup my files.

### The flow of this script
- This script will print out all the sync options available
- The user will input one of options using its corresponding three digit code
- If that option exists, it will be printed and the user will be asked to press enter as a double check. If not it will ask the user to run the program again and choose an available option
- A check will be done to make sure the directory is accessible to the system
- If the directory is accessible, the rsync command will run. If not, the user will be asked to double check if the volume is mounted
- The script finishes when the sync is completed, or if it has failed the conditional statements


### Why

I have a main external backup I use for most files, a small usb drive I take when I am on the go and want to do some work, and the files on my phone. Often, I find myself editing files on both my desktop and external storage. To avoid having scattered copies of files in various states of progress, this script helps to keep them all up to date.

rsync powers the syncing of the files. I decided to use rsync so I would have the option to easily sync files over the network if I needed to in the future.

Choosing the wrong option could result in syncing an out of date backup to a more recent copy, which would overwrite or delete more current copies of files. The three digit code for each syncing option is an attempt to reduce the possibility of human error by requiring more attention to put in the three digits rather than a single digit.

When dealing with files on my phone, I have miscellaneous files and photo/video. Two separate sync options needed to be made to prevent data loss when syncing photo/video and miscellaneous files at the same time because of the way I treat these two different groups of files. Miscellaneous files are typically edited on my desktop, and they would be overwritten by older versions if I try to sync photo/video and miscellaneous files from my phone to the desktop at the same time.

All the options are likely to change in the future as the need to manage my data on different media and devices change. I have tried to give myself a decent enough amount of comments in the script for when I need to come back to edit it.