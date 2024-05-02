# NAS lab

## Lab setup

Run `./setup.ps1` on an active AWS account.


## Server

Install `samba` using `sudo apt -y install samba`.

Edit `/etc/sambda/smb.conf` (as root) and I recommend uncommenting the `homes` share definitions.

Restart samba using `sudo systemctl restart smbd`.

Make a samba user for `ubuntu` user using `sudo smbpasswd -a ubuntu`.
(Every Samba user must have a corresponding UNIX user.)


## Client

On the client linux instance you can either connect using a client or mount as a drive.

Install `smbclient` using `sudo apt -y install smbclient`.

Connect using `smbclient //private_ip/ubuntu` with the credentials you created above.

