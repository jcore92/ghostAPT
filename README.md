ghostAPT is a Script Running Engine.
=====================================================================

The project started because I wanted a way to quickly restore fresh linux installs to a usable state with minimal to no configuration yet be transparent enough to know what was going on in my computer.

ghostAPT utilizes signatures and trust in order to open it's Ghost Scripts, so if there is a script that is unknown, it's not trusted until you intervene and it will let you know before proceeding. It also uses the cat command to display the Ghost Script completely before running the script and the Ghost Script must be properly formatted with our code occupying the first 4 lines of a script or else it is considered insecure and will not run. You have peace of mind configuring your system quickly so you can get back to computing on Linux!

Ghost Scripts come in many forms but the file must end in a '.ghost' extension in order for ghostAPT to detect them while in its directory in the install folder.

You can utilize our first party Ghost Scripts from within ghostAPT or you can manually download/add third party Ghost Scripts so long as they follow the prerequisites above and that they are placed in the installation directory correctly: /home/YOU/ghostAPT/CATEGORY/script.ghost

You can name the folder (Category) or Ghost Scripts to whatever but to be safe keep naming conventions simple. When naming scripts due to the signature engine, you should NOT include parenthesis '(' or ')' in the script name tag inside your script and the filename or ghostAPT will grab incorrect metadata.


Compatibility
=====================================================================
Currently, this will only work on an Ubuntu-based distro running KDE.

This decision was made because it was designed for it. I don't like many of the other DE's out there BUT, I do understand there are others out there who like something else. A goal down the line is to make it so you only need Konsole and an Ubuntu-based distro to be able to run ghostAPT. This will take time, effort, and a lot of testing and I am the only developer to-date so if it isn't too much of a burden I will hopefully get around to it.


Installation
=====================================================================
Download the .zip file on GitHub.

Extract the .zip file.

Make sure that ghostAPT.sh is executable.

Double click on ghostAPT.sh

Follow the Installation Manager and enjoy!
