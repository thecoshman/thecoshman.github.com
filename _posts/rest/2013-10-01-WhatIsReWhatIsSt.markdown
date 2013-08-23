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
People will describe a service as 'RESTful', 
that *should* mean that the service is transfering representations of the state.
Sounds easy, yet it's even easier to miss the point. 

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
