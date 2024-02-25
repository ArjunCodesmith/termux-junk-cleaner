#!/bin/bash

#!/bin/bash

##   Termux-Junk-Cleaner    :       Junk cleaner
##   Author                 :       ArjunCodesmith
##   Version                :       0.2.0
##   Github                 :       https://github.com/ArjunCodesmith




##    Termux-Junk-Cleaner  Copyright (C) 2024  ArjunCodesmith (https://github.com/ArjunCodesmith)



author="ArjunCodesmith"
version="v0.2.0"

LOG_FILE="cleanup_log.txt"

# Set current date in log file
echo -e "\e[1;34m-------------------------------\e[0m" >> "$LOG_FILE"
echo -e "\e[1;34mDate: $(date)\e[0m" >> "$LOG_FILE"
echo -e "\e[1;34m-------------------------------\e[0m" >> "$LOG_FILE"

# Function to simulate typing effect
typing_effect() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.03
    done
 echo
}

#installation function
# install() {}


 echo -e "\e[1;31m
         ┌─────────┐     ┌─────────┐
       ──────│\e[94m [▓▓▓▓▓▓▓▓░░░░░] \e[1;31m│──────
 ─────────── │  \e[38;5;83m TΞRMUX JΞNK \e[1;31m  │ ───────────
 ─────────── │ \e[38;5;83m C L E A N E R \e[1;31m │ ───────────
       ──────│\e[94m [░░░░░▓▓▓▓▓▓▓▓] \e[1;31m│──────
         └─────────┘     └─────────┘\e[0m"
echo -e "              \033[40;38;5;83m Version \033[30;48;5;83m $version \033[0m"
echo -e "         \033[30;48;5;83m    Copyright \033[40;38;5;83m ${author}\033[0m"
 #echo -e "  \033[2;31;40m Advanced Junk Cleanup Tool by Arjun V.  \033[0m"
 echo -e " \e[1;34m--------------------------------------------\e[0m"



cleanup_options() {
    read -p $'\n\e[1;35m Do you want to clean unnecessary logs? (y/n): \e[0m' clean_logs
    read -p $'\e[1;35m Do you want to clean cache files? (y/n): \e[0m' clean_cache
    read -p $'\e[1;35m Do you want to clean cached packages? (y/n): \e[0m' clean_packages
    read -p $'\e[1;35m Do you want to remove unnecessary or unused packages? (y/n): \e[0m' clean_unused_packages
    read -p $'\e[1;35m Do you want to clean temporary files? (y/n): \e[0m' clean_temp
    read -p $'\e[1;35m Do you want to clean temporary backup files? (y/n): \e[0m' clean_temp_backup
}

# Function to clean cache files
clean_cache() {
    typing_effect $'\n\e[1;32mCleaning cache files...\e[0m'
    deleted_cache=$(find /data/data/com.termux/files/home/.cache/ -type f -delete -print 2>/dev/null)
    deleted_app_cache=$(find /data/data/com.termux/cache -type f -delete -print 2>/dev/null)
    echo "$deleted_cache" >> "$LOG_FILE"
    echo "$deleted_app_cache" >> "$LOG_FILE"
}

# Function to clean cached packages
clean_cached_packages() {
    typing_effect $'\n\e[1;32mCleaning cached packages...\e[0m'
    deleted_packages=$(apt-get clean 2>/dev/null | grep "cleaned")
    echo "$deleted_packages" >> "$LOG_FILE"
}

# Function to remove unnecessary or unused packages
remove_unused_packages() {
    typing_effect $'\n\e[1;32mRemoving unnecessary or unused packages...\e[0m'
    removed_unused_packages=$(apt autoremove -y 2>/dev/null)
    echo "$removed_unused_packages" >> "$LOG_FILE"
}

# Function to clean temporary files
clean_temp_files() {
    typing_effect $'\n\e[1;32mCleaning temporary files...\e[0m'
    deleted_temp=$(find /data/data/com.termux/files/home/tmp/ -type f -delete -print 2>/dev/null)
    echo "$deleted_temp" >> "$LOG_FILE"
}

# Function to clean temporary backup files
clean_temp_backup_files() {
    typing_effect $'\n\e[1;32mCleaning temporary backup files...\e[0m'
    deleted_temp_backup=$(find /data/data/com.termux/files/home/ -type f -name "*.bak" -delete -print 2>/dev/null)
    echo "$deleted_temp_backup" >> "$LOG_FILE"
}

# Function to clean unnecessary logs
clean_unnecessary_logs() {
    typing_effect $'\n\e[1;32mCleaning unnecessary logs...\e[0m'
    # no need to remove the file just replace all data with new one using singal greater than
    echo -e "\n\\e[1;34m-----------------------------------
Date: $(date)\e[0m
\e[1;34m-----------------------------------
\e[1;31mOld cleanup logs deleted." > "$LOG_FILE"
    deleted_logs=$(find /data/data/com.termux/files/home -type f -name "*.log" -delete -print 2>/dev/null)
    echo "$deleted_logs" >> "$LOG_FILE"
}

success_msg() {
    echo -e "\n\e[40;38;5;83mCleanup completed. Details logged in ${LOG_FILE} \e[0m\n" 
}
# Function to clean all junks
clean_all() {
    clean_unnecessary_logs
    clean_cache
    clean_cached_packages
    remove_unused_packages
    clean_temp_files
    clean_temp_backup_files
}

check_and_clean() {
    # Check if logs cleanup is selected
    if [[ "$clean_logs" == "y" || "$clean_logs" == "Y" ]]; then
        clean_unnecessary_logs
    else
        echo -e "\n\e[1;33mSkipped cleaning unnecessary logs.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning unnecessary logs.\e[0m \n" >> "$LOG_FILE"
    fi

    # Check if cache cleanup is selected
    if [[ "$clean_cache" == "y" || "$clean_cache" == "Y" ]]; then
        clean_cache
    else
        echo -e "\n\e[1;33mSkipped cleaning cache files.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning Cache.\e[0m \n" >> "$LOG_FILE"
    fi

    # Check if cached packages cleanup is selected
    if [[ "$clean_packages" == "y" || "$clean_packages" == "Y" ]]; then
        clean_cached_packages
    else
        echo -e "\n\e[1;33mSkipped cleaning cached packages.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning cached packages.\e[0m \n" >> "$LOG_FILE"
    fi

    # Check if unused packages cleanup is selected
    if [[ "$clean_unused_packages" == "y" || "$clean_unused_packages" == "Y" ]]; then
        remove_unused_packages
    else
        echo -e "\n\e[1;33mSkipped removing unnecessary or unused packages.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning unnecessary or unused packages.\e[0m \n" >> "$LOG_FILE"
    fi

    # Check if temporary files cleanup is selected
    if [[ "$clean_temp" == "y" || "$clean_temp" == "Y" ]]; then
        clean_temp_files
    else
        echo -e "\n\e[1;33mSkipped cleaning temporary files.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning temporary files.\e[0m \n" >> "$LOG_FILE"
    fi

    # Check if temporary backup files cleanup is selected
    if [[ "$clean_temp_backup" == "y" || "$clean_temp_backup" == "Y" ]]; then
        clean_temp_backup_files
    else
        echo -e "\n\e[1;33mSkipped cleaning temporary backup files.\e[0m"
	echo -e "\n\e[1;33mSkipped cleaning temporary backup files.\e[0m \n" >> "$LOG_FILE"
    fi
}

#uninstall() {}

# Function to display help
display_help() {
    echo -e "\n\e[1;34mUsage:\e[0m"
    echo -e "\e[1;33m  clean [OPTIONS]\e[0m"
    echo -e "\n\e[1;34mOptions:          Meaning:\e[0m"
    echo -e "\e[1;33m  -h, --help       Display this help message\e[0m"
    echo -e "\e[1;33m  -c               Clean cache files\e[0m"
    echo -e "\e[1;33m  -p               Clean cached packages\e[0m"
    echo -e "\e[1;33m  -n               Remove unnecessary or unused packages\e[0m"
    echo -e "\e[1;33m  -t               Clean temporary files\e[0m"
    echo -e "\e[1;33m  -b               Clean temporary backup files\e[0m"
    echo -e "\e[1;33m  -l               Clean unnecessary logs\e[0m"
    echo -e "\e[1;33m  -a               Clean all type of junks\e[0m"
    echo -e "\n\e[1;34mExamples:\e[0m"
    echo -e "\e[1;33m  clean -c\e[0m   # Clean cache."
    echo -e "\n\e[1;34mNote:\e[0m"
    echo -e "\e[1;33m  You can combine multiple options, e.g., clean -c -p -t\e[0m\n"
}

# Check for options and execute corresponding cleanup functions
options=("$@")

for option in "${options[@]}"; do
    case $option in
        "-h" | "--help")
            display_help
            exit 0
            ;;
        "-a")
            clean_all
	    ;;
        "-c")
            clean_cache
	    ;;
        "-p")
            clean_cached_packages
	    ;;
        "-n")
            remove_unused_packages
	    ;;
        "-t")
            clean_temp_files
	    ;;
        "-b")
            clean_temp_backup_files
	    ;;
	"-l")
            clean_unnecessary_logs
	    ;;
           *)
	    echo -e "\n\e[1;31mInvalid option.\e[1;33m Use '$0 -h' for help.\e[0m \n"
	    echo -e "\e[1;31mInvalid option.\e[1;33m Use '$0 -h' for help.\e[0m\n" >> "$LOG_FILE"
	    exit 1
            ;;
    esac
done

# Default condition when no argument  chosen
    if [ "$#" == "0" ]; then
	cleanup_options
        check_and_clean
    fi

# Default actions after cleanup compled.

  success_msg
