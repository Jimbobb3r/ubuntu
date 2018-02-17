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

**clear** clear terminal window 
**ls list** files in current folder 
**ls -a** list all files including hidden 
**ls -l** list files in long format : Access Rights/Hard Links/Owner/Group/Size (Bytes)/modify date,time/file or directory name 
**ls -t** list and order by time of last modify 
**pwd** print working directory name 
**cd** current directory 
**cd ..** move back/up one directory 
**cd ../abc/** another sub-folder in same parent folder **cd ../../abc/def** back two forward two  
**mkdir** new folder in working directory 
**touch** new file in working directory 
**cp abc.txt xyz.txt** 
**cp * abc/** copy all files to folder abc 
**cp m*.txt abc/** copy all files beginning with m to folder abc 
**mv abc.txt def.txt xyz/** move abc.txt & def.txt to folder xyz  
**mv abc.txt def.txt** rename abc.txt to def.txt 
**rm** delete file/directory **rm -r** delete directory and all child directories 
**echo "Hello" > hello.txt** 
**cat abc.txt** display contents of hello.txt 
**cat abc.txt > def.txt** overwrite def with contents of abc  
**cat abc.txt >> def.txt** append contents of abc to def
**cat < def.txt** output def’s contents to screen → other direction 
**cat abc.txt | wc** outputs numbers of lines, words & characters in abc.txt
**|** pipe stdout from one command to stdin of another command 
**sort abc.txt** output abc.txt content in alphabetical order 
**uniq abc.txt** filters adjacent, duplicate lines **sort deserts.txt | uniq > uniq-deserts.txt** sort & filter removes all duplicates
**grep -i abc abc.txt** global regular expression print - searches for abc in abc.txt, -i makes search case sensitive  
**grep -R def /abc/xyz** outputs filenames and the lines containing matches **grep -Rl def /abc/xyz** filenames only 
**sed** strain editor -> find and replace 
**sed ‘s/abc/def’ xyz.txt** find first instance of abc and replace with def **sed ‘s/abc/def/g’ xyz.txt** replace abc globally 

**~/.bash_profile** ‘ ~ ’ user’s home directory; ‘ . ‘ hidden file
         **alias** - abbreviate commands 
		     **source ~/.bash_profile** - activate changes for current session 
		     **export USER=’James’**
		     **export PS1=">>"** - change cmd prompt to >>
		     At CLI: **echo $USER** → returns value of variable USER
**echo $HOME** returns home variable value 
**echo $PATH** comma separated list of directories containing scripts 
**env** returns current user’s env variables 
**env | grep PATH** stdout of env piped to grep which searches for “PATH”’ 
