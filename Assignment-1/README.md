# Assignment 1: TCP Bindshell

## Criteria

- Bind to port.
- Execute a shell on incoming connection.
- Port number should be easily configurable.

## Building shellcode and test tools

Prerequisites:

- make
- gcc
- ability to compile 32 bit binaries via your distro's multiarch packages (ex: gcc-multilib)
- nasm

Simply type 'make' in this directory and everything should work unless one of the
prereqs above is absent.

## Testing

After building:

	$ ./test shellcode

By default, this is set to listen for connections on port 4444 and executes /bin/sh

## Changing the port

- Determine which port you want to use. It is a good idea to use a port greater than
  1024, because most systems require root access to bind to a port below 1024.

- Translate this to hexadecimal in network byte order. This is done easily with python:

	$ python -c "import socket; print '0x%04x' % socket.htons(1280)"

- Edit the PORT variable within bindshell.asm to contain this hexadecimal value.

- Recompile and test:

	$ make clean && make

- Test again to make sure it works and get your shellcode string:

	$ ./test shellcode

