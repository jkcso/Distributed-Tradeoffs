# Distributed Algorithms' Tradeoffs 

## *Inspired from Christian Cachin's book "Introduction to Reliable and Secure Programming".*

A practical evaluation of the iconic distributed algorithms demonstrated and discussed in Christian Cachin's book "Introduction to Reliable and Secure Distributed Programming".  Each system demonstrated in this repository incrementally adds further functionality to the base system demonstrated in System 01.  Final goal is to achieve a reliable broadcast in asynchronous message-passing distributed system that is subject to process failures.  This implies guarantees that messages are consistently delivered to all processes along with an agreement on the delivered messages.

Specific information regarding individual system runs can be found inside each system's dedicated folder.  An outline of what each system explores follows:

## System 01
### BEB (Best Effort Broadcast):
Given a list of all processes and a message, a process could send the message to all processes (including itself) with multiple sends, something like:

`for p <- processes, do: send p, message`

Sender does not know which processes received the message.  We'll assume (i) messages are unique (e.g. include process-id+seq-no), (ii) no process broadcasts a message twice, (ii) no two processes ever broadcast the same message.

## System 02
### RB (Reliable Broadcast):
For best-effort broadcast, if the sending process crashes during broadcast, then some arbitrary subset of processes will receive the message.  There is no delivery guarantee – processes do not agree on the delivery of the message.  With (regular) reliable broadcast all *correct* processes will agree on the messages they deliver, even if the broadcasting process crashes while sending.  If the broadcasting process crashes before any message is sent, then no message is delivered.

## System 03



## System 04



## System 05



## System 06



## System 07
