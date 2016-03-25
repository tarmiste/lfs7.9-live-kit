

OVERVIEW:

   Building a live image consists of the following steps:

   0) Obtain the lfs7.9-live-kit.  (Git clone it or download the zip file)

      lfs7.9-live-kit provides various scripts and config files that are
      useful for creating the live image.
     
   1) Execute the lfs7.9-live-kit/lfslive_prep.sh script.   
 
      This script prepares a target directory and a host directory and
      populates the directories with various various scripts and 
      config files that are useful for creating the live image.
      
   2) cd to the lfs..._host/jhalfs directory and run jhalfs to build
      the LFS system.

   3) Run host scripts.

      These scripts package the LFS system into a bootable live iso
      image.

   Each of these steps is described in more detail following.

   The user should be familiar with LFS and jhalfs.  


HOST SYSTEM PREREQUISITES:

LFSLIVE_PREP.SH:


