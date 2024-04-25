# Debian 12 VM Install Guide

# Part 1: VM Setup
## 1. Open Virtual Machine Manager via the terminal emulator
In your terminal, run ``virt-manager``
## 2. Once the window has opened, begin the install process by selecting the button in the upper left corner of the window
Select your .ISO or physical media containinng the Operating System of choice, and then use the default settings provided by the program until you reach the live install screen
# Part 2: Initial OS Install/Setup
## 1. Select install
  Save time and resources for by not using a GUI (for now) 
## 2. Select English for system language
  Adjust for personal spoken language
## 3. Select timezone
  Adjust for timezone/location (we'll be using PST/Pacific Standard Time for this tutorial)
## 4. Select keymap according to your region
  In this case we'll be using ``American English``
## 5. Select hostname for system
  This will identify the system on the network (We'll be using ``tux`` for this example)
## 6. Choose domain name 
  Optional for end-users
## 7. Choose root password
  Needed to access root commands and make major changes to the system
## 8. Create first user account(s)
  Enter real name, then choose a name to be identified by on the system (try to make it memorable)
## 9. Select system clock region
  This will help identify the timezone for the correct time in the operating system
## 11. Partition the disk to support Logical Volume Management (See Post-Install - Step 6 for steps on expanding the pool)
## 11.1 Partition disks (part 1) for storage, selecting Guided - Use entire disk and setup LVM
  LVM allows you to expand the storage pool after installation without major disruption
## 11.2 Partition disks (part 2) select virtual disk 1 (vda)
    vda is the virtual disk wwe made before spinning up the installer
## 11.3 Partition disks (part 3) select all files in one partition
    this will format the disk, erasing (but not overwriting) all previous data. Select yes when prompted if sure to write changes to disk
## 11.4 Partition disks (part 4) select size for guided partitioning
    This is essentially the initial disk size; can be expanded later
## 12. Skip scanning additional disks
## 13. Configure the package manager, choose region and mirror and skip proxy setup for the time being
  This allows you to download applications, libraries and drivers from the terminal on demand  
## 14. Opt out of popularity contest
  Fight the power, don't play their game
## 15. Select the following packages from the menu (do not select any Desktop Environments at this point)
    openssh | Apache Web Server
## 15. Allow the installation to run it's course, and then allow it to reboot when prompted

# Part 3: Post-install

## 1. Add additional users
  This step creates additional user profiles 
## 1.1 BECOME ROOT!
  We need to become root temporarily in order to add the new users. Various commands can help accomplish this goal, but for this tutorial, we'll be using ``su -``
## 1.2 Add the new user to the system (we'll be using the example username ``tux2``)
  Run ``adduser tux2``
## 1.3 Give the new user a password for security purposes
  Run the command ``passwd tux2`` and enter your chosen password twice in the prompt that appears; once to set the new passwoed, and again to confirm
## 1.4 Finally, if necessary, add the new user to the ``sudoers`` group
  Enter the command  ``usermod -aG sudo tux2``
  
## 2. Change Apache default homepage 
  This will cause a different page to be displayed when accessing the web server's homepage
## 2.1 Remove the initial index.html
  Execute the command ``rm /var/www/html/index.html`` to remove the default .html file provided with the operating system
## 2.2 Replace the removed file with your own .html file (We'll use ``replaceme.html`` as an example, it is stored on the root of the drive in this case)
  Download a webpage in .html format or otherwise source a .html file to use as your homepage. Once you have the file, execute ``sudo mv /replaceme.html /var/www/html/``

## 3. Enable the serial console via systemd for remote access
  This step will allow you to connect to your systen headlessly (without access to a monitor via another computer)
## 3.1 Enable the getty service for the chosen interface to run at boot (this example will utilize the default serial port)
  Run the command ``systemctl enable getty@ttys0.service``
## 3.2 Start the service for the current session via systemd
  Run ``systemctl start getty@ttys0.service``
## 3.3 Reload daemons
  Run ``systemctl reload-daemons``
## 4. Create two new directories in the root and add them to the PATH for easy access (you may need to complete these commands as superuser)
## 4.1 Execute ``sudo mkdir /bin`` and ``sudo mkdir /inclass``
## 4.2 Execute the following: ``echo export PATH="/bin:$PATH > .bashrc `` and ``echo export PATH="/inclass:$PATH > .bashrc``
## 4.3 Check to make sure the changes applied correctly by running ``echo $PATH``
## 5. Get a lil' bit func-y with it. 
  Create some fun-ctions that will help automate various aspects of the system
## 5.1 Execute the following command to create a function called ``FUN`` that calculates a mathematic equation and displays the resulting text in markdown when executed:

``` cat - > ~/.funcs << "FUN"
whdr() {
echo '<!DOCTYPE html><head><title>bash web</title></head><body><pre>'

}
wftr() {
echo '</pre></body></html>'

}
calcit() {
    printf "%s\n" "$@" | bc -lq ~/.bcrc  
}

FUN

cat - > ~/.bcrc << BCRC
scale=2
BCRC
```
## 6. Expand Volume Pool
## 6.1 Open Virt-Manager and choose the Virtual Machine
Open the Virt-Manager interface on the host OS and select the VM we've been using, and select the light bulb symbol to edit it
## 6.2 Select Add Hardware near the bottom of the window, and select Storage from the list that appears
## 6.3 Create the new disks
In the resulting menu, select ``Create a disk image for the virtual machine`` and set the size to 5 GiBs, and then click Finish
## 6.4 Repeat the previous step until you have created a satisfactory number of virtual drives
## 6.5 We will now return to the Virtual Machine itself and begin the process of mounting our new drive(s)
Start by running ``sudo pvcreate /dev/sdb /dev/sdc`` to create the physical volumes that will make the volume pool/group
## 6.6 Create a volume group from the previously created physical volumes, in this case called tuxvg
Run ``vgcreate tuxvg /dev/sdb /dev/sdc/``
## 6.7 We then need to make a logical volume utilizing the new volume group
Run ``lvcreate -n tuxlv -L 10G tuxvg`` to create a 10 gigabyte logical volume named ``tuxlv``
## 6.8 Finally, we need to format our new logical volume into usuable storage
Run ``mkfs.ext4 /dev/tuxvg/tuxlv``

# What now? Up to you, my dear end-user, up to you.
