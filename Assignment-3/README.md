# Assignment 3: Egghunter

## Criteria

- Study about the Egg Hunter shellcode
- Create a working demonstration of Egg Hunter
- Should be easily configurable for different payloads

## About Egg Hunters

This type of shellcode is useful in situations where you do not have a
lot of buffer to work with. Often, you can place bigger chunks of data
into memory via other means not relevant to the buffer being
exploited.

With an egg hunter, a token is appended to an additional shellcode
which is planted elsewhere in memory. The exploit payload is a small
routine that searches for this token in memory and executes the larger
shellcode once the token is located.
