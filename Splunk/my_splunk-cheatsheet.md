############SOME GENERAL CLI STUFF#############

#Validate files after updating
./splunk validate files

#default splunk directory
/opt/splunk

#set splunk home environment variable
export SPLUNK_HOME=<Splunk Enterprise installation directory>
cd $SPLUNK_HOME/bin
./splunk start

#stop splunk from bothering me
SPLUNK_HOME/bin/splunk start --answer-yes --no-prompt

#stop splunk
./splunk stop

#splunk web access
http://<host name or ip address>:8000

#upgrading splunk
require access to splunk websites, just install 8.2 over 8.1 
tar xvzf splunk_package_name.tgz -C /opt
OR
rpm -i splunk_package_name.rpm

#changeing splunk user password
splunk edit user admin -password newPassowrd  -auth admin:changeme 

#splunk create a new user
splunk add user [user] -role [role] -password [password] -full-name "Your Name"

#splunk list users
splunk list user

#splunk roles:
admin – Full administrator access
power – One level down from admin. You can edit shared objects, alerts, tag events, etc.
user – Assign this for typical splunk user who can run searches, edit own saved searches, etc.
can_delete – Allows user to delete by keyword.

#splunk remove a user
splunk remove user [username]

=================UNIVERSAL FORWARDER==============================

#splunk universal forwarder download link
https://www.splunk.com/en_us/download/universal-forwarder.html
wget -O splunkforwarder-8.2.4-87e2dda940d1-Linux-x86_64.tgz 'https://download.splunk.com/products/universalforwarder/releases/8.2.4/linux/splunkforwarder-8.2.4-87e2dda940d1-Linux-x86_64.tgz'

#splunk enterprise host --> enable receiving https://docs.splunk.com/Documentation/Forwarder/8.2.4/Forwarder/Enableareceiver
./splunk enable listen [port] -auth admin:password

#install and configure on *nix
tar -xvzf splunkforwarder-<…>-Linux-x86_64.tgz -C /opt
https://docs.splunk.com/Documentation/Forwarder/8.2.4/Forwarder/Installanixuniversalforwarder

cd $SPLUNK_HOME/bin
./splunk start

[sudo] $SPLUNK_HOME/bin/splunk enable boot-start

./splunk add forward-server <host>:<port>	

https://docs.splunk.com/Documentation/SplunkCloud/8.2.2112/Data/Getstartedwithgettingdatain
ex: ./splunk add monitor /var/log/messages

./splunk restart


#install and configure on Windows
Follow instructions, I think you can specify the splunk machine as the "Recieving Indexer"
https://docs.splunk.com/Documentation/Forwarder/8.2.4/Forwarder/InstallaWindowsuniversalforwarderfromaninstaller

cd %SPLUNK_HOME%\bin
.\splunk start

.\splunk add forward-server <host>:<port>

https://docs.splunk.com/Documentation/SplunkCloud/8.2.2112/Data/Getstartedwithgettingdatain
ex: .\splunk enable eventlog System

.\splunk restart

!!!Don't forget to configure firewall rules to allow forwarder to send data to deployed splunk enterprise machine!!!

#Some more random links
CLI Stuff:
https://docs.splunk.com/Documentation/Splunk/8.2.4/Admin/AbouttheCLI
https://docs.splunk.com/Documentation/Splunk/8.2.4/Admin/CLIadmincommands

Splunk security:
https://docs.splunk.com/Documentation/Splunk/8.2.4/Installation/MorewaystosecureSplunk
