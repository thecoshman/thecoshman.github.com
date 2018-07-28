---
layout: default
categories: rest
title: What is 'RE-S-T'
is_post: true
comments: true
last_edit: 28 July 2018
---

## So What does 'REST' mean?

In this article, I will take a high level look at what REST means.
The word itself is just an acronym; REpresentational State Transfer.
People will often use the word to describe a service as 'RESTful',
that *should* mean that the service is transferring representations of the state.
Sounds easy, yet it's all to easy to miss the point.
I shall attempt to explain what these three core concepts mean, trying very hard to focus on REST it self, and not details such as HTTP - I will pick on that another time.

### Transfer

This should be the easiest part to understand about REST.
The whole point of a REST architecture is to transfer data, even if that is just sending 'commands' to execute.
With out data transfer, not much exciting is going to happen.
What form this transfer takes does not really matter (carrier pigeons would be a bit slow perhaps).

However, the usual transport choice for REST is HTTP, which has a built-in caching mechanisms (I know, I promised not to dive into HTTP).
When a server responds to a 'GET' request with a resource there can (hint - will almost always) also be some meta-data;
one piece of this meta-data will tell the client for how long it should cache this resource.
If clients respect this properly, it can really help reduce server load, and thus response times for clients.

There are of course some resources that cannot readily be cached.
Take an example site that offers conversion rates for currencies, it has a URI like 'http://convertor.com/USD/EUR'.
GETting this URI will return a simple string such as '0.74763' as well as a `cache-control` header value such as 'max-stale=600'.
The server is basically saying that if a user wishes to GET this URI within ten minutes, it should just use the same response.
This is particularly useful when it comes to content that can take time to generate.

In my opinion, details such as caching are some what superfluous to REST.
Yes, you do need to consider such details; but it should be considered as a separate problem really.
Knowing how long to tell a client to 'cache' a result should not impact *how* a client actually gets that result in the first place.
So, although *some* behaviour can be implemented there,  the 'transfer' side of things within REST is kind of boring.

### State

> But I thought REST was about stateless client server model?

Yes, it is, and it does that by ensuring each request contains the full state required to carry out the request.
The state is 'stored' within the requests themselves rather than on the server as some 'magic' data the server knows about the client.

#### Stateful

I think it is easier to first explain what a state-full protocol looks like.
With a stateful protocol, individual messages rely on messages that are exchanged to provide context.
Take careful note, previous messages provide **context** to the later messages.
There is also the presumption that the server knows who the client it is and what the client is up to;
the server is expected to be able to take two isolated requests from a client and know how they relate.

An example of a well known stateful protocol is FTP.
When you use FTP, you do so in a clearly defined session;
there is well defined begin and end, and any other action takes place within this session.
Once logged in, the FTP server keeps track of your current directory, so that when you ask 'what directory am I in' (ls), It can tell you.
Changing directory is done by just naming a directory you wish to go into, relative to where you *currently are*, such as 'up to the parent folder' (cd ..), 'go into the sub folder *sample*' (cd sample) etc.
It gets even more stateful when you 'put' a file onto the server.
You just issue the command 'put this file called phonebook.txt' (put phonebook.txt), you never say where to put it, as the server knows (and thus puts the file) where you currently are.
When you ask for a 'directory listing', you do not need to say which folder to list, the FTP server knows what folder you are in and thus lists that folder.

#### Stateless

If we compare stateful FTP to what a stateless version of FTP would be like, the first thing you will get rid of is this idea of a session.
A 'session' would be some magical construct that ties multiple requests together, it simple does not exist in a stateless protocol.
Instead of a defined 'I am logging in now' step, each request you make **has** to carry that data to authenticate your stateless FTP request;
'here is my ID, do this'.

As there is no session, there is no session data, so all 'session' data (such as 'current folder') will have to be supplied as well.
The request 'list current directory contents' no longer makes sense;
instead, you have to ask 'here is my ID, list directory contents for directory XXXX', explicitly stating what directory you wish to have the contents listed for.
The same logic applies when it comes to putting a file on an FTP server, the request has to contain the full path of where to put the file.
That command contains everything the server needs; who to execute the command as, their password, the action they want to do (list directory contents), and the options required for that action (a directory to list contents for).

As an example, here is what some of these commands *could* look like:

* `user:password put myLocalFileToUpload.log /tmp/myUploadedFile.log` - upload a file
* `user:password rm /home/user/myShamefullPartyPhoto.png` - remove a file
* `user:password ls /home/user/` - list a directory

#### In Short

