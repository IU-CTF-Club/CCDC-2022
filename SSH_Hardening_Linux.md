# SSH Hardening

- Methods to harden ssh in Linux
Credit: https://github.com/CyberLions/CCDC/blob/master/2020/Short%20Scripts/SSHhardenBasic.txt

### Setting a custom SSH port
1) nano -w /etc/ssh/sshd_config
2) Search for: Port
3) Change 22 to something like port 560

### Deny all connections from unknown hosts
1) nano -w /etc/hosts.deny
2) ALL : ALL
3) Allow access from certain IP's : nano -w /etc/hosts.allow
4) Add this at the end: sshd : 11.22.33.44
	- 11.22.33.44 is your ip address of your choosing

### Disable Root Login
1) nano -w /etc/ssh/sshd_config
2) Search for "PermitRootLogin"
3) Set it to: PermitRootLogin no

### Disable Empty Passwords
1) nano -w /etc/ssh/sshd_config
2) PermitEmptyPasswords no

### Limit Max Authentication attempts
1) nano -w /etc/ssh/sshd_config
2) Search for MaxAuthTries
3) Set to: MaxAuthTries 3

### Quickly verify sshd configuration

```
# sshd -T
```

### Automate changes with sed

We can use sed to quickly set some sane standards:

```
$ sudo sshd -T | sed ' s/^\(port\).*/\1 560/i; s/^\(PermitRootLogin\).*/\1 no/i; s/^\(PermitEmptyPasswords\).*/\1 no/i; s/^\(MaxAuthTries\).*/\1 3/i'
```

To make sure, we can diff those changes against the original:

```
$ diff <(sudo sshd -T) <(sudo sshd -T | sed ' s/^\(port\).*/\1 560/i; s/^\(PermitRootLogin\).*/\1 no/i; s/^\(PermitEmptyPasswords\).*/\1 no/i; s/^\(MaxAuthTries\).*/\1 3/i') -u
--- /dev/fd/63  2022-01-28 21:41:16.895037055 -0500
+++ /dev/fd/62  2022-01-28 21:41:16.895037055 -0500
@@ -1,11 +1,11 @@
-port 22
+port 560
 addressfamily any
 listenaddress [::]:22
 listenaddress 0.0.0.0:22
 usepam yes
 logingracetime 120
 x11displayoffset 10
-maxauthtries 6
+maxauthtries 3
 maxsessions 10
 clientaliveinterval 0
 clientalivecountmax 3
```
