#/bin/bash
#
# Executing this script is the first step in creating a LFS live image.
#
# This script prepares the LFS live target directory (i.e. $LFS) and 
# the LFS live host build area and populates them with various pieces
# of data that will be needed by the LFS live builder and/or the LFS live
# end user.
#

set -e
LFS=/mnt/lfs79live_target
if [ -d $LFS ]
then
    echo $LFS already exists, aborting
    exit 1
fi

LFS_HOST=$HOME/lfs79live_host
if [ -d $LFS_HOST ]
then
    echo $LFS_HOST already exists, aborting
    exit 1
fi

#
# Needs hardening:
#
# 1) check for host disk space available.
# 2) check for host squashfs-tools and genisoimage.
# 3) check that user is not root and has needed permissions to
#   perform the build
# 4) Check that memory size/swap space is adequate.
#


#
# Create $LFS target directory and
# add items to $LFS/sources that can't be 
# reasonably obtained by downloading.
#
mkdir -p $LFS/sources
cp extras/certdata_20160313.txt $LFS/sources
cp extras/certdata_20160313.txt $LFS/sources/certdata.txt
case $(uname -m) in
    # yaboot only needed for ppc...
    ppc* ) cp extras/yaboot_binary_deb_1.3.16-4.tar.xz $LFS/sources  
    ;;
esac

#
# Create a folder in the LFS target directory and populate it with 
# information that will likely be useful to the live user.  LFS books,
# patches & the like...
#
mkdir -p $LFS/collateral
cp extras/jhalfs_20160310_r3858.tar.gz $LFS/collateral
cp extras/LFS-BOOK-7.9-NOCHUNKS.html $LFS/collateral
cp extras/blfs-book-7.9-html.tar.bz2 $LFS/collateral
cp extras/blfs_root_7.9.tar.gz $LFS/collateral
cp extras/lfs-book-7.9-xml.tar.gz $LFS/collateral
case $(uname -m) in
    # LFS book patch only needed for ppc...
    ppc* ) cp extras/lfs79_ppc_arm_book.patch $LFS/collateral
    ;;
esac

#
# Create a host folder for the LFS live build and populate it with the materials 
# needed by the live builder.
#
mkdir $LFS_HOST

# jhalfs
cp extras/jhalfs_20160310_r3858.tar.gz $LFS_HOST
tar xf extras/jh* -C $LFS_HOST

# kernel config
case $(uname -m) in
    x86_64) cp kernel/x86_64_live_config $LFS_HOST ;;
    ppc64) cp kernel/g5_live_config $LFS_HOST ;;
    ppc) cp kernel/pmac32_live_config $LFS_HOST ;;
    *) cp kernel/i386_live_config $LFS_HOST ;;
esac

# LFS book (xml format)
cp extras/lfs-book-7.9-xml.tar.gz $LFS_HOST

# jhalfs custom configs for building live image
cp custom_configs/* $LFS_HOST/jhalfs/custom/config
case $(uname -m) in
    ppc* ) 
        cp custom_ppc_configs/* $LFS_HOST/jhalfs/custom/config
        cp extras/lfs79_ppc_arm_book.patch $LFS_HOST/
    ;;
esac

cp LFSLIVE.README.BUILDER $LFS_HOST

echo
echo THe LFS live build preperation step is complete.  
echo ${LFS} is the LFS live target build area.
echo ${LFS_HOST} is the LFS host build area.
echo
echo next do \'cd ${LFS_HOST}\' 
echo and see the LFSLIVE.README.BUILDER file in that directory
echo

exit
