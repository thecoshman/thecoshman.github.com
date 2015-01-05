---
layout: default
categories: rest
title: The Other Verbs
is_post: true
published: true
---

## A quick recap

In the last article, I gave a fairly detailed description of the methods that HTTP 1.0 offered; 
in this article, I will carry on with that and describe those methods added in HTTP 1.1, as defined by [rfc2616](http://tools.ietf.org/html/rfc2616). 
Fear not though, most of them are not worth much time so this should be rather quick. 

### The Lesser Methods

#### OPTIONS 

This method basically just let's a client ask what 'methods' would make sense for a given URI. 
I find it hard to see why you would use this these days to be honest. 
It would have been used for more automated exploration of what a service offered, ie crawlers. 
Sounds like if you do need this to be used, your service is not that well designed and/or badly documented.

#### TRACE

More or less a 'ping' like method. 
I'm sure if you are trying to debug some issues it could be handy, but for the now I'm just going to leave it be.

#### CONNECT 

OK, now this is something that you shouldn't have to think twice about. 
It's used to help upgrade from HTTP to HTTPS. 
I'm not an expert on the old security stuff, but as I understand it, most framework will manage this for you.
So, don't think for a second you can avoid using it, equally don't waste time managing this yourself.

### Methods of Merit

#### DELETE

I really wish I could have been there when they realised that HTTP 1.0 didn't allow resources to be deleted. 
I'm sure they had their reasoning, but still, it's there now. 
There are a few interesting points with this method. 
Firstly, the server does not have to actually delete the resource, it's perfectly reasonable to simply make it such that the URI no longer GETs that resource; 
you could move it to an 'admin only' area, or require special permissions to see it (though this is probably not sticking to what DELETE *should* do). 
Equally, you could simply return a 202 (Accepted) response; 
in which case the resource can still be reached, but you have 'promised' that at some stage it will be removed, a concept I find very odd. 
The DELETE method is of course, idempotent; if you ask to delete the same URI twice, you'll get the same response "sure thing, that's gone now".

##### PUT

This is a method that most people seem to use wrong for the most part. 
The basic detail that everyone seems fine with is that it is PUTting a resource to a specific URI, unlike POST which leaves it to the server to decide what the URI will be. 
The idea would be that a user might GET a resource, make some modifications to it locally, and then PUT it back at the same URI they got it from. 
Of course, your server could apply some user permissions to restrict who can PUT that resource back. 

You don't just have to replace the resource though, you could PUT a brand new resource at a specific location and this is where people start to get things wrong. 
It is so common to overlook that that you are PUTting an entirely new resource at that URI!
What ever was there is (well, should) be completely obliterated by this new version.
As such, if a user wishes to just make a slight modification, they have to send the entire new version, even if it is a huge resource.

### But You Just Want to PATCH?

So, all you want to do is provide a partial modification to a resource, you just want to PATCH it up a bit.
This method is not described in the 'official' HTTP 1.1 specification but in [rfc5789](http://tools.ietf.org/html/rfc5789).
Do not discard this method simply because it's not an 'official' method, HTTP does permit your server to define any method you wish, you could define a TRANSFORM method that will manipulate a resource based on some provided data.
PATCH *is* a perfectly reasonable method to use, it is semantic and very easy to support.

Exactly how you implement PATCH is up to you, you could have the client send some key:value data and just update the fields mentioned in the request. 
For more text document like resources, a more standardised 'diff' might make sense. 
I could go on with more examples, but really how to encapsulate the differences really is outside the scope of this article. 
Thinking more in terms of 'RESTful' web applications, PATCH might not be a bad way to send frequent data, such as users sending text in a chat application; 
though really that's entering the world of stream and sockets, which is another thing altogether.

## Parting words

So yeah, HTTP 1.1 provided some missing functionality, but still left some confusion regarding how to modify resources. 
Please do use PATCH when you need to just modify are resource, reserve PUT to complete replacements. 
