#1
awk -F: '/\/home/ {printf "user %s has id %s\n",$1,$3}' /etc/passwd > ~/work3.log

#2
chage -l root  > work4.log && head -n1 work4.log > work5.log && rm work4.log

#3
cut -d: -f1 /etc/group | awk '{printf "%s,", $1}' >> work5.log

#4
echo Be careful! > /etc/skel/readme.txt 

#5
useradd -m u1 -p `crypt 12345678`

#6
groupadd g1

#7
usermod -a -G g1 u1

#8
echo "" >> work5.log && echo id:`id -u u1` user u1 >> work5.log
echo u1 groups: `id -G u1` >> work5.log

#9
usermod -a -G g1 vagrant # I don't have a user "user"

#10
grep 'g1' /etc/group | sed -e 's/^\w*\:\w*\:\w*\: *//'

#11
# changed string in /etc/passwd
# u1:x:1001:1003::/home/u1:/usr/bin/mc

#12
useradd -m u2 -p 87654321

#13
mkdir /home/test13
cp work5.log /home/test13/work5-1.log
cp work5.log /home/test13/work5-2.log

#14
groupadd g2
usermod -a -G g2 u1
usermod -a -G g2 u2
chgrp -R g2 /home/test13
chmod -R 640 /home/test13/
chown -R u1:g2 /home/test13/

#15
mkdir /home/test15
chown -Rv u1:u1 /home/test15
chmod 1777 /home/test15 

#16
cp /bin/nano /home/test15
chown u1:u1 /home/test15/nano
chmod a+s /home/test15/namo