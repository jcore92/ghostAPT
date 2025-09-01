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
Currently, this will only work on an Ubuntu-based distro running KDE.

This decision was made because it was designed for it. I don't like many of the other DE's out there BUT, I do understand there are others out there who like something else. A goal down the line is to make it so you only need Konsole and an Ubuntu-based distro to be able to run ghostAPT. This will take time, effort, and a lot of testing and I am the only developer to-date so if it isn't too much of a burden I will hopefully get around to it.

You will need to install:
Curl, Konsole, KDE, Ubuntu-based Distro

Features
=====================================================================
Run from the terminal:

    #This runs the main program
    ghostAPT run

    #These both run the installation manager.
    ghostAPT
    ghostAPT install

Start menu/desktop icon:

    right click either icon to:
    -Run ghostAPT
    -Manage ghostAPT installation

Currently Known Bugs
=====================================================================
* Will update this with outstanding bugs as I find them...

Installation
=====================================================================
Download the .zip file on GitHub.

Extract the .zip file.

Make sure that ghostAPT.sh is executable.

Double click on ghostAPT.sh and execute it (it will open in Konsole).

Follow the Installation Manager and enjoy!
