---
layout: default
categories: tag
title: Version One
is_post: true
comments: true
last_edit: 28 July 2018
---

## Say what you want, it's still a game!

Well then, there we go; as utterly terrible as it might be, it most certainly is a game! 
I am not looking for reassurance that I've not made something utterly sinful; and I am not quite cheeky enough to dare claim this is some bold statement about what makes a game. 
This is something that you can interact with and have a way of 'winning', you really can't argue that it isn't a game!
I aimed to just get a game completed, and I did it.

Now, I'm not going to make any promises about weather or not you can run this, but if you want to try it, [here](/downloads/tag/TAGDV1) is a pre-built version of the game. 
This is built for 64-bit linux, Ubuntu specifically. 
I don't think you will need anything specific, other than being able to run at least OpenGL 3.3.

![Sample of V1](/images/tag/v1/sample.png)

## Game Review

So, I guess I should get into the self improving mindset and break this game down as a sort of review. 
This game uses *just* the keyboard for input, the mouse wasn't required so wasn't used. 
The 'A' and 'D' keys are used to rotate left and right respectively, with 'W' and 'S' to move forwards and backwards. 
If you find yourself unable to handle the frantic excitement, then you can quit using the ever classic 'Esc'.
The aim of the game is to move towards the ominous black box, and to do so a few times to then win. 

There is no fail state, you just have to keep going. 
Menus are nowhere to be found, the game starts up and throws you right into the gripping action. 
Not everything is even done 'in the game', I cut corners and used the console to print messages for when you get the box and win. 
The astute and avid TAG player might notice that when you get the box, it moves to the same spot each time. 
Again, in the interest of 'just make *any* game' I didn't take the time to bother with randomising it's location.

### Meet the spec?

So, in my previous post I laid out a sort of specification for this game. 
It was primarily a way to help me focus on completing something and not sidetracking trying to do fancy things.
Did I meet that specification? 
No.
Do I care?
No. 
To be fair, I was nearly spot on with it, only two real differences from the spec.
I had the game win with only a few points rather than ten, but come on, that's nothing really.
I also didn't bother to add a way to loose the game, but I felt like it was better to finish this and move on then get hung up that.

## Technical review

Man, this reminds me of when you've caused some trouble in school and you know the teachers know you did it, but still they insist on waiting for you admit it.
Feel free to take a look at the 'amazing' code [here](https://github.com/thecoshman/tag/tree/v1) on github. 
Seriously though, please keep in mind what the purpose is here, to complete the project quickly, and as such, I know full well this code is terrible. 
I did a quick hack and slash to get something finished, something I can move on from.
The entire game (well, *my* side of it) is in just one file, oh yes it's that level of bad! 
Most of the code is copied over from an example provided by the main library that I used, [glsdk](http://glsdk.sourceforge.net/docs/html/index.html); 
well ok, it's set of libraries really. 

The 'game loop' for this is about as simplistic as you can get, it just does a render and then updates, each loop as fast as it can. 
There is lots to be said about how a game loop can be done, and most tutorials or discussions will show this approach as the starting point and then quickly move onto better things. 
From the example I have some functions that initialise most of the stuff, though not quite everything is done in there.
The display loop is effectively binding and then unbinding the resources for no reason.
Shader code is baked into the C++ rather than loaded from disk. 
I did put some effort into 'upgrading' the example so that it uses an index buffer, rather than just a big long list of (mostly repeated) vertex data.
All in all, probably the worst thing about the use of OpenGL in this is that I am using it directly, rather than making use of some wrappers that I had worked on before with a friend. 

The build system that glsdk comes with is premake4, something I've never really used before, but I stuck with it none the less. 
If I wasn't using an IDE, I got on relatively fine using raw make files. 
In fact, I've even messed around with writing my own build system in Perl that I called [Pink Pill](https://github.com/thecoshman/pinkpill), though that was more about getting more familiar with the C++ build system than actually trying to make a viable tool.
Still, I've got to say, using premake4 was relatively simple. 
In about an hour I managed to take the examples and work out how to wrangle it into doing what I want to do. 
And whilst cross platform development is something I certainly am not bothering with for now, it is nice to know that (at least in theory) premake will ease going to other platforms. 

I was going to make my code compile for C++14, but when I realised that my compiler needed updating I took the quick (ie almost instant) option and settled for C++11. 
Something that I need to rectify before I press on, starting a project on anything but the latest technology at the time is hard thing to excuse.

## V2

Sadly, this will not involve rockets; maybe some jazzed up graphics.

I think my next step will be more of technical update. 
Like I said, I have previously worked on some abstractions of low level things, like buffers, textures and shaders. 
So one of the first things I'll do is look to pull those in, though it seems since they were written glsdk has subtly changed the way it names things in the 'gl' namespace that it provides, nothing major. 
This will also mean that I have to take the time to work out how to organise the project with premake, meaning I have to yet again work out if I want to have just one 'src' folder or also have an 'includes' folder. 
And then, I should be able to tart up the graphics a bit and have a texture applied to that black box, something more fitting of it's crate like nature, because what game is complete without crates!

I guess I should aim to make the game more 'game' like as well, so I might look to make those boxes spawn in random locations (rather than moving the player, if you didn't spot that trick). 
I might also have multiple boxes at once that you have to get to instead of just one box over and over. 
As a final touch, maybe start do some proper collision detection & resolution and so prevent the player moving into the boxes.
