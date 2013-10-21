---
layout: default
categories: rest
published: false
title: Verbs, Nouns and Adjectives?
is_post: true
---

## Let's talk HTTP

I have said in previous articles how REST should not automatically imply HTTP; for this article at least, I will conceede that REST is infact mostly implemented over HTTP.
And whilst I am getting these confesons out of the way, adjectives are not a part of this article.
This article is going to look at the 'verbs' of HTTP, otherwise known as the 'methods'.
The nouns are just the resources that a user calls methods on. 
A HTTP request contains a verb for what they want to do along with a URI to say on what they want do this action. 

HTTP1.0 got the ball rolling with three methods; GET, POST and HEAD. HTTP1.1 introduced five more; OPTIONS, PUT, DELETE, TRACE and CONNECT. 
That's it, as far as [RFC2616](http://tools.ietf.org/html/rfc2616) is concerned there are only eight types of request to make the all that magic work. 
Well, not exactly, as the protocol does allow for a server to offer other methods. 
It also does not quite cater for what I would consider a rather 'normal' task, but I will leave in suspense until later.

## Disection Time

Before I start explaing what the HTTP methods mean and how they are intended to be used I shall cover the concept of 'safe' and 'idempotent' methods. 
A method is considered 'safe' if it does not present to the user any side effects on the server. 
A GET method is a fine example of this, when a user GET's a resource they should not expect (to be able to observe) anything changing on the server beyound them being sent the resource they requested. 
The server is not forbidden from making changes, such as logging that user X requested reqource Y, but the key is that the the user is not exposed to such changes. 
The user should feel safe to make 'safe' request knowing that they are not about to see some other resource deleted.
A stress is made within the specifcation that methods that are not safe should be presented by the user agent as significant; 
If the user asks to GET a resource, just go for it, all that *should* do is retrieve the resource but if the user wants to DELETE a resource you had best make sure because that is not 'safe'.

Idempotent methods are 'those that have the property of idempotence', which seem like the specifcation is saying "hot things are hot". 
In laymens terms, idempotent methods would be ones that you can apply repeatedly without the effect changing. 
Again, GET is a good example, no matter howmany times you GET a single resource, the result is the same.
DELETE is also considered idempotent, obviously you can only delete a resource once, but think not of the action of deleting, but the effect of a resource having been removed.
According to the specification it is possible, though I do struggle think how, that a series of indempotent requests is not itself indempotent.

### GET

The GET method is a streight forward method to understand. 
It is both safe and indempotent. 
