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
    builddate="built on 9/11/2025"
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
wget -O "$localtempdirectory/$libraryname" "$remotelibrarylink"
#curl -L -o $localtempdirectory/$libraryname $remotelibrarylink

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
    echo "❌ Ubuntu base is NOT installed.
$programname is not compatible with your installed OS.
" | center
    isubuntu="❌ Ubuntu base is NOT installed."
    fi

    }

    # KDE Check
    kdecheck (){

    decheck="$(echo $XDG_CURRENT_DESKTOP)"

    if [ "$decheck" == KDE ]; then
    echo "✅ KDE is installed. ($programname has been tested with KDE.)
" | center
    iskde="✅ KDE is installed."
    else
    echo "⚠️  The desktop environment 'KDE' is NOT detected.
$programname hasn't been tested extensively with your
desktop environment and you may experience
visual glitches or minor bugs.
" | center
    iskde="❌ KDE is NOT installed."
    fi

    }

    # wget install checker
    wgetcheck (){

    #doeswgetexist="$(apt list --installed 2>/dev/null | grep -o wget | head -n 1)"

    doeswgetexist="$(apt list --installed 2>/dev/null | grep -E '^wget/' | grep -o "wget" | head -n 1)"

    if [ "$doeswgetexist" == wget ]; then
    echo "✅ wget is installed.
" | center
    hascurl="✅ wget is installed."
    else
    echo "❌ wget is NOT installed.
" | center
    haswget="❌ wget is NOT installed."
    fi

    }

    # zenity install checker
    zenitycheck (){

    #doeszenityexist="$(apt list --installed 2>/dev/null | grep -o zenity | head -n 1)"

    doeszenityexist="$(apt list --installed 2>/dev/null | grep -E '^zenity/' | grep -o "zenity" | head -n 1)"

    if [ "$doeszenityexist" == zenity ]; then
    echo "✅ zenity is installed.
" | center
    haszenity="✅ zenity is installed."
    else
    echo "❌ zenity is NOT installed.
" | center
    haszenity="❌ zenity is NOT installed."
    fi

    }

    # Sign off
    compatibilitycheck (){

    if [ "$isubuntu" == "❌ Ubuntu base is NOT installed." ]; then
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "Ubuntu is NOT installed but is required. Your system is NOT compatible with this program. Please install on an Ubuntu-based installation in order to run $programname.
" | tee -a $HOME/Desktop/$errorlogfilename
    echo "Logging to $HOME/Desktop/$errorlogfilename
"
    sleep 7
    exit
    fi

    if [ "$haswget" == "❌ wget is NOT installed." ]; then
    x-terminal-emulator -e "bash -c 'echo wget is not installed but is required to run $programname. Attempting to install package now... ; sleep 2 ; sudo apt install wget'"
    sleep .5
    #x-terminal-emulator -e "bash -c 'sudo apt install wget'"
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The package 'wget' is not installed. You need to open a terminal window and run the command 'sudo apt install wget' in order to run $programname.
" | tee -a $HOME/Desktop/$errorlogfilename
    echo "Logging to $HOME/Desktop/$errorlogfilename
"
    echo "You must restart $programname after installing wget.
"
    sleep 7
    exit
    fi

    if [ "$haszenity" == "❌ zenity is NOT installed." ]; then
    x-terminal-emulator -e "bash -c 'echo zenity is not installed but is required to run $programname. Attempting to install package now... ; sleep 2 ; sudo apt install zenity'"
    sleep .5
    #x-terminal-emulator -e "bash -c 'sudo apt install zenity'"
    date | tee -a $HOME/Desktop/$errorlogfilename
    echo "The package 'zenity' is not installed. You need to open a terminal window and run the command 'sudo apt install zenity' in order to run $programname.
" | tee -a $HOME/Desktop/$errorlogfilename
    echo "Logging to $HOME/Desktop/$errorlogfilename
"
echo "You must restart $programname after installing zenity.
"
    sleep 7
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
    ubuntucheck ; kdecheck ; wgetcheck ; zenitycheck ; compatibilitycheck

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

installationmanager () {

checkifinstalledthenrun (){

    if [ "$isproginstalled" == ghostAPT ]; then

        instman-installed

        else

        prognotice

        instman

    fi

}

instman () {

cleanseversion="$(echo "$version" | head -n 1)"

# Variable Menu Names
installprogrammenu="Install $programname $cleanseversion"
exitprogrammenu="Exit $programname $installername"

# Define functions to run based on selection
install_option1() {
    echo "Installing $programname..." | center
    # Add your command here
    sleep 5
    x-terminal-emulator -e "bash -c './ghostAPT.sh install'"
}

install_option2() {
    zenity --error --text="$programname $installername has been exited without any changes." --timeout=2 &>/dev/null
    echo "User canceled. Exiting." | center
    exit
}

# Show Zenity list dialog
choice=$(zenity --list \
    --title="$programname $installername $version" \
    --text="Please choose an option below:" \
    --width=550 --height=550 \
    --column="Options" \
    "$installprogrammenu" \
    "$exitprogrammenu" \
    --ok-label="Select" \
    --cancel-label="Exit $installername" 2>/dev/null)

# Capture exit status
if [ $? -eq 0 ]; then
    case "$choice" in
        "$installprogrammenu")
            install_option1
            exit
            ;;
        "$exitprogrammenu")
            install_option2
            exit
            ;;
    esac
else
    zenity --error --text="$programname $installername has been exited without any changes." --timeout=2 &>/dev/null
    echo "User canceled. Exiting." | center
    exit 0
fi

}

