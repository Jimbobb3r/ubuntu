![alt text](https://github.com/Jimbobb3r/ubuntu/blob/master/Logo-ubuntu.svg.png?raw=true "Ubuntu Logo")

It ain't easy bein' Wheezy so now I'm a Xenial Xerus.


Stuff: 

https://www.digitalocean.com/community/tutorials 

https://askubuntu.com/ 

https://help.ubuntu.com/ 

https://www.cyberciti.biz/ 

Apache:

http://dev.antoinesolutions.com/ubuntu-14.04-trusty/install-and-configure-apache-http-server-on-ubuntu-14.04

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04 

LAMP

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04 

CRON 
https://help.ubuntu.com/community/CronHowto 

**clear** clear terminal window <br>
**ls list** files in current folder <br>
**ls -a** list all files including hidden <br>
**ls -l** list files in long format : Access Rights/Hard Links/Owner/Group/Size (Bytes)/modify date,time/file or directory name <br>
**ls -t** list and order by time of last modify <br>
**pwd** print working directory name <br>
**cd** current directory <br>
**cd ..** move back/up one directory <br>
**cd ../abc/** another sub-folder in same parent folder **cd ../../abc/def** back two forward two  <br>
**mkdir** new folder in working directory <br>
**touch** new file in working directory <br>
**cp abc.txt xyz.txt** <br>
**cp * abc/** copy all files to folder abc <br>
**cp m*.txt abc/** copy all files beginning with m to folder abc <br>
**mv abc.txt def.txt xyz/** move abc.txt & def.txt to folder xyz  <br>
**mv abc.txt def.txt** rename abc.txt to def.txt <br>
**rm** delete file/directory **rm -r** delete directory and all child directories <br>
**echo "Hello" > hello.txt** <br>
**cat abc.txt** display contents of hello.txt <br>
**cat abc.txt > def.txt** overwrite def with contents of abc  <br>
**cat abc.txt >> def.txt** append contents of abc to def <br>
**cat < def.txt** output def’s contents to screen → other direction <br>
**cat abc.txt | wc** outputs numbers of lines, words & characters in abc.txt <br>
**|** pipe stdout from one command to stdin of another command <br>
**sort abc.txt** output abc.txt content in alphabetical order <br>
**uniq abc.txt** filters adjacent, duplicate lines **sort deserts.txt | uniq > uniq-deserts.txt** sort & filter removes all duplicates <br>
**grep -i abc abc.txt** global regular expression print - searches for abc in abc.txt, -i makes search case sensitive  <br>
**grep -R def /abc/xyz** outputs filenames and the lines containing matches **grep -Rl def /abc/xyz** filenames only <br>
**sed** strain editor -> find and replace <br>
**sed ‘s/abc/def’ xyz.txt** find first instance of abc and replace with def **sed ‘s/abc/def/g’ xyz.txt** replace abc globally <br>
<br>
**~/.bash_profile** ‘ ~ ’ user’s home directory; ‘ . ‘ hidden file <br>
     **alias** - abbreviate commands <br>
     **source ~/.bash_profile** - activate changes for current session <br>
     **export USER=’James’** <br>
     **export PS1=">>"** - change cmd prompt to >> <br>
     At CLI: **echo $USER** → returns value of variable USER <br>
**echo $HOME** returns home variable value <br> 
**echo $PATH** comma separated list of directories containing scripts <br> 
**env** returns current user’s env variables <br> 
**env | grep PATH** stdout of env piped to grep which searches for “PATH”’ <br>
