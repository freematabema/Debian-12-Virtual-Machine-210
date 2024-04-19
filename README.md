debian 12 (default- 20 GiB VHD)
## 1. Select install
  Save time and resources for by not using a GUI (for now) 
## 2. Select English for system language
  Adjust for personal spoken language
## 3. Select Pacific/PST for timezone
  Adjust selection for timezone/location
## 4. Select American English for keymap
  Adjust for regional keyboard as necessary
## 5. Select hostname for system
  Use tux as default, this will identify the system on the network
## 6. Choose domain name 
  Optional for end-users
## 7. Choose root password
  Needed to access root commands and make major changes to the system
## 8. Create first user account(s)
  Enter real name, then choose a name to be identified by on the system (try to make it memorable)
## 9. Select system clock region
  This will help identify the timezone for the correct time in the operating system
## 11 Partition disks (part 1) for storage, selecting Guided - Use entire disk and setup LVM
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
## 14.1 Add the following packages to the install via the  
## 15. Opt out of popularity contest
  Fight the power, don't play their game
## 16. Select the following packages from the menu (do not select any Desktop Environments at this point)
  openssh
  Apache Web Server
## 17. Allow the installation to run it's course, and then allow it to reboot when prompted


