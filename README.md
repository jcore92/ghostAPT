ghostAPT is a Script Running Engine.
=====================================================================

The project started because I wanted a way to quickly restore fresh Linux installs to a usable state with minimal to no configuration yet be transparent enough to know what was going on in my computer.

ghostAPT utilizes SHA-256 signatures and has a trust system implemented in order to open it's Ghost Scripts, so if there is a script that is unknown, it's not trusted until you intervene and it will let you know before proceeding. It also uses the cat command to display the Ghost Script completely before running the script and the Ghost Script must be properly formatted with our code occupying the first 4 lines of a Ghost Script or else it is considered insecure and will not run do to security. You can have peace of mind configuring your system quickly allowing you to get back to computing on Linux!

Ghost Scripts come in many forms but the file must end in a '.ghost' extension and be placed inside a Category (folder) in order for ghostAPT to detect the Ghost Script inside the ghostAPT install directory. You can utilize our first party Ghost Scripts from within ghostAPT or you can manually download/add third party Ghost Scripts so long as they follow the prerequisites above and they are placed in the installation directory correctly: /home/YOU/ghostAPT/CATEGORY/script.ghost

You can name the folder (Category) or Ghost Scripts to whatever but to be safe keep naming conventions simple. When naming scripts, due to the signature engine, you should NOT include brackets '[' or ']' in the script name inside your script or the filename of your script or else ghostAPT will grab incorrect metadata when you run your scripts.

The Ghost Team Script Collection
=====================================================================
This is the standard repository that comes shipped with ghostAPT. You are free to fork this repo and modify if to your taste. It should server as an amazing starting point for setting up your own repositories.

https://github.com/jcore92/The-Ghost-Team-Script-Collection

Compatibility
=====================================================================
ghostAPT will work on any Ubuntu based distribution.

You will need to install:
Ubuntu-based Distro, wget, zenity.

Features
=====================================================================
Run from the terminal:

    #This runs the main program
    ghostAPT run

    #This runs the installation manager.
    ghostAPT manage

Start menu/desktop icon:

    right click either icon to:
    -Run ghostAPT
    -Create ghostAPT icons
    -Manage ghostAPT installation

Currently Known Bugs
=====================================================================
* Will update this with outstanding bugs as I find them...

Installation
=====================================================================
Download the .zip file here on GitHub. (Only use the official version here on GitHub as we DO NOT utilize any other outlets to distribute ghostAPT.)

Extract the .zip file.

Make sure that ghostAPT.sh is executable. (If you don't know how to do this search: 'How to make bash shell scripts executable?')

KDE:
        
    Double click on ghostAPT.sh and execute it.

Gnome-based:
        
    Right click ghostAPT.sh and Run as Program.

Terminal:
ensure that you are in the same directory as ghostAPT.sh.

run this command:

    bash ghostAPT.sh

Follow the Installation Manager and enjoy!
