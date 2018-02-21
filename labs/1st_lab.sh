#!/bin/bash

mkdir $HOME/test
touch $HOME/test/list && echo `ls -ap $HOME` > $HOME/test/list 
mkdir $HOME/test/links
ln $HOME/test/list $HOME/test/links/list_link
rm $HOME/test/list
cat $HOME/test/links/list_link
ln $HOME/test/links/list_link $HOME/list1
touch $HOME/list_conf && echo `find /etc -type f | grep \\.conf` > $HOME/list_conf
touch $HOME/list_d && echo `ls -p /etc | grep -v / | grep \\.d` > $HOME/list_d
cat $HOME/list_conf > $HOME/list_conf_d && cat $HOME/list_d >> $HOME/list_conf_d
ln -s $HOME/list_conf_d $HOME/test/links/list_conf_d_link
ln $HOME/list1 $HOME/test/links/links_list1
less $HOME/test/links/list_conf_d_link
mkdir $HOME/test/.sub
cp $HOME/list_conf_d $HOME/test/.sub/list_conf_d
cp -f $HOME/list_conf_d $HOME/test/.sub/list_conf_d
mv $HOME/test/.sub/list_conf_d $HOME/test/.sub/list_etc
rm $HOME/list_conf_d

echo "should be error: "
cat $HOME/test/links/list_conf_d_link # NF error here

touch $HOME/test/calenar.txt && echo `cal 2000` > $HOME/test/calenar.txt 
cal -3 2 2000 # you can use also  :::  head -9 $HOME/test/calenar.txt  :::
ls -a $HOME/test
echo "the number of hardlinks is:"
echo `ls -l $HOME/test/links/list_link | awk '{ print $2 }'`
echo `man man` > $HOME/man.txt
split -b 1000 $HOME/man.txt
mkdir $HOME/man.dir
mv x[a-b][a-z] $HOME/man.dir 
cat `ls -d -1 $HOME/man.dir/[a-z][a-z][a-z]` >> $HOME/man.dir/man.txt

if [[ `diff $HOME/man.txt $HOME/man.dir/man.txt` ]]; then
	echo "NOT OK"
else
	echo "OK"
fi

echo "some\nlines\nat\nthe\nEOF" >> $HOME/man.txt

diff -u $HOME/man.dir/man.txt $HOME/man.txt > $HOME/man_diff
mv $HOME/man_diff $HOME/man.dir/man_diff
patch $HOME/man.dir/man.txt $HOME/man.dir/man_diff

if [[ `diff $HOME/man.txt $HOME/man.dir/man.txt` ]]; then
	echo "NOT OK"
else
	echo "OK"
fi