# Assignment 2: TCP Reverse shell

Reverse shells work in the opposite manner as a bind shell:

- Bind shell: attacker connects to victim, which is listening for incoming connections.

- Reverse shell: victim connects to attacker, which is listening for incoming connections.

See revshell.c for a high level code sample of what this shellcode
intends to accomplish.

## Criteria

- Connects to a host:port

- Provide an interactive shell upon successful connection.

- IP and port should be easily configurable.

## Building

This requires nasm, gcc-multilib (if on x86_64), and GNU make

Configure the reverse shell by editing revshell.asm. HOST and PORT
can be set to their appropriate values using the python one-liners
in the comments. IP addresses cannot have any octets that equal zero
(ex: 10.0.0.1) and ports cannot have any null bytes in them once they
are converted to hexadecimal (ex: multiples of 256 and 1-255).

Building is done with make:

	$ make

## Testing

Set up a netcat listener on another terminal:

	$ nc -nlvp PORT_GOES_HERE

Test the shellcode with test.c:

	$ ./test shellcode

