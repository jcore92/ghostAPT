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
    version="2.7 BETA"
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

    #getosname=$(grep -E '^(PRETTY_NAME)=' /etc/os-release | awk -F'="?' '{print $2}' | awk -F' ' '{print $1}' | tr -d '"')
    getosname=$(grep -o "ubuntu" /etc/os-release | head -n 1)

    if [ "$getosname" == ubuntu ]; then
    echo "✅ Ubuntu base is installed.
" | center
    isubuntu="✅ Ubuntu base is installed."
    else
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "Ubuntu is NOT installed but is required. Your system is NOT compatible with this program. Please install on an Ubuntu-based installation in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    echo "Please restart $programname after required packages have been installed.
    "
    isubuntu="❌ Ubuntu base is NOT installed."
    sleep .5
    fi

    }

    # KDE Check
    kdecheck (){

    decheck="$(echo $XDG_CURRENT_DESKTOP)"

    if [ "$decheck" == KDE ]; then
    echo "✅ KDE is installed. $programname is optimized for KDE.
" | center
    iskde="✅ KDE is installed."
    else
    #date | tee -a $HOME/Desktop/$errorlogfilename
    echo "❌ The desktop environment 'KDE' is NOT installed. Your system may NOT be fully compatible with this program as extensive testing has NOT been done on your DE. For the best experience, please install on a fresh install of KDE on a Ubuntu based distribution.
    " | center #| tee -a $HOME/Desktop/$errorlogfilename
    #echo "Please restart $programname after required packages have been installed.
    #"
    #echo "Logging to $HOME/Desktop/$errorlogfilename...
    #"
    iskde="❌ KDE is NOT installed."
    sleep .5
    fi

    }

    # Curl install checker
    curlcheck (){

    doescurlexist="$(apt list --installed 2>/dev/null | grep -o curl | head -n 1)"

    if [ "$doescurlexist" == curl ]; then
    echo "✅ Curl is installed.
" | center
    hascurl="✅ Curl is installed."
    else
    x-terminal-emulator -e "bash -c 'echo Curl is not installed but is required. Please restart $programname after required packages have been installed. ; sleep 2'"
    #konsole -e bash -c "echo 'Curl is not installed but is required. Please restart $programname after required packages have been installed.' ; sleep 2"
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The package 'Curl' is not installed. You need to open a terminal window and run the command 'sudo apt install curl' in order to run $programname.
    " | tee -a $HOME/Desktop/$errorlogfilename
    echo "Logging to $HOME/Desktop/$errorlogfilename
    "
    hascurl="❌ Curl is NOT installed."
    sleep .5
    x-terminal-emulator -e "bash -c 'sudo apt install curl'" &
    #konsole -e "sudo apt install curl" &
    fi

    }

    # Sign off
    compatibilitycheck (){

    if [ "$isubuntu" == "❌ Ubuntu base is NOT installed." ]; then
    exit
    fi

    if [ "$iskde" == "❌ KDE is NOT installed." ]; then
    #exit
    return
    fi

    if [ "$hascurl" == "❌ Curl is NOT installed." ]; then
    exit
    fi

    }

    compatibilitycheck-visual (){

    x-terminal-emulator -e "bash -c 'echo $isubuntu ; sleep .5 ; echo $iskde ; sleep .5 ; echo $hascurl ; sleep 2'"
    #konsole -e bash -c "echo '$isubuntu' ; sleep .5 ; echo '$iskde' ; sleep .5 ; echo '$haskonsole' ; sleep .5 ; echo '$hascurl' ; sleep 1"

    }

    echo "Compability Check:
" | center

    # Libraries and Variables | konsolecheck
    ubuntucheck ; kdecheck ; curlcheck

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
preloader ; compatibilitycheck ; sleep .2 ; clear
#signatureupdate-force
refreshrepositories ; checkforupdates-force
exit
fi

if [ "$1" == run ]; then
preloader ; compatibilitycheck
#signatureupdate-force ; pullforupdates
ghbranch="main" ; autoupdatechecker ; entertocontinue | center ; clear ; runghost
exit
fi

if [ "$1" == testing ]; then
preloader ; compatibilitycheck
#signatureupdate-force ; pullforupdates
ghbranch="testing" ; autoupdatechecker ; entertocontinue | center ; clear ; runghost
exit
fi

if [ "$1" == install ]; then
installer
else
preloader ; compatibilitycheck-visual ; compatibilitycheck
# switch script over to konsole and runs installer
x-terminal-emulator -e "bash -c './ghostAPT.sh install'"
#konsole -e "./ghostAPT.sh install"
fi

exit
