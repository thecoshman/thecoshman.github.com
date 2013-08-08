---
layout: default
categories: rest
published: false
title: What REST Is Not
is_post: true
---

## What REST Is Not

To give the shortest answer to "what REST isn't" I would probably just say "a protocol".
It may seem trivial, but it is a very important detail.
In fact, I might even go as a far to say that it is the most important detail, and hopefully after this article you will understand why I think this.
What it tells you, at the most simplistic of levels, is that you have to remember 'REST' is nothing more then guidelines, there is no right or wrong.
That said, whilst there is no right and wrong, there is still good and bad.

### What *is* a Protocol

Taking the definition from the [OED](http://oxforddictionaries.com/definition/english/protocol) a protocol is defined as, in the context of computing:

> A set of rules governing the exchange or transmission of data between devices

The key word there is 'rules', it is this ides that REST is 'rules' that I find most disturbing.
There are no rules regarding REST saying you must work in a certain way.
If you attempt to follow a set of rules for REST you will likely find your self attempting to design a terrible API.

### Time for a Cup of Tea

There is a mildly amusing ISO standard for brewing a cup of tea, [ISO 3103](http://en.wikipedia.org/wiki/ISO_3103).
Now, to be fair, there is a reasonable purpose for such a standard, comparing 'blends' of tea is 'easier' or 'better' when brewed in a consistent manor.
The point I want to consider with this standard is that it defines 'rules' for making a cup of tea.
In practice people are not going to claim your tea is not tea because you brewed it for only three minutes rather then the six minutes the standard dictates, but nonetheless we have a set of rules as to what constitutes tea.

Brewing tea is a rather abstract concept, one that does not map well to a protocol, in my opinion.
Again, going to the [OED](http://oxforddictionaries.com/definition/english/tea), tea is basically just tea leaves infused into boiling water.
There are a few guidelines that I am sure every one would agree on though:

* Use hot water
* Soak the tea in the water
* Remove the bag once it is brewed 'enough'
* Add some milk to suit your taste
* Add some sugar to suit your taste
* Have a few biscuits on the side

But then again...

* How hot? Does it even *have* to be hot, what about iced tea?
* 'bag? surely you use loose tea leaves good sir!'
* milk and sugar? 'to suit your taste'? no fixed amounts? I've seen people have nearly half the cup as milk!
* Biscuits... can't I just have biscuits?

So what's my point?
Whilst protocols can be good, they can also be bad. 
The ISO 3103, might allow you compare tea in a more uniform way, but it obliterates peoples freedom to have tea that suites their tastes.
And it is that analogy I want to bring over to REST.
REST is not a protocol, and that is a brilliant thing!
There are certain protocols you would make use of, JSON and HTTP come to mind, but the meat of your API design is unconstrained.
Kepe in mind though, there are still expectations of how REST will work, just like people tend to expect tea to  be served in a cup or pot.

### What else is it not?

REST is not about (focused on) transferring data.
It is about presenting an interface in a 'nice style', and whilst this will obviously involve sending data, the data itself is of little concern to REST design.
Within the REST mindset, data is no more than an abstract concept, it is a payload that is requested by a client, modified by a client, sent from a client.
The data you are sending could even be physical money and physical sandwiches, like in real life shop.

You could go to an extreme with this thought and say that really, REST doesn't even require the concept of computers.
Yes it does build on the ideas of HTTP, but the core concepts of REST do not depend on it really.
To take the sandwich shop example to an extreme, you have an underlying 'protocol' of human interactions; which has a some basic 'methods'.

* ASK a question -
    "How much is it for a BLT?", to which to standard response is along the lines of "A BLT is three Euro"
* REQUEST an item -
    "Can I have a BLT", to which the response would be "No, you did not give me the three Euro it costs"
* REQUEST an item, handing over money (a payload) -
    "Can I have a BLT, here is three Euro", to which you hope you get the response "Yes, here is your BLT"

Now, this is not the perfect analogy, but hopefully you can see my point, the principles of REST have been applied to the process of ordering a sandwich, using a basic 'protocol' for human interaction.
I do not want to jump ahead of myself here, but I must seize the opportunity to point out how I framed that as a stateless series of actions; when it came to paying for the sandwich, it did not rely on having previously asked about the BLT, you could jump directly to "Can I have a BLT, here is three Euro".
Like I said, I do not want to get carried away with such details, it is for a later article.
The analogy also helps show how the data that is being transferred is rather trivial, what matters is *how* it is transferred.
Again, sort of jumping the gun here, but the sandwich you are given by the sandwich master is not the exact BLT in the picture, but a *representation* of it; it just so happens that the representation you are given is a deliciously edible one.

To toy with pedant-ism, some people might claim that one of the strengths of REST is that it is 'lightweight'.
'Lightweight' is a relative term, a blue whale is lightweight compared to the planet, itself lightweight compared to the sun, itself lightweight compared to [Betelgeuse](http://en.wikipedia.org/wiki/Betelgeuse).
It is true the a REST interface does not add much 'overhead' to HTTP, which it is so often used with, but that does not make it 'lightweight'.
HTTP is a rather 'chatty' protocol, and if you were *really* concerned about amount of data being sent, you would not use long wordy string based messages to communicate with a server.
Yet people do use long wordy string based messages to communicate with servers, because it works.
I am sure you could make a binary version of HTTP, reducing the size of messages dramatically, and use binary payloads for the data you send back and forth.
Practicality steps in the way though, it takes time and effort to ensure you have done it correctly and HTTP has already solved these problems.
You would need a good reason to wish to break away from such a wide spread system for which nearly every one has a client for, web browsers.
So to say REST is lightweight is not really saying anything, what you really mean is that it does not impose any unnecessary overhead to existing protocols.

As a final thing that REST is not, I will say that it is not an amazing new technology.
Firstly, it' a fairly old now, the term itself 'coined' over ten years ago.
It is not really technology in and of itself, it is just a way of using existing technology.
And whilst it is nice, it is not *amazing*.
REST is just guidelines for good practice of existing technology.
I've seen this sort of 'hype' around REST, that by adopting it all your problems can go away.
Sure, REST can be a very nice style to solve your problem, but you shouldn't go shoehorning the problem to fit a REST solution.
Maybe, *maybe*, you really do need to have a state-full system to solve your problem.

### Parting Thought

When it comes to designing your own API for a service, I think it is important to remember, there are no rules to REST.
It is a style, and just like styles in real life, it can change with time, especially when it has to fit in with *your* scenario.
Use REST as a guideline, but make sure *your* API makes sense for *your* situation.

