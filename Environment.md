# Environment

This course called for a Ubuntu 12.04 32 bit environment. I opted to
use Slackware64 14.2 with multilib support under VirtualBox as this
has everything I'd need and is a more comfortable environment for me
to work with.

I do not recommend this approach unless you know your way around Linux
very well!

# Steps involved

- Install Slackware64 from ISO. I did a full install minus KDE.

- Created a normal user for myself.

- Updated Slackware: uncomment a mirror in /etc/slackpkg/mirrors,
  slackpkg update && slackpkg upgrade-all

- Installed multilib by following instructions located at
  http://www.slackware.com/~alien/multilib/ (Thanks AlienBob!)

- Set the LILO timer to 10 seconds by editing /etc/lilo.conf and
  running lilo.

- Installed VirtualBox guest additions by mounting the guest additions
  disk: sudo /sbin/mount /dev/sr0 /mnt/cdrom; sudo sh
  /mnt/cdrom/VBoxLinuxAdditions.run

- Rebooted. Everything works now, but I have to compile programs as 32
  bit rather than the default 64 bit using various compiler flags. See
  Makefiles for each assignment for details.

- Alternatively, you can just use a 32 bit version of Linux and not
  deal with any of this.