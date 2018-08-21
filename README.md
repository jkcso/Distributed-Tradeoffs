# Distributed Algorithms' Tradeoffs 

## Inspired from Christian Cachin's book *"Introduction to Reliable and Secure Programming"*.

A practical evaluation of the iconic distributed algorithms demonstrated and discussed in Christian Cachin's book "Introduction to Reliable and Secure Distributed Programming".  Each system demonstrated in this repository incrementally adds further functionality to the base system demonstrated in System 01.  Final goal is to achieve a reliable broadcast in asynchronous message-passing distributed system that is subject to process failures.  This implies guarantees that messages are consistently delivered to all processes along with an agreement on the delivered messages.

Specific information regarding individual system runs can be found inside each system's dedicated folder.  An outline of what each system explores follows:

## System 01
### BEB (Best Effort Broadcast)
Given a list of all processes and a message, a process could send the message to all processes (including itself) with multiple sends, something like:

`for p <- processes, do: send p, message`

Sender does not know which processes received the message.  We'll assume (i) messages are unique (e.g. include process-id+seq-no), (ii) no process broadcasts a message twice, (ii) no two processes ever broadcast the same message.

## System 02
### RB (Reliable Broadcast)
For best-effort broadcast, if the sending process crashes during broadcast, then some arbitrary subset of processes will receive the message.  There is no delivery guarantee – processes do not agree on the delivery of the message.  With (regular) reliable broadcast all *correct* processes will agree on the messages they deliver, even if the broadcasting process crashes while sending.  If the broadcasting process crashes before any message is sent, then no message is delivered.

## System 03
## RB (Eager Reliable Broadcast)
Every process re-broadcasts every message it delivers.  If the broadcasting process crashes, the message will be forwarded by other processes using best-effort-broadcast.

## System 04
## RB (Lazy Reliable broadcast)
Uses best-effort-broadcast, but includes a failure detector component to detect processes that have failed (stopped).  Agreement is derived from (i) the validity property of BEB, (ii) that every correct process forwards every message it delivers when it detects a crashed process and (iii) the properties of PFD. Other properties are as for the Eager RB algorithm.

## System 05
## PFD (Perfect failure detector)
Provides processes with a list of suspected processes (detected processes) that have crashed.  Makes timing assumptions (assumes systems are not asynchronous).  Never changes its view – suspected processes remain suspected forever.  Uses PL to exchange heartbeat messages plus a timeout mechanism (Recall PL performs reliable sending for correct processes).  Delay for timeout needs to be large enough for sending to all processes, processing at receiving processes and all replies back.  After a timeout, any process from which a reply has not been received is considered crashed, even it is alive and the reply message arrived after the timeout.

## System 06
## URB (Uniform Reliable Broadcast)
Validity, No Duplication and No Creation properties are the same as best effort broadcast and regular reliable broadcast.  If a process delivers message M then every correct process will also deliver M.  Implies a set of messages delivered by a faulty process is always a subset of messages delivered by a correct process (stronger guarantee).

## System 07
## URB (Majority-Ack Uniform Reliable Broadcast)
(URB) Deliver message only after the message has been beb-delivered by a majority (quorum) of processes.  The majority contains at least one correct process.  Fail-silent algorithm where process crashes are not reliably detected.  
