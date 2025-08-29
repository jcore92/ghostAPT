#!/bin/bash

################################################################
#
#   Load Libraries
#
################################################################
# Variables set for program defaults
variables (){
    # Program information
    programname="ghostAPT"
    installername="Installation Manager"
    version="2.3 BETA"
    builddate="built on 8/28/2025"
    ghbranch="main"

    # Terminal rules
    terminalwidth="75"

    # Menu structure rules
    invalidselection="Invalid selection."

    # Installation and temp directory
    localtempdirectory="/tmp/ghostAPT"
    localinstalldirectory="$HOME/ghostAPT"

}

# Figures out if the libraries exist, if not it downloads them.
# Dynamic Library Search & Puller

libraryhandler (){
findlibrarycurrentdirectory="$(ls ./ | grep -o "$libraryname" | head -n 1)"

if [ "$findlibrarycurrentdirectory" == $libraryname ]; then
echo "$libraryname found. Loading...
"
source ./$libraryname
else

echo "$libraryname not found in current directory...
"
findtemplibrary="$(ls $localtempdirectory | grep -o "$libraryname" | head -n 1)"

if [ "$findtemplibrary" == $libraryname ]; then
echo "$libraryname found in $localtempdirectory, Loading library...
"
source $localtempdirectory/$libraryname

else

echo "$libraryname not found in $localtempdirectory...
"

findinstalllibrary="$(ls $localinstalldirectory | grep -o "$libraryname" | head -n 1)"

if [ "$findinstalllibrary" == $libraryname ]; then
echo "$libraryname found in $localinstalldirectory, Loading library...
"
source $localinstalldirectory/$libraryname

else
echo "$libraryname not found in $localinstalldirectory, downloading...
"
curl -L -o $localtempdirectory/$libraryname $remotelibrarylink

echo "
Loading $libraryname...
"
source $localtempdirectory/$libraryname

fi
fi
fi
}

loadlibraries (){

    mkdir $localtempdirectory &>/dev/null

    # Independent Dynamic Variables for Libraries

    libraryname="interface.lib"

    #remotelibrarylink="https://github.com/jcore92/ghostAPT/raw/refs/heads/$ghbranch/interface.lib"

    libraryhandler

    libraryname="data.lib"

    #remotelibrarylink="https://github.com/jcore92/ghostAPT/raw/refs/heads/$ghbranch/data.lib"

    libraryhandler

    clear

}

################################################################
#
#   Preloader
#
################################################################

