---
layout: default
categories: rest
published: false
title: What is 'RE'; What is 'ST'
is_post: true
---

## So What does 'REST' mean?

In this article, I will take a highlevel look at what REST means. 
The word itself is just an anagram; REpresentational State Transfer. 
People will often use the word to describe a service as 'RESTful', 
that *should* mean that the service is transfering representations of the state.
Sounds easy, yet it's even easier to miss the point. 
I shall atempt to explain what these three core concepts mean, trying very hard to focus on REST it self, and not details such as HTTP - I will pick on him another time.

### Transfer

This should be the easiest part to understand about REST. 
The whole point of a REST arhcitecture is to transfer data, even if that is just sending 'commands' to execute.
With out data transfer, not much exciting is going to happen.
What form this transfer takes does not matter, carrier pidgeons would work just fine... though a bit slow perhaps. 

However, as much as REST is about trasnfering data, it is more about not trasnfering data. 
I know I said I would try to avoid this, but we do have to admit, HTTP plays a big part when talking about REST.
HTTP provides this idea of a caching. 
When a server responds to a 'GET' request with the actual resource there can (read, will almost always) also be some metadata; 
one bit of metadata will tell the client how long it should cache this resource for. 
If clients respect this properly, it can really help improve how much load a server can handle, and thus load times for clients. 

There are ofcourse some resources that can not be cached so readily. 
Take an example site that offesr conversion rates for currencies, it has a URI like 'http://convertor.com/USD/EUR'. 
GETting this URI will return a simple string such as '0.74763' but also a 'cache liftime', such as '600 seconds'. 
The server is basically saying that if a user wishes to GET this URI within ten minutes, it should just use the same response.
This is paticularly usefull when it comes to content that can take time to generate.

To be fair, details such as cacheing are some what superflious to REST in my opinion.
Yes, you do need to consider such details; but it should be considered as a seperate problem really. 
Knowing how long to tell a client to 'cache' a result should not impact *how* a client actually gets that result in the first place.
So the 'transfer' side of things within REST is kind of boring. 

### State

> But I thought REST was about stateless client server model?

Yes, it is, but it does that but ensuring each request contains the full state required to carry out the request.
The state is 'stored' within the requests them selves rather than on the server, rather then as some 'magic' data the server knows about the client. 

#### Statefull

I think it is easier to first explain what a statefull protocol is and (roughly) how one works.
With a statefull protocol, indavidual messages relly on messages that are previously sent to provide context.
Take carefull note, previous messages provide **context** to the latest message. 
There is also the presumption that the server knows who the client it is and what the client is upto; 
the server is expected to be able to take two isolated requests from a client and know how they relate.

An example of a wellknown statefull protocol is FTP. 
When you use FTP, you do so in a clearly defined session; 
there is well defined begin and end, and any other action you wish to carry out takes place within this session. 
Once logged in, the FTP server keeps track of your current directory, so that when you ask 'what directory I am in' (ls), It can tell you. 
Changing directory is done by just naming a directory you wish to go into, relative to where you currently are, such as 'up to the parent folder' (cd ..), 'go into the sub folder *sample*' (cd sample) etc.
The really stateless stuff starts when you 'put' a file onto the FTP server. 
You just isse the command 'put this file called phonebook.txt' (put phonebook.txt), you never say where to put it, as the server knows (and thus puts the file) where you currently are. 
When you ask for a 'directory listing', you do not say which folder to list, the FTP server knows what folder you are in and thus lists that folder.

Of course, with FTP you can ask for a directory listing of any folder on the server. 
But when you do so, you are still within a session, you did not have to login or provide credentials to perform the action.

#### Stateless

If we compare statefull FTP to what a stateless version of FTP would be like, the first thing you will get rid of is this idea of a session. 
A 'session' would be some magical construct that ties multiple requests together, it simple does not exist in a stateless form.
Instead of a defined 'I am loggin in now' step, each request you make **has** to carry that data to authenticate your stateless FTP request; 
sort of like here is my ID, do this'. 

As there is no session, there is no session data, so a server will not keep track of your current folder. 
So a request 'list current directory contents' makes no sense; without the proper context (from previous requests) 'current directory' means nothing.
Instead, you have to ask 'here is my ID, list directory contents for ~this~ directory', explicatly stateing what directory you wish to have the contents listed for.
The same logic applies when it comes to putting a file on an FTP server, you would have to say the full path to put the file too.
This might come in the form of sending a command to the server something like 'user:password ls /home/user/'. 
That comamnd contains everything the server needs; who to execute the command as, their password, the action they want to do (list directory contents), and the options required for that action (a directory to list contents for).

It is easy to map other commands over to this 'stateless FTP'. 
To upload a file, 'user:password put myLocalFileToUpload.log /home/user/myUploads/myUploadedFile.log'. 
To delete a file, 'user:password rm /home/user/myShamefullPartyPhoto.png'. 
I could go on with this, but I trust you get the point.

#### In short

The 'statless' nature of REST is not that there is no state at all, but that the server does not track what state the client is in. 
Each and every request from a client must carry all the information required to complete the reqeust in full, 
it cannot rely on the server 'just knowing' what the client had previously done.

#### Why Bother?

The biggest draw back to something like a stateless FTP is that you have to go through the authtentication procedure every, damn, time. 
There are draw backs to that I'm sure, those who are more knowledgable about security might tell you if that 'weakens' the system, but that is out of the scope of what I am covering here. 
The gains though are rather great. 

Either way you need to implement the actual bussines code, the code that actually performs the actions you wish you system to provide.
Either way you need to implement some way of authenticating the actions a user wishes to make.
The difference though is that for a stateless system, that is it; 
request comes in, you authenticate it, you perform the action.
A statefull system though needs a way to manage teh session; 
you have to authenticate the initial login, and each request you have to still ensure it is part of that session.
I would also argue the bussines logic is easier to implement statelessly; 
you can, well have to, enforce that the clients send all the details they require for a request. 

#### Procede With Caution

However, this can be taken too far. 
Consider a user wishing to delete two files, so send two 'delete' requests; 
but what if they are msitaken, and the second file has already been deleted and so will fail to delete.
You could (mistakingly) argue that the latter request failed because the 'state' was not set up correctly.
This is an understandable assumption, but missing the point somewhat. 
The delete request (for a file that did not exist) was itself a well formed request, it is just one that a server cannot fully complete. 
It was still stateless, as the request from the user did not require the server to know about any previous actions; 
in paticular, it did not matter if the user had created that file in the first place or not, either way the delete request still made sense.

### Representational

When you use a REST interface, you are working with representations. 
Consider this in terms of the web. 
A URI such as 'mysite.com/example' is a way of indetifying a resource. 
When you make a request to GET this 'example' resource, you are not (by default) saying anything about how you wish it to be represented. 
When you are presented the resource, it will come with some meta data saying what form the representation is in. 
This 'meta data' will allow you, well your browser, to know if it should render a web page, draw the image, play the music file etc.

This idea of using an abstract URI to get any resource is even used in palces other than the web.
Your own computer can be thought of as using URIs to 'point' to files and folders. 
Admitadly, file extensions do sort of confuse matters here; 
but have you noticed that by default will hide known fill extensions? 
It does this, because to a user, the file extension does not really matter. 
If you have a file 'C:\Users\Me\Music\Awesome Album\The Best Song', assuming your files are organised, you do not need a suplerphious file extension such as '.mp3' to tell you the user that you are looking at a music file.