The 'stateless' nature of REST is not that there is no state at all, but that the server does not track what state the client is in.
Each and every request from a client must carry all the information required to complete the request in full,
it cannot rely on the server 'just knowing' what the client had previously done.

#### Why Bother?

Now, there are obvious disadvantages to a stateless protocol.
For example, you have to go through the authentication procedure more often (every single time).
You should certainly keep this in mind when designing the security:
those knowledgeable about security could tell you if it's easy to 'weaken' the system,
but that is out of the scope of what I am covering here.
The gains though are rather great.

For a stateless server, you have to do less work.
Either way you need to implement the actual business logic, the code that actually performs the actions you wish your system to provide.
Either way you need to implement some way of authenticating the actions a user wishes to make.
The difference though is that for a stateless system, that is it;
request comes in, you authenticate it, you perform the action.

A stateful system though needs a way to manage the session;
you have to authenticate the initial login, and each request you have to still ensure it is part of that session.
I would also argue the business logic is easier to implement statelessly;
you can, well have to, enforce that the clients send all the details they require for a request.

#### Proceed With Caution

However, this can be taken too far.
Consider a user wishing to delete two files, so sends two 'delete' requests;
but what if the user is mistaken, and the second file has already been deleted and so will fail to delete.
You could (mistakingly) argue that the delete request should fail because the 'state' was not 'correct'.
This is an understandable assumption, but missing the point.
The delete request (for a file that did not exist) was itself a well formed request, it is just one that a server cannot successfully complete.
It was still stateless, as the request from the user did not require the server to know about any previous actions;
in particular, it did not matter if the user had created that file in the first place or not, either way the delete request still made sense and so the server can act on the request; how it responds in this situation is another issue;
either report the delete was successful as it is the same end result, or report it as a error as the file requested to be deleted could not be found.

### Representational

When you use a REST interface, you are working with representations.
Consider this in terms of the web.
A URI such as 'mysite.com/example' is a way of identifying a resource.
When you make a request to GET this 'example' resource, you are not (normally) saying anything about how you wish it to be represented.
When you are presented the resource, it will come with some meta data saying what form the representation is in.
This 'meta data' will allow you, the client program, to know how to interpret the raw data just sent you.
This idea is actually just common sense;
remember that REST is describing a generic program architecture, it is rather obvious that you can not dictate a one data format.
Different applications will place different needs on the format of the data they need to send.

Part of the theory would leave clients having to react to whatever representation the server provides.
This would be a programming nightmare.
Luckily, it is very easy for a service to only provide one consistent format; it also lines up with idea of 'caching' resources.
A client need not request the same resource a second time if the max-age has not yet been reached; the logic being, the resource will still be exactly the same and it is bad to 'waste' bandwidth, so don't re-request it.
If each time the client requested a resource it got a different representation, it could still function, but the merit of its cache is servilely diminished.
Again, much like the shocking fact REST involves transferring data, this 'representational' business is rather sedate.
It boils down to a simple, and rather obvious, represent data how it best suits *your* application.

The 'representational' aspect to REST is also referring to the 'state' of the client.
As the server does not store any state data, it is up to the client to transfer it to the server.
It is the clients responsibility to send to the server details such as what items a client has in its 'shopping cart' (when it needs to send that information). Yes, constructs such a shopping cart should only exist on the clients machine.
There is no need for a client to tell the server what items it is thinking about, until it wishes to purchase those items.
This goes directly against what most shop sites would want.
As much as it may not be 'REST', knowing what potential customers are looking at and what they are thinking of buying is very interesting information.

To preemptively shoot down ideas that it is all about shops, allow me to provide a real world game as a bit a study, [Candy Box](http://candies.aniwey.net/index.php).
In this web based game, the progress of the player is kept client side, in fact all the processing is done client side.
The aspect of Candy Box that I want to focus on is how the game is saved.
It provides a 'save' button, and on clicking it you are presented a message saying your game is saved under a random name, this name can used as part of the URI to restore the state of your game.
You could write command-line version of this game and still interface with the same save server that the web based version uses.

## Wrap It Up

To try to condense that all down to a few key points about what REST is / means.

* Representational - Clients send a representation of what 'state' they are in, they are given representations of the resources they request
* State - The server does not store state about clients or sessions, it is the clients responsibility to send all required data
* Transfer - At the end of the day, it's about moving data from A to B

The stateless nature is the biggest aspect, and has strong influence on the other two.
Representation of the state means sending only what is required by a server to complete a request.
As the architect of a system, you are free to apply the principles of REST as strictly as you wish, there are situations where being a bit stateful has advantages.
Whilst the representations can take any form, it is better to decided what one form you will use, and again it is up the you the architect to work out which to use.
