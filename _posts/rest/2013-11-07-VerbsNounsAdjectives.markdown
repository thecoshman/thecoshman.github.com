---
layout: default
categories: rest
published: false
title: Verbs, Nouns and Adjectives?
is_post: true
---

## Let's talk HTTP

I have said in previous articles how REST should not automatically imply HTTP; for this article at least, I will concede that REST is in-fact almost always implemented over HTTP.
And whilst I am getting these confession out of the way, adjectives are not a part of this article.
This article is going to look at the 'verbs' of HTTP, otherwise known as the 'methods'.
The nouns are just the resources that a user calls methods on. 
A HTTP request contains a verb for what they want to do along with a URI to say on what noun you want to do this action. 

HTTP1.0 got the ball rolling with three methods; GET, POST and HEAD. HTTP1.1 introduced five more; OPTIONS, PUT, DELETE, TRACE and CONNECT. 
That's it, as far as [RFC2616](http://tools.ietf.org/html/rfc2616) is concerned there are only eight types of request to make all the magic work. 
Well, not exactly, as the protocol does allow for a server to accept other methods. 
It also fails to cater for what I would consider a rather 'normal' task, but I will leave you in suspense about this until later.

## Dissection Time

Before I start explaining what the HTTP methods mean and how they are intended to be used I shall cover the concept of 'safe' and 'idempotent' methods. 
A method is considered 'safe' if it does not present to the user any side effects on the server. 
A GET method is a fine example of this, when a user GETs a resource they should not expect (to be able to observe) anything changing on the server beyond them being sent the resource they requested. 
The server is not forbidden from making changes, such as logging that user X requested resource Y, but the key is that the the user is not exposed to such changes. 
The user should feel safe to make 'safe' request knowing that they are not about to see some other resource deleted.
A stress is made within the specification that methods that are not safe should be presented by the user agent as significant; 
If the user asks to GET a resource, just go for it, all that *should* do is retrieve the resource; but if the user wants to DELETE a resource you had best make sure because that is not 'safe'.

Idempotent methods are 'those that have the property of idempotence', which seem like the specification is saying "hot things are hot". 
In laymen's terms, idempotent methods would be ones that you can apply repeatedly without the effect changing. 
Again, GET is a good example, no matter how many times you GET a single resource, the result is the same.
DELETE is also considered idempotent, obviously you can only delete a resource once, but think not of the action of deleting, but the effect of a resource no longer existing.
According to the specification it is possible, though I do struggle think how, that a series of idempotent requests is not itself idempotent.

For the sake of brevity and keeping focused on the methods them selves, I will refrain from talking about all the other things that a server could respond with, like authentication requests.

### GET

The GET method is a straight forward method to understand. 
It is both safe and idempotent. 
A client will 'GET' a URI and the server will respond with the resource. 
There is potential for a client to indicate in the headers how they want the resource presented, xml of json for example. 
Along with the resource, the server can provide some meta data, such as how to interpret the resource.

Usually, there would be no need for a clients GET request to contain a body.
Why would you need such a body in a GET request, can you even do that?
For most situations, you wouldn't, but the fact that you even can seems often overlooked.
If your GET request is just trying to get one static resource from one URI, there is not much more that the request needs to say (beyond what the header would be used for).
It can be very useful when the URI is used to access 'dynamic data', for example if you want to GET search results or multiple 'things'. 
A common solution to providing 'meta data' for a GET request is to use a 'query' string at the end of the URI.
Query strings can look ugly and can get a bit hard to manage when dealing with complex data sets, so it is nice to have the request body as an alternative.
I'm not advocating either way, your application will dictate what makes the most sense.

### POST

The POST method is used to store a 'thing' on the server 'somewhere' - fuzzy I know, sit tight.
Obviously this method is not safe, that would imply that once a 'thing' was POSTed to the server a client could never see it, and so POSTed that 'thing' for no reason.
Neither is this method idempotent, every time a client POSTs a 'thing' to a server, it should return a new URI that can be used to GET that 'thing' back again (in some form).

I keep saying 'thing' because there really is no limit on what the client can send to the server, nor what the server then does with that.
A client could POST some data in XML, with which the server could then process and store in a relational data base and offer a URI that can retrieve this new data in some bespoke format
Of course, the server is under no obligation to actually store what it is sent (such as if the URI does not except POST requests), but when it does store what it is sent, it should be telling the client where it is stored.
You also need to consider that the URI that is to be used to GET the new resource is completely up to the server.


### HEAD

A HEAD request is just like a GET request in more or less every way, except the server should not only send the header information that it would send.
I can only guess that in the early days when HTTP was being thought up, it was useful to have some sort of 'probe'.
Perhaps it was useful to be able to see if a resource is still at a URI without having to actually transfer it.
Just like GET, this is safe and idempotent.
I wouldn't go as far as to say you *shouldn't* use use this method, but I doubt you will have much use for it.

## The Bail Out

As short as this article is, it is actually taking me longer than I expected to write. 
This is partial because I want to make sure I don't get things wrong; 
but a good part of it is because I have not spared enough for this.
So far I have covered the three methods that HTTP 1.0 started with, and I want to get something up, so I shall tackle the methods introduced by HTTP 1.1 next time.
