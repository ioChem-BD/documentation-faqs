#!/bin/bash
########################################################
###### ioChem-BD software update shell script ##########
########################################################
#Default patch URL values
BASE_UPDATE_URL=https://www.iochem-bd.org/update/
BASE_UPDATE_FILE=update.tar.gz
CUSTOM_UPDATE_URL=
PATCH_UPDATE_URL=
BASE_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JAVA_RELATIVE_PATH=/../jdk1.7.0_55/jre/bin/java

function show_help(){
   echo -e "updater.sh - Utility to download and apply ioChem-BD updates"
   echo
   echo -e "Usage: updater.sh [arguments]"
   echo
   echo -e "Arguments"
   echo -e "\t-h or --help\tDisplay this help"
   echo -e "\t-p name \t\tDownload and apply a single patch by its name. <optional>"
   echo
   echo -e "If -p parameter is undefined, updater tool will download and apply all matching updates until today."
   exit
}
function capture_error(){
    rc=$1
    message=$2
    if [[ $rc != 0 ]]; then
        echo $message
        echo "Please contact ioChem-BD development team at: contact@iochem-bd.org"
        exit $rc;
    fi
}
function clean_house(){
cd $BASE_FOLDER
#Silent delete update files
rm -f -r patches > /dev/null 2>&1
rm update.tar.gz > /dev/null 2>&1

}

#Read parameters from command line
while [ "$#" -gt 0 ]; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
            show_help
            exit
            ;;
        -p)       
            if [ "$#" -gt 1 ]; then
                CUSTOM_UPDATE_URL=$2
                shift 2
                continue
            else
                echo 'ERROR: Must specify URL argument.' >&2
                exit 1
            fi
            ;;
        --)                          # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac
    shift
done

#Build patch URL
if [ -z "$CUSTOM_UPDATE_URL" ]; then   #Not defined URL
  PATCH_UPDATE_URL=$BASE_UPDATE_URL$BASE_UPDATE_FILE
else
   PATCH_UPDATE_URL=$BASE_UPDATE_URL$CUSTOM_UPDATE_URL/$BASE_UPDATE_FILE
fi

#echo "Retrieving update file on "$PATCH_UPDATE_URL
clean_house

wget  --quiet $PATCH_UPDATE_URL
capture_error $? "Error retrieving patch files on $PATCH_UPDATE_URL!"

tar -xf $BASE_FOLDER/update.tar.gz
capture_error $? "Error extracting update patch file on $BASE_FOLDER/update.tar.gz!"

cd patches

if [ -z "$CUSTOM_UPDATE_URL" ]; then
  $BASE_FOLDER$JAVA_RELATIVE_PATH -jar updater.jar $BASE_FOLDER 
else
  $BASE_FOLDER$JAVA_RELATIVE_PATH -jar updater.jar $BASE_FOLDER $CUSTOM_UPDATE_URL
fi
cd ..
clean_house
echo "Update process finished."