preloader (){

    errorlogfilename="ghostAPT_ERRORLOG_README.txt"

    # Ubuntu Check
    ubuntucheck (){

    getosname=$(grep -E '^(PRETTY_NAME)=' /etc/os-release | awk -F'="?' '{print $2}' | awk -F' ' '{print $1}' | tr -d '"')

    if [ "$getosname" == Ubuntu ]; then
    #konsole -e bash -c "echo 'Ubuntu is installed.' ; sleep 1"
    echo "Ubuntu base is installed." | center
    isubuntu="✅ Ubuntu base is installed."
    else
    echo "Ubuntu is not installed but is required. Your system man not be compatible with this program. Please install on an Ubuntu-based KDE installation." ; sleep 2
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "Ubuntu is not installed but is required. Your system man not be compatible with this program. Please install on an Ubuntu-based KDE installation. in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Please restart $programname after required packages have been installed.
    "
    isubuntu="❌ Ubuntu base is NOT installed."
    sleep 1
    #exit
    fi

    }

    # KDE Check
    kdecheck (){

    decheck="$(echo $XDG_CURRENT_DESKTOP)"

    if [ "$decheck" == KDE ]; then
    #konsole -e bash -c "echo 'KDE is installed.' ; sleep 1"
    echo "KDE is installed." | center
    iskde="✅ KDE is installed."
    else
    echo "KDE is not installed but is required. Your system man not be compatible with this program. You could try to install KDE packages and it may or may not work, otherwise please install on a fresh install of KDE." ; sleep 2
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The desktop environment 'KDE' is not installed but is required. Your system man not be compatible with this program. You could try to install KDE packages and it may or may not work, otherwise please install on a fresh install of KDE on a Ubuntu-based distribution in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Please restart $programname after required packages have been installed.
    "
    iskde="❌ KDE is NOT installed."
    sleep 1
    #exit
    fi

    }

    # Konsole install checker
    konsolecheck (){

    doeskonsoleexist="$(apt list --installed 2>/dev/null | grep -o konsole | head -n 1)"

    if [ "$doeskonsoleexist" == konsole ]; then
    #konsole -e bash -c "echo 'Konsole is installed.' ; sleep 1"
    echo "Konsole is installed." | center
    haskonsole="✅ Konsole is installed."
    else
    echo "Konsole is not installed but is required. Please restart $programname after required packages have been installed.
    " ; sleep 2
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The package 'Konsole' is not installed. You need to open a terminal window and run the command 'sudo apt install konsole' in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Please restart $programname after required packages have been installed.
    "
    haskonsole="❌ Konsole is NOT installed."
    sleep 2
    #exit
    fi

    }

    # Curl install checker
    curlcheck (){

    doescurlexist="$(apt list --installed 2>/dev/null | grep -o curl | head -n 1)"

    if [ "$doescurlexist" == curl ]; then
    #konsole -e bash -c "echo 'Curl is installed.' ; sleep 1"
    echo "Curl is installed." | center
    hascurl="✅ Curl is installed."
    else
    konsole -e bash -c "echo 'Curl is not installed but is required. Please restart $programname after required packages have been installed.' ; sleep 2"
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The package 'Curl' is not installed. You need to open a terminal window and run the command 'sudo apt install curl' in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Please restart $programname after required packages have been installed.
    "
    hascurl="❌ Curl is NOT installed."
    sleep 1
    konsole -e "sudo apt install curl" &
    #exit
    fi

    }

    # Sign off
    compatibilitycheck (){

    konsole -e bash -c "echo '$isubuntu' ; sleep .5 ; echo '$iskde' ; sleep .5 ; echo '$haskonsole' ; sleep .5 ; echo '$hascurl' ; sleep 1"

    if [ "$isubuntu" == "❌ Ubuntu base is NOT installed." ]; then
    exit
    fi

    if [ "$iskde" == "❌ KDE is NOT installed." ]; then
    exit
    fi

    if [ "$haskonsole" == "❌ Konsole is NOT installed." ]; then
    exit
    fi

    if [ "$hascurl" == "❌ Curl is NOT installed." ]; then
    exit
    fi

    }

    # Libraries and Variables
    ubuntucheck ; kdecheck ; konsolecheck ; curlcheck

    echo "Starting up..." | center

}

################################################################
#
#   installer
#
################################################################
installer (){

# Header, credits, prompt ->
header-installer ; sleep 1 ; credits ; entertocontinue

# Notice ->
clear ; header-installer ; sleep 1 ; installerwarning ; entertocontinue

installermenu

exit

}

################################################################
#
#   Boot Loader
#
################################################################

# Initialization Begins Here:

variables ; loadlibraries

if [ "$1" == installicons ]; then
createprogshortcuts
exit
fi

if [ "$1" == init ]; then
preloader ; sleep .2 ; clear
signatureupdate-force ; checkforupdates-force
exit
fi

if [ "$1" == run ]; then
preloader
#signatureupdate-force ; pullforupdates
ghbranch="main" ; autoupdatechecker ; clear ; runghost
exit
fi

if [ "$1" == testing ]; then
preloader
#signatureupdate-force ; pullforupdates
ghbranch="testing" ; autoupdatechecker ; clear ; runghost
exit
fi

if [ "$1" == install ]; then
installer
else
preloader ; compatibilitycheck
# switch script over to konsole and runs installer
konsole -e "./ghostAPT.sh install"
fi

exit