instman-installed () {

cleanseversion="$(echo "$whichverinstalled" | head -n 1)"

# Variable Menu Names
uninstallprogrammenu="Uninstall $programname $cleanseversion"
exitprogrammenu="Exit $programname $installername"

# Define functions to run based on selection
install_option1() {
    echo "Uninstalling $programname..." | center
    # Add your command here
    x-terminal-emulator -e "bash -c 'ghostAPT uninstall'"
    exit
}

install_option2() {
    zenity --error --text="$programname $installername has been exited without any changes." --timeout=2 &>/dev/null
    echo "User canceled. Exiting." | center
    exit
}

# Show Zenity list dialog
choice=$(zenity --list \
    --title="$programname $installername $version" \
    --text="Please choose an option below:" \
    --width=550 --height=550 \
    --column="Options" \
    "$uninstallprogrammenu" \
    "$exitprogrammenu" \
    --ok-label="Select" \
    --cancel-label="Exit $installername" 2>/dev/null)

# Capture exit status
if [ $? -eq 0 ]; then
    case "$choice" in
        "$uninstallprogrammenu")
            install_option1
            exit
            ;;
        "$exitprogrammenu")
            install_option2
            exit
            ;;
    esac
else
    zenity --error --text="$programname $installername has been exited without any changes." --timeout=2 &>/dev/null
    echo "User canceled. Exiting." | center
    exit 0
fi

}

prognotice () {

echo "⚠️ Disclaimer

Use $programname and it's Ghost Scripts responsibly as scripts enable PERMANENT CHANGES to your Linux installation.

If you are a new user, it is recommended to use $programname in a virtual machine until you are familiar with how it's scripts operate." | if zenity --text-info --width=500 --height=350 --title="$programname $installername $version" --ok-label="Next" --cancel-label="Exit $installername" &>/dev/null ; then
# User clicked OK
#zenity --info --text="You clicked Continue. Proceeding..." --timeout=2 &>/dev/null
#echo "User chose to continue."
# Add your next steps here (e.g., run installation)
echo " "
else
# User clicked Cancel or closed the window
zenity --error --text="$programname $installername has been exited without any changes." --timeout=2 &>/dev/null
echo "User canceled. Exiting." | center
exit 1
fi

}

proginfo () {
echo "------------
--About Program:
------------$programname is a Script Running Engine.
------------Use scripts transparently by reviewing
------------the exact code before it's actually run
------------while being safeguarded with a script
------------Trust engine using SHA256 Signatures.
------------
------------Easily setup a fresh Linux installation
------------to taste, quickly and effortlessly. You
------------can edit scripts or even make your own.
------------
--Developer(s):
------------JCore92
------------
--Website:
------------https://www.jcorestudios.com/
------------https://github.com/jcore92/ghostAPT
------------
--License:
------------GNU General Public License v2.0
------------
------------(If forked, please give credit to the
------------original project and developer. If no
------------credit is included you are not allowed
------------to use any original names or likeness.)
------------
--Notes:
------------Built for Kubuntu Focus.
------------Compatible with any Ubuntu based
------------distribution.*
------------
--Disclaimer:
------------We hold no liability for any negative
------------outcomes to you or your devices. ALWAYS
------------READ SCRIPTS BEFORE YOU RUN THEM!
------------
------------By proceeding, you agree to these terms.
------------" | column -t -s '-' | if zenity --text-info --width=550 --height=650 --title="$programname $installername $version" --ok-label="Next" --cancel-label="Exit $installername" &>/dev/null ; then
    # User clicked OK
    #zenity --info --text="You clicked Continue. Proceeding..." --timeout=3
    #echo "User chose to continue."
    # Add your next steps here (e.g., run installation)
    echo "System Status:
" | center
    installationstatus
    checkifinstalledthenrun
else
    # User clicked Cancel or closed the window
    zenity --error --text="$programname $installername has been exited without any changes." --timeout=3 &>/dev/null
    echo "User canceled. Exiting." | center
    exit 1
fi

}


progsplash () {
ghostinstmanlogo=(
  "
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡴⢻⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣿⡦⠀⣸⣀⣼⣧⠀⢹⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠈⢻⣿⠀⣿⣿⠀⣿⣶⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠙⣠⣭⣝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡟⡤⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣳⠌⠑⠩⠐⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⡿⣿⣟⣿⡻⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡙⢻⣿⣿⣿⣿⣟⣷⢻⡞⣷⠳⣝⠧⡄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⢿⣳⠿⣜⢫⠙⢮⡛⣦⠙⠈⠣⢀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠿⣝⣻⢎⡅⢢⠀⠙⢦⡛⢤⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠮⡱⢋⡘⠄⠀⠀⠀⠘⠢⠍⡄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁⠀⠀⠈⠀⠀⠀⠀⠀⠈⠁⠄⠀⠀

  Loading $programname $installername..."
  )

zenity --info --text="$ghostinstmanlogo" --timeout=2 &>/dev/null

}


progsplash ; proginfo

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
#signatureupdate-force
refreshrepositories ; checkforupdates-force
exit
fi

if [ "$1" == run ]; then
preloader
#signatureupdate-force ; pullforupdates
ghbranch="main" ; autoupdatechecker ; entertocontinue | center ; clear ; runghost
exit
fi

if [ "$1" == testing ]; then
preloader
#signatureupdate-force ; pullforupdates
ghbranch="testing" ; autoupdatechecker ; entertocontinue | center ; clear ; runghost
exit
fi

if [ "$1" == manage ]; then
installationmanager
exit
fi

if [ "$1" == uninstall ]; then
uninstaller
fi

if [ "$1" == install ]; then
installation
#installer
#installationmanager
else
preloader #compatibilitycheck-visual
# switch script over to konsole and runs installer
installationmanager
#x-terminal-emulator -e "bash -c './ghostAPT.sh install'"
#konsole -e "./ghostAPT.sh install"
fi

exit
