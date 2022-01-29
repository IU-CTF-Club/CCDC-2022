# Edit files via shared TMUX sessions

## Open a file

```
$ ./topen.sh FILENAME
```

This command will start a tmux server if not already running.

## List all open sessions

```
$ ./tlist.sh
```

## Attach to an open session

[fzf](https://github.com/junegunn/fzf) is recommended.

```
$ ./tattach.sh
```


# General Linux Hardening

## HTTPD (changes to `httpd.conf`) [src](https://www.acunetix.com/blog/articles/10-tips-secure-apache-installation/)

* Disable server-info

  ```
  #LoadModule info_module modules/mod_info.so
  ```

* Disable server-status

  ```
  #<Location /server-status>
  # SetHandler server-status
  # Order deny,allow
  # Deny from all
  # Allow from .your_domain.com
  #</Location>
  ```

* Set ServerTokens to Prod

  ```
  ServerTokens Prod
  ```

* Disable Directory Listing

  ```
  <Directory /your/website/directory>
  Options -Indexes
  </Directory>
  ```

* Enable only the required modules

* Use an appropriate user and group

  ```
  User apache
  Group apache
  ```

* Restrict unwanted services

  ```
  <Directory /your/website/directory>
  Options -ExecCGI -FollowSymLinks -Includes
  </Directory>
  ```

* Enable logging

  ```
  LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" detailed
  CustomLog logs/access.log detailed
  ```

## SSHD [src](https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-18-04)

* Test ssh configuration:

  ```
  $ sshd -t
  ```

* Show all sshd configuration settings:

  ```
  $ sshd -T
  ```

* Some sane defaults of `/etc/ssh/sshd_config` (check them with `man sshd_config`)

  ```
  PermitRootLogin no

  MaxAuthTries 3
  LoginGraceTime 20

  PasswordAuthentication no
  PermitEmptyPasswords no

  ChallengeResponseAuthentication no
  KerberosAuthentication no
  GSSAPIAuthentication no

  X11Forwarding no
  PermitUserEnvironment no

  AllowAgentForwarding no
  AllowTcpForwarding no
  PermitTunnel no

  DebianBanner no

  # Restrict all users to a specific IP address range
  AllowUsers *@192.168.0.0/24

  Match User alice
    AllowUsers alice@192.168.0.2
  ```

* Restrict the shell to users

  ```
  # adduser --shell /usr/sbin/nologin alice
  # usermod --shell /usr/sbin/nologin bob
  ```

* Force SFTP-only user account

```
Match User mallory
  ForceCommand internal-sftp
  ChrootDirectory /home/mallory/
```

* Harden `authorized_keys`; add the following as comma separated list to the beginning of the line with `ssh-rsa AABBCC...`:
  * `no-agent-forwarding`: disable SSH agent forwarding
  * `no-port-forwarding`: disable SSH port forwarding
  * `no-pty`: disable the ability to allocate a tty (i.e. start a shell)
  * `no-user-rc`: prevent execution of `~/.ssh/rc` file
  * `no-X11-forwarding`: disable X11 display forwarding

* More on chroot jail, see [here](https://www.tecmint.com/restrict-ssh-user-to-directory-using-chrooted-jail/)

* Also, look at [`fail2ban`](https://wiki.archlinux.org/title/fail2ban)

## DNS [src](https://www.akadia.com/services/dns_hardening.html)
