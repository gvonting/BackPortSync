# BackPortSync.sh

Backup Portable Sync - A simple script I use to help backup my files.

### The flow of this script
- This script will print out all the backup options available
- The user will input one of the options using its corresponding three digit code
- If that option exists, details about the backup will be printed and the user will be asked to press enter to confirm the selected backup option. If that option does not exist, the script will ask the user to run the program again and choose an available option
- A check will be done to make sure the external directory is accessible to the system
- If the directory is accessible, the backup command will run. If not, the user will be asked to double check if the volume is mounted
- The script finishes when the backup is completed, or if it has failed any conditional statements


### Why

I have a main external backup drive as well as files on my phone to keep track of. Files on my phone get synced to my desktop regularly, and my desktop files are backed up semi regularly. To avoid having scattered files, possibly in various states of progress, this script helps to keep them all up to date and backed up.

rsync powers the syncing of the files. I decided to use rsync so I would have the option to easily backup files over the network if I needed to in the future.

Choosing the wrong option could result in syncing an out of date backup to a more recent copy, which would overwrite or delete more current copies of files. The three digit code for each syncing option is an attempt to reduce the possibility of human error by requiring more attention to put in the three digits rather than a single digit.

All the options are likely to change in the future as the need to manage my data changes. I have given myself a decent amount of comments in the script to document functionality for when I need to come back to edit it.
