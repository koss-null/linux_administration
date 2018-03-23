#1
fdisk -l
fdisk /dev/sdb
#
#   Device Boot      Start         End      Blocks   Id  System
#/dev/sdb1            2048     1776469      887211   83  Linux
#/dev/sdb2         1777664     3550890      886613+  83  Linux
#/dev/sdb3         5325311     7099732      887211   83  Linux
#/dev/sdb4         1776470     1777663         597   83  Linux
#
#Partition table entries are not in disk order
#
#Command (m for help): d 
#Partition number (1-4): 1
#
#Command (m for help): n
#Partition type:
#   p   primary (3 primary, 0 extended, 1 free)
#   e   extended
#Select (default e): p
#Selected partition 1
#First sector (2048-21295103, default 2048): 
#Using default value 2048
#Last sector, +sectors or +size{K,M,G} (2048-1776469, default 1776469): +512M
#
#Command (m for help): w
#The partition table has been altered!
#
#Calling ioctl() to re-read partition table.
#Syncing disks.
#root@precise32:/home/vagrant# fdisk /dev/sdb
#
#Command (m for help): p
#
#Disk /dev/sdb: 10.9 GB, 10903093248 bytes
#255 heads, 63 sectors/track, 1325 cylinders, total 21295104 sectors
#Units = sectors of 1 * 512 = 512 bytes
#Sector size (logical/physical): 512 bytes / 512 bytes
#I/O size (minimum/optimal): 512 bytes / 512 bytes
#Disk identifier: 0x849e7c6a
#
#   Device Boot      Start         End      Blocks   Id  System
#/dev/sdb1            2048     1050623      524288   83  Linux
#/dev/sdb2         1777664     3550890      886613+  83  Linux
#/dev/sdb3         5325311     7099732      887211   83  Linux
#/dev/sdb4         1776470     1777663         597   83  Linux

#2
man mkfs
mkfs -b 1024 -t ext3 /dev/sdb1
#mke2fs 1.42 (29-Nov-2011)
#Filesystem label=
#OS type: Linux
#Block size=1024 (log=0)
#Fragment size=1024 (log=0)
#Stride=0 blocks, Stripe width=0 blocks
#32768 inodes, 524288 blocks
#26214 blocks (5.00%) reserved for the super user
#First data block=1
#Maximum filesystem blocks=67633152
#64 block groups
#8192 blocks per group, 8192 fragments per group
#512 inodes per group
#Superblock backups stored on blocks: 
#	8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409
#
#Allocating group tables: done                            
#Writing inode tables: done                            
#Creating journal (16384 blocks): done
#Writing superblocks and filesystem accounting information: done 

#3
dumpe2fs /dev/sdb1 -h
#output reduced

#4
tune2fs -i 2m /dev/sdb1
#tune2fs 1.42 (29-Nov-2011)
#Setting interval between checks to 5184000 seconds

#5
mkdir /mnt/newdisk
mount /dev/sdb1 /mnt/newdisk/

#6
ln -s /mnt/newdisk/ ~ 

#7
mkdir ~/newdisk/dir1

#8
vim /etc/init/fscheck.conf
### inside vim .conf file
#description "nice job"
#author "Me =)"
#start on runlevel [2345]
#stop on shutdown
#exec mount -o noexec,noatime /dev/sdb1 $HOME/newdisk
init-checkconf /etc/init/fscheck.conf 

#9
fdisk /dev/sdb
# here I deleted sdb1 and created it again with 1G block inside
e2fsck -f /dev/sdb1
resize2fs /dev/sdb1 1G

#10
e2fsck -E nodiscard -n -f /dev/sdb1

#11
mkdir /mnt/shared
mount -t cifs //rain/tmp /mnt/shared -o r

#12
vim /etc/init/fscheck2.conf
### inside vim .conf file
#description "nice job 2"
#author "Me =)"
#start on runlevel [2345]
#stop on shutdown
#exec mount -o noexec,r -t cifs //rain/tmp /mnt/shared
init-checkconf /etc/init/fscheck2.conf 