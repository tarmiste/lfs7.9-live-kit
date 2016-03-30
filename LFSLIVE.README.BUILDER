

OVERVIEW:

   Building a live image consists of the following steps.  All of these
   steps are done as non-root user (with sudo priveleges)::

   0) Obtain the lfs7.9-live-kit.  (Git clone it or download and unzip the zip file)

      The lfs7.9-live-kit provides various scripts and config files that are
      useful for creating the live image.
     
   1) cd to the lfs7.9-live-kit directory and run the lfslive_prep.sh script.   
 
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

   All building is done by a normal user with sudo permissions.   Do
   not build the live image as root.   

   The host system architecture must match the desired architecture of
   the live image.  i.e.  an x86_64 live image must be built on a
   x86_64 host, and not on a 32 bit host.

   The host system must comply with the host system requirements 
   described in the LFS book.

   The host system must comply with the host system requirements 
   needed to run jhalfs.

   In addition to the LFS/jhalfs host system requirements, this package
   requires the following host tools:

   1) mksquashfs version 4.x.   version 3.x will not work.

   2) genisoimage.   

   3) isohybrid.   The isohybrid tool is used to adapt the iso image for
      use on a USB flash drive.   It can be omitted if only a CD bootable
      image is needed.

   Before beginning the live build, check for the existence of these
   host tools and install them if needed.

   

LFSLIVE_PREP.SH:


   In the lfs7.9-live-kit directory, run the following command:

   ./lfslive_prep.sh

   The user must have write permission on /mnt for this script to 
   succeed.

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

   Do: "cd ~HOME/lfs79live_host" 

   Find the tar archive of the LFS 7.9 book (xml format).   It can
   be unpacked and used as the book for jhalfs if needed.   Alternatively,
   jhalfs can be configured to download the book from the LFS website.  In
   this case, the local copy of the LFS 7.9 is not needed and can be 
   ignored.

   If, and only if,  building for PowerPC, then unpack the LFS 7.9 book 
   tarball and apply the ppc book patch to it.

   Find the live kernel config (*-live-config).   It will be used by
   jhalfs during the kernel build.

   Next do: "cd jhalfs ; make clean; make"

   Select the needed jhalfs menu options:

   1) Select local working copy of LFS book and point it to the local copy
      of the LFS book.  

   2) Select custom tools.  The prep script already populated the jhalfs
      custom/config directory with the scripts needed to build the live
      image.

   3) Select build directory of /mnt/lfs79live_target.

   4) Select download packages.   

   5) Select run Makefile.

   6) Select build kernel and provide the path to the live kernel config.

   7) It is prudent to select all final system tests.

   8) It may be helpful to select build all locales.

   exit from jhalfs and let it run the build.   After some hours 
   (or days), it will complete.   If it fails, fix the problem and 
   then finish the build.



HOST LIVE BUILD

   Upon completion of the jhalfs build, there remains several tasks
   that must be completed on the host (rather than in the chroot).

   It may be prudent to reboot the host machine at this point before
   running the host scripts.

   The jhalfs build has created a host_scripts directory and placed
   3 host scripts in it:

   /mnt/lfs78live_target/host_scripts

   To run the host scripts, do:

   export LFS=/mnt/lfs79live_target

   $LFS/host_scripts/make_live_squashed_root.sh

   $LFS/host_scripts/make_live_tree.sh

   $LFS/host_scripts/make_live_iso.sh


   The above will create a live image that includes all sources.   If
   the sources are not needed in the live image and it is desirable 
   to reduce the size of the live image, then move the sources before 
   the make_live_squashed_root step and move them back after.  e.g:

   sudo mv $LFS/sources /mnt/savelfs79sources

   $LFS/host_scripts/make_live_squashed_root.sh

   sudo mv /mnt/savelfs79sources $LFS/sources 
   
   $LFS/host_scripts/make_live_tree.sh

   $LFS/host_scripts/make_live_iso.sh

 

The resulting live image will be found in a file of the following format:

lfslive-<ARCH>_<DATE>.iso

It can be burned to cd or written to a USB flash drive (USB flash drive
not supported for PowerPC).




