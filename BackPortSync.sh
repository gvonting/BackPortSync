#!/bin/sh
#add -x to run the script in debug mode

#BackPortSync - Backup Portable Sync

#Transfer files to and from main external backup
echo "323 - Desktop to External Drive"
echo "583 - External Drive to Desktop"

#Transfer new phone files from phone to desktop
#To find working directory of an mtp device, go to /run/user/1000/gvfs/ directory and list contents
echo "749 - Phone Files to Desktop Files"

read -p "Choose Option Number: " user_option
#echo $user_option

#The logic for each block is largely the same
if [ 323 -eq $user_option ]
then
    #Have the user confirm option by pressing enter
    read -p "Syncing files from DESKTOP to EXTERNAL DRIVE - Enter to continue" temp_input
    #Test to check if the directory is accessible
    if test -d '/path/to/external/drive/'
    then
    #If the directory is accessible, it will sync the files
    rsync -iavn --no-perms --delete --stats --progress /desktop/path/ /path/to/external/drive/
    else
    #If the directory is not accessible, it will not sync the files
    echo "Double check volume is mounted"
    fi

elif [ 583 -eq $user_option ]
then
    read -p "Syncing files from EXTERNAL DRIVE to DESKTOP - Enter to continue" temp_input
    if test -d '/path/to/external/drive/'
    then
    rsync -iavn --no-perms --delete --stats --progress /path/to/external/drive/ /desktop/path/
    else
    echo "Double check voulume is mounted"
    fi

elif [ 749 -eq $user_option ]
then
    read -p "Syncing files from PHONE FILES to DEKSTOP PHONE FILES - Enter to continue" temp_input
    if test -d '/run/user/1000/gvfs/path/to/phone/'
    then
    rsync -iavn --no-perms --stats --progress "/run/user/1000/gvfs/path/to/phone/" /desktop/path/
    else
    echo "Double check volume is mounted"
    fi

else
    echo "Please run again and input number from available options"

fi

#Some quick rsync documentation
#-----------------------------------------------------
#-a, --archive
#This is equivalent to -rlptgoD. It is a quick way of saying you want recursion and want to preserve almost everything (with -H being a notable omission). The only exception to the above equivalence is when --files-from is specified, in which case -r is not implied.
#Note that -a does not preserve hardlinks, because finding multiply-linked files is expensive. You must separately specify -H.
#------------------------------------------------------


#------------------------------------------------------
#-v, --verbose
#This option increases the amount of information you are given during the transfer. By default, rsync works silently. A single -v gives you information about what files are being transferred and a summary at the end. Two -v options give you information on what files are being skipped and slightly more information at the end. More than two -v options should only be used if you are debugging rsync.
#Note that the names of the transferred files that are output are done using a default --out-format of "%n%L", which tells you only the name of the file and, if the item is a link, where it points. At the single -v level of verbosity, this does not mention when a file gets its attributes changed. If you ask for an itemized list of changed attributes (either --itemize-changes or adding "%i" to the --out-format setting), the output (on the client) increases to mention all items that are changed in any way. See the --out-format option for more details.
#------------------------------------------------------



#------------------------------------------------------
#--no-perms
#This command ignores permission differences in files and directories
#------------------------------------------------------



#------------------------------------------------------
#--delete
#This tells rsync to delete extraneous files from the receiving side (ones that aren’t on the sending side), but only for the directories that are being synchronized. You must have asked rsync to send the whole directory (e.g., "dir" or "dir/") without using a wildcard for the directory's contents (e.g., "dir/*") since the wildcard is expanded by the shell and rsync thus gets a request to transfer individual files, not the files’ parent directory. Files that are excluded from the transfer are also excluded from being deleted unless you use the --delete-excluded option or mark the rules as only matching on the sending side (see the include/exclude modifiers in the FILTER RULES section). Before rsync 2.6.7, this option would have no effect unless --recursive was enabled. Beginning with 2.6.7, deletions also occurs when --dirs (-d) is enabled, but only for directories whose contents are being copied.
#This option can be dangerous if used incorrectly. It is a very good idea to first try a run using the --dry-run option (-n) to see what files are going to be deleted.
#If the sending side detects any I/O errors, then the deletion of any files at the destination will be automatically disabled. This is to prevent temporary filesystem failures (such as NFS errors) on the sending side from causing a massive deletion of files on the destination. You can override this with the --ignore-errors option.
#The --delete option may be combined with one of the --delete-WHEN options without conflict, and --delete-excluded. However, if none of the --delete-WHEN options are specified, rsync chooses the --delete-during algorithm when talking to rsync 3.0.0 or newer, and the --delete-before algorithm when talking to an older rsync. See also --delete-delay and --delete-after.
#----------------------------------------------------------

#----------------------------------------------------------
#--stats
#This tells rsync to print a verbose set of statistics on the file transfer, allowing you to tell how effective rsync's delta-transfer algorithm is for your data.

#The current statistics are as follows:

#    Number of files is the count of all "files" (in the generic sense), which includes directories, symlinks, etc.
#    Number of files transferred is the count of normal files that were updated via rsync's delta-transfer algorithm, which does not include created dirs, symlinks, etc.
#    Total file size is the total sum of all file sizes in the transfer. This does not count any size for directories or special files, but does include the size of symlinks.
#    Total transferred file size is the total sum of all files sizes for only the transferred files.
#    Literal data is how much unmatched file-update data we had to send to the receiver for it to recreate the updated files.
#    Matched data is how much data the receiver got locally when recreating the updated files.
#    File list size is how big the file-list data was when the sender sent it to the receiver. This is smaller than the in-memory size for the file list due to some compressing of duplicated data when rsync sends the list.
#    File list generation time is the number of seconds that the sender spent creating the file list. This requires a modern rsync on the sending side for this to be present.
#    File list transfer time is the number of seconds that the sender spent sending the file list to the receiver.
#    Total bytes sent is the count of all the bytes that rsync sent from the client side to the server side.
#    Total bytes received is the count of all non-message bytes that rsync received by the client side from the server-side. "Non-message" bytes means that we don’t count the bytes for a verbose message that the server sent to us, which makes the stats more consistent.
#------------------------------------------------------


#------------------------------------------------------
#--progress
#This option tells rsync to print information showing the progress of the transfer. This gives a bored user something to watch. Implies --verbose if it wasn’t already specified.
#While rsync is transferring a regular file, it updates a progress line that looks like this: 782448 63% 110.64kB/s 0:00:04
#In this example, the receiver has reconstructed 782448 bytes or 63% of the sender's file, which is being reconstructed at a rate of 110.64 kilobytes per second, and the transfer will finish in 4 seconds if the current rate is maintained until the end.
#These statistics can be misleading if rsync's delta-transfer algorithm is in use. For example, if the sender's file consists of the basis file followed by additional data, the reported rate will probably drop dramatically when the receiver gets to the literal data, and the transfer will probably take longer to finish than the receiver estimated as it was finishing the matched part of the file.
#When the file transfer finishes, rsync replaces the progress line with a summary line that looks like this: 1238099 100% 146.38kB/s 0:00:08 (xfer#5, to-check=169/396)
#In this example, the file was 1238099 bytes long in total, the average rate of transfer for the whole file was 146.38 kilobytes per second over the 8 seconds that it took to complete, it was the 5th transfer of a regular file during the current rsync session, and there are 169 more files for the receiver to check (to see if they are up-to-date or not) remaining out of the 396 total files in the file-list.
#------------------------------------------------------
