---
layout: default
categories: rest
published: false
title: What is 'RE'; What is 'ST'
is_post: true
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

However, the usual transport choice for REST is HTTP, which has a builtin caching mechanisms (I know, I promised not to dive into HTTP).
When a server responds to a 'GET' request with a resource there can (hint - will almost always) also be some meta-data; 
one peice of this meta-data will tell the client for how long it should cache this resource. 
If clients respect this properly, it can really help reduce server load, and thus response times for clients. 

There are of course some resources that cannot so readily be cached. 
Take an example site that offers conversion rates for currencies, it has a URI like 'http://convertor.com/USD/EUR'. 
GETting this URI will return a simple string such as '0.74763' but also a cache-control header such as 'max-stale=600'. 
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
It gets even more staeful when you 'put' a file onto the server.
You just issue the command 'put this file called phonebook.txt' (put phonebook.txt), you never say where to put it, as the server knows (and thus puts the file) where you currently are. 
When you ask for a 'directory listing', you do not need to say which folder to list, the FTP server knows what folder you are in and thus lists that folder.

#### Stateless

If we compare stateful FTP to what a stateless version of FTP would be like, the first thing you will get rid of is this idea of a session. 
A 'session' would be some magical construct that ties multiple requests together, it simple does not exist in a stateless protocol.
Instead of a defined 'I am logging in now' step, each request you make **has** to carry that data to authenticate your stateless FTP request; 
'here is my ID, do this'. 

As there is no session, there is no session data, so all 'session' data (such as 'current flder') will have to be supplied as well.
The request 'list current directory contents' no longer makes sense; 
instead, you have to ask 'here is my ID, list directory contents for directory XXXX', explicitly stating what directory you wish to have the contents listed for.
The same logic applies when it comes to putting a file on an FTP server, the request has to contain the full path of where to put the file.
That command contains everything the server needs; who to execute the command as, their password, the action they want to do (list directory contents), and the options required for that action (a directory to list contents for).

As an example, here is what some of these commands *could* look like:
* `user:password put myLocalFileToUpload.log /home/user/myUploads/myUploadedFile.log` - upload a file
* `user:password rm /home/user/myShamefullPartyPhoto.png` - remove a file
* `user:pasword ls /home/user/` - list a directory

#### In Short

The 'stateless' nature of REST is not that there is no state at all, but that the server does not track what state the client is in. 
Each and every request from a client must carry all the information required to complete the request in full, 
it cannot rely on the server 'just knowing' what the client had previously done.

#### Why Bother?

Now there are obvious disadvantages to a statelss protocol. 
For example, you have to go through the authentication procedure every single time (if you need it authentication). 
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
This 'meta data' will allow you, the client program, to know if it should render a web page, draw the image, play the music file etc.

This idea of using an abstract URI to get any resource is used in places other than the web.
Your own computer can be thought of as using URIs to 'point' to files and folders. 
Admittedly, file extensions do sort of confuse matters here; 
but have you noticed that by default some operating systems will hide known file extensions? 
It does this because to a user the file extension does not really matter. 
If you have a file 'C:\Users\Me\Music\Awesome Album\The Best Song', assuming your files are organised, you do not need a silly file extension such as '.flac' to tell you, the user, that you are looking at a music file.

However, that silly file extension is used by the OS to know what to do with a given resource;
an '.flac' should be opened by a music player, an '.png' is to be opened in an image viewing application, etcetera.
Now I am well aware that files on a computer only have the one way to represent them... mostly. 
HTML files are an exception that comes to mind, you can either edit them as text or display them as a rendered page in your browser.

## Wrap It Up

To try to condense that all down to a few key points about what REST is / means.

* Representations - Clients are given a representation of the resource they request
* Stateless - The server does not store any state about clients
* Transfer - At the end of the day, it's about moving data from A to B

