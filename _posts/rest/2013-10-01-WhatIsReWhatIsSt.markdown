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

### Transfer

This should be the easiest part to understand about REST. 
The whole point of a REST arhcitecture is to transfer data. 
What form this transfer takes does not matter, carrier pidgeons would work just fine... though a bit slow perhaps. 

However, as much as REST is about trasnfering data, it is more about no trasnfering data. 
This is where the idae of a 'cache' comes into play. 
When a server responds to a 'GET' request along with the actual resource, an image for example, tere will be some metadata; 
one bit of metadata will tell the client how long it should cache this resource for. 
If clients respect this properly, it can really help imrpove how much load a server can handle, and the 'laod times' for clients. 
If such an image is used in the background of ever page on a site, rather then request it each time, a client can simply reuse that image.

There are ofcourse some resources that can not be cached so readily. 
Take an example site that offesr conversion rates for currencies, it has a URI like 'http://convertor.com/USD/EUR'. 
GETting this URI will return a simple string such as '0.74763' but also a 'cache liftime', such as '600 seconds'. 
The server is basically saying that if a user wishes to GET this URI within the ten minutes, it should just use the same response.
This is paticularly usefull when it comes to content that can take time to generate.

To be fair, details such as cacheing are some what superflious to REST in my opinion.
Yes, you do need to consider such details; but it should be considered as a seperate problem really. 
Knowing how long to tell a client to 'cache' a result should not impact *how* a client actually gets that result in the first place.

### State

> But I thought REST was about stateless client server model?

Yes, it is, but it does that but ensuring each request contains the full state required to carry out the request.
The state is 'stored' within the requests them selves rather than on the server.

I think it easier to explain what a statefull protocol is, and show how one would work.
With a statefull protocol, indavidual messages that are sent relly on messages that are previously sent to provide context.
Take carefull note, previous messages provide **context** to the latest message. 

Perhaps one of the best known and cleanest examples of a statefull protocol that I can think of, is FTP. 
When you use FTP, you do so in a clearly defined session; 
there is well defined begin and end, and any other action you wish to carry out takes place within this session.
Once logged in, the FTP server keeps track of your current directory, so that when you ask 'what directory I am in', It can tell you.
Changing directory is done by just naming a directory you wish to go into, relative to where you currently are, such as 'up to the parent folder', 'go into the sub folder *sample*' etc.
The really stateless stuff starts when you 'put' a file onto the FTP server. 
You just isse the command 'put this file', you never say where to put it, as the server knows (and thus puts the file) where you currently are. 
When you ask for a 'directory listing', you do not say which folder to list, the FTP server knows what folder you are in and thus lists that folder.

If we compare this to what a stateless version of FTP would be like, the first thing you will get rid of is this idea of a session. 
A 'session' would be some magical construct that ties multiple requests together, it simple does not exist in a stateless form.
Instead of a defined 'I am loggin in now' step, each request you make **has** to carry that data to authenticate your stateless FTP request; 
sort of like here is my ID, do this'. 
As there is no session, there is no session data, so a server will not keep track of your current folder. 
As such a request 'here is my ID, list current directory contents' makes no sense; without the proper context (from previous requests) 'current directory' means nothing.
Instead, you have to ask 'here is my ID, list directory contents for ~this~ directory', explicatly stateing what directory you wish to have the contents listed for.
The same logic applies when it comes to putting a file on an FTP server, you would have to say the full path to put the file too.

In short, the 'statless' nature of REST is not that there is 'no state' but that the server does not track what state the client is in. 
Each and every request from a client most carry all the information required to complete the reqeust in full, 
it cannot rely on the server 'just knowing' what the client had previously done.

However, this can be taken too far. 
Consider a 'shoping cart' for a website, each user should be given their own 'cart', you don't want random items popping in and out your cart.
If a user wishes to empty their cart, they might 'DELETE' their cart, say 'DELETE http://aShop.com/carts/616', where '616' is the ID for this uers cart.
This request could fail if the user did not send sufficent authtenication, which could be some form of cookie that must match what the server has stored, equally the reuqest could fail if cart '616' does not exist.
In both those secnarios, more so the latter, you could mistake this for a statefull situation; the latter request failed because the 'state' was not set up correctly.
This is an understandable assumption, but missing the point somewhat. 
The delete request [for an item that does not exist] isitself a well formed request, it is just one that a server cannot fully complete. 


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
