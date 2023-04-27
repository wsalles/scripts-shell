#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
#
#   * Website    : https://wallacesalles.dev/
#   * Author     : Wallace Salles
#   * Mainteiner : Wallace Salles
#
#- VARIABLES -----------------------------------------------------------------------------------------------------------#
SOURCE=$1
DESTINATION=$2
TIMESTAMP=$(date "+%Y%m%d_%H-%M-%S")
LOG_FILE="/var/log/rsync_${TIMESTAMP}.log"
USAGE_MSG="Usage: $(basename $0) <SOURCE> <DESTINATION>.\nPlease, try again..."

#- FUNCTIONS -----------------------------------------------------------------------------------------------------------#
# Loading Default Functions
. $(dirname $0)/functions/others
. $(dirname $0)/functions/checks

rsyncExec() {
	rsync --log-file="${LOG_FILE}" \
		  -aHAXxv \
		  --numeric-ids \
		  --progress \
		  $SOURCE \
		  $DESTINATION		
	
	### You can also do this if the file hasn't grown for 2 minutes...
	# find $SOURCE -mmin +2 -printf %P\\0 \
    #      | rsync --log-file=${LOG_FILE} \
	#              -aHAXxv \
	#			   --progress \
	#			   --files-from=- \
	#			   --from0 $SOURCE $DESTINATION
        
}

#- TESTS ---------------------------------------------------------------------------------------------------------------#
# Make sure you entered the src and dst
check_args $SOURCE $DESTINATION

#- RUN -----------------------------------------------------------------------------------------------------------------#
# Create a lock file to prevent overhead
create_lock;

# And then, running RSync
rsyncExec;

# To finish, the lock file is removed
remove_lock;

#-----------------------------------------------------------------------------------------------------------------------#