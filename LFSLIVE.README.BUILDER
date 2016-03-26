

OVERVIEW:

   Building a live image consists of the following steps:

   0) Obtain the lfs7.9-live-kit.  (Git clone it or download and unzip the zip file)

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


PREREQUISITES:

   The user should be familiar with LFS and jhalfs.  

   The host system must comply with the host system requirements 
   described in the LFS book.

   The host system must comply with the host system requirements 
   needed to run jhalfs.

   In addition to the LFS/jhalfs host system requirements, this package
   requires the following host tools:

   1) mksquashfs version 4.x.

   2) genisoimage.   

   3) isohybrid.   The isohybrid tool is used to adapt the iso image for
      use on a USB flash drive.   It can be omitted if only a CD bootable
      image is needed.

   

LFSLIVE_PREP.SH:

   From the top of the lfs7.9-live-kit tree, run the following command:

   ./lfs7.9-live-kit/lfslive_prep.sh

   The lfslive_prep.sh script creates both a directory to contain
   a LFS live host build area and another directory to contain
   the LFS live target build area.   These two directories are:

   ~HOME/lfs79live_host
   /mnt/lfs79live_target

   If either of these two directories already exists, the script
   will abort.   If this happens, review the contents of the existing
   directory(s), and remove them after saving any needed data, and
   then rerun the script.

   The host directory will contain a copy of jhalfs, a copy of the LFS
   7.9 book (xml format), a kernel config file and other files that may
   be useful in creating the live image.

   The target directory will contain a collateral folder which contains
   files and information that may be useful to the LFSlive end user.   It
   will also contain a sources folder which contains a file or two which
   will be needed during the LFS image build and cannot be reasonably
   downloaded.

   Upon successful completion, move on to the next step.



LFSLIVE BUILD:

   2) cd to the lfs..._host/jhalfs directory and run jhalfs to build
      the LFS system.
