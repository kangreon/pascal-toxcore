# pascal-toxcore
Pascal bindings for [libtoxcore]

Before using this wrapper, you need to compile [libtoxcore] library for your platform.
How to compile [libtoxcore], written in the section [Install Instructions].

Note: Not all functions are now tested.

### API Progress
- [x] toxcore
- [x] toxav
- [x] toxdns
- [x] toxencryptsave
- [x] tox_old.h (old groupchats)
- [ ] Higher level API

### Compilers Tested
- [x] Delphi XE7
- [ ] Delphi 2005 - Delphi 10
- [ ] Delphi 7
- [ ] Free Pascal 3

### Platforms Tested
- [ ] Windows XP (32/64)
- [x] Windows 7 (32)
- [ ] Windows 10 (32/64)
- [ ] Debian 8.4 (32/64)
- [ ] OS X * (32/64)

### Example
Example of use will be available after the development of Higher level API. Now you can get acquainted with the library at a low level API as an example [Echo Bot].


[libtoxcore]:https://github.com/irungentoo/toxcore
[Install Instructions]:https://github.com/irungentoo/toxcore/blob/master/INSTALL.md
[Echo Bot]:https://wiki.tox.chat/developers/client_examples/echo_bot
