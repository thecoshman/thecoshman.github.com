---
layout: default
categories: tag
title: Destructible
is_post: true
comments: true
last_edit: 8 April 2015
---

## Call a Clone a Clone

Even if it is not a very good one.

So yeah, it's hard to deny this is starting to show similarities to a popular game.
Yes I know, Minecraft was not the first of it's kind, but face it, it's *the* archetype for well... quite a few styles of games I suppose.
Anyway, I'm not there yet.
This version does add one of those core features that I would say makes Minecraft what it is;
You can place and break cubes!
Again, [here](/downloads/tag/TAGDV3) is a 64bit build for linux, one of these days I'll sort out builds for other platforms, honest!

![Sample of V3](/images/tag/v3/sample.png)

### The Latest Features

A quick summary of the features so far:

* WASD keys to walk around and mouse to look about (If you didn't notice, this is taking things slowly)
* Walk into a box to remove it
* Left click a box will also remove it
* Right click on the side of a box to place a new one
* the keys '1', '2' and '3' swap between the three colours you can place

### Technicalities

From a technical point of view, things are still not that great.
There is AABB-AABB collisions as well as Ray-AABB, which I might do another article about, maybe.
I do currently brute force my way through the collision checks;
somewhat excusable when there is only a handful of checks to make, but sure as hell is not going scale.
The rendering is still rather primitive too, again just brute forcing, drawing each cube in the world one after the other.
There is some respite in that by way of being so limited, I always have the correct data buffers bound, but I am swapping out the texture for each cube.
I'm honestly not sure how much *precious performance* swapping textures back and forth actually wastes compared to working out all the cubes that would want the same.
The cubes are stored in a map keyed on their position, so I suppose you could argue it's very efficient for empty spaces!

## The End?

When I started working on this little project, the point was to just complete *something*.
I did that.
Then I started to work in small steps, adding one or two small things at a time.
The scope was kept *very* small, and I think that has helped me keep focused on what I wanted to do each time.
But let's face it, what I have is not really a game of any merit.
Yes technically it does meet the criteria at a very simplistic level, but it's not a decent attempt at a game.

So what now?
Do I try and see this through to a fully realised Minecraft clone?
Maybe I should start over and focus on doing some other game, working on an original idea all of my own!
Does it even matter!?
Have I even 'finished' this project?
Argh, decisions!

I think the hardest part is getting that idea or inspiration.
Once I know what I want to aim towards, all I need to do is enjoy the ride.
I don't mean to say that it's easy, if anything, quite the opposite.
Whilst I have done this sort of stuff before, I have left it far too long, I've had to remind myself of most of getting this far.
Challenges come up all the time, and it's far to easy to start over.

### Embrace the Clone

I honestly do feel a bit cheap making yet another clone of it, but I do really like that damn game.
At least I have a fairly clear end goal for myself, and I'll say it now, it's not making something that is indistinguishable from Minecraft.
Creativity is not my strongest area, especially when it comes to making games;
maybe this is one of those things that will become easier the more I do it;
but where I can, I will put my own spin on things.
This will sort of be like making a complete mod for Minecraft, so if I want to have erm... thinking... climbing!
Yeah, if I wanted climbing, where blocks can have ledges that players can jump up to and climb up, I can just make that part of the game.

## The Feature List!

I do have some grand ideas of where I would like to take this.
It would be cool to implement my own version of most of the 'features' Mincraft has, more for the challenge of it.
So, obviously, the procedural generation thing has to be done but also multiple 'dimensions', AI entities, inventory etc.
I am not too concerned about getting the breadth of content though, if I can generate two types of ore, I can generate all the types of ore I can tolerate providing the assets for.
Crafting is something I'm not too sure about... I think I'll have a go at copying the 'crafting grid' approach, but I also like the simple 'here is what you can craft with what you have' menu system.

If you permit me to talk about grand ideas, it would cool if more or less everything was modded into the 'game'.
Obviously some things are best just being part of the core game it self, but I want to be able to make it so that more or less everything can be done via mods.
This is fairly easy with Minecraft as it's not *that* hard to patch the 'compiled' code.
For the level of control I want to be able to expose, a proper mod api would have to be designed, actually exporting control out to an interpreted language, Lua sounds tempting for this.

### Small Steps Though

Sticking to these very small and focused updates seems to have worked well for me so far, so here we are.
I want to get some sort of terrain generation implemented, and this will probably be the biggest thing for this update.
There are a lot of ways this could be done, I don't think I'll get too hung up on really good generation... probably just something with a distinct 'unbreakable' bottom layer, then hills of random heights, probably with a top layer.
So, three block types.
Along with this very basic terrain generation, I want to ensure I have a few things.
Firstly, I need to actually be able to walk over these blocks and have them block the movement, rather than removing them as I currently do.
Then I need to get jumping and falling added so I can get up and over all this glorious terrain.
I also need to ensure that this terrain generation is predictable, for a given 'seed' the terrain should always be generated the same way.
There's also the 'chunking' problem... this is something I know will be needed, and I don't think is going to be *that* hard to do... yet I can't help but feel I should simply ignore this one for now.
Finally, learn how to write a list and not a paragraph.

Until next time then!

