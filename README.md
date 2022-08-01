# Yet Another 5 Lines **Fetch** script (ya5lfetch)

## Example:

```
[arco, KDE] $ ya5lfetch
     .     arcowo@kpc /~
    / \    OS:      ArcoLinux
   / . \   KERNEL:  5.18.15-arch1-1
  / / _ \  SHELL:   bash
 /`     `\ DE:      KDE

[artix, no DE] $ ya5lfetch
     .     u@artix /home/u
    / \    OS:      Artix Linux
   /.  \   KERNEL:  5.18.12-artix1-1
  /   * \  SHELL:   bash
 /   '   \ TTY:     pts/1, ssh

[Termux, Android (RR ROM)]
$ [ -e "$PREFIX"/etc/os-release ] || echo 'NAME="Android"' >> "$PREFIX"/etc/os-release
$ ya5lfetch
         u0_a300@dumpling /data/data/com.termux/files/home
 ╲_____╱ OS:      Android
 ╱ . . ╲ KERNEL:  4.4.254-lineage+
▕       ▏SHELL:   bash
 ▔▔▔▔▔▔▔ TTY:     pts/3, ssh

[KISS, in chroot] $ ya5lfetch   # TODO: fix missing "TTY: not a tty"
        root@kpc /tmp/_9754
 +----+ OS:      KISS Linux
 | |/ | KERNEL:  5.18.15-arch1-1
 | |\ | SHELL:   ya5lfetch.sh
 +----+ not a tty

[Alpine, in termux chroot] $ ya5lfetch  # TODO: fix missing "TTY: not a tty"
            u99-_-@dumpling /root
    .       OS:      Alpine Linux v3.11
   / \      KERNEL:  4.4.254-lineage+
  /   \ /\  SHELL:   bash
 /◁    \  \ /dev/pts/1
```

TODO install and get linux kernel version and distros exact name:
- Arch
- Artix ✅
- Arco ✅
- Manjaro
- Alpine✅-
- KISS ✅-
- Debian
- Windows (wine)
- Termux/Android ✅
- for Space Invaders ASCII: LFS (hell no) / Bedrock linux / busybox based chroot ?
