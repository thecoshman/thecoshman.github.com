---
layout: default
categories: tag
title: Quality Graphics
is_post: true
comments: true
last_edit: 28 July 2018
---

## It's all Behind the Curtains

It's still not the prettiest hunk of junk, but textures really do help out, even if they do look like something from an acid trip.
The implementation is most certainly still rough as as all hell, but at least it is starting to take on a more reasonable quality. 
Most of the 'good code' is thanks to including GLDR ([OpenGL Done Right](https://github.com/GLDRorg/GLDR)). 
I think I might also have revealed that I am most certainly not a graphics artist.
As was planned though, this iteration was mostly about updating the code rather than enhancing the gripping game mechanics or deep graphics.

As with last time, [here](/downloads/tag/TAGDV2) is a pre-built version of the game. 
It is still just a linux 64-bit build.
At some stage I might look into building for other platforms with some service or something. 

![Sample of V2](/images/tag/v2/sample.png)

## GLDR

GLDR is a library I started working on with a friend, about two years ago now, it sort of got abandoned though. 
The idea is to provide modern, sensible, nice to use C++ classes that can provide an easier way of dealing with OpenGL resources. 
I think in the end we found other libraries offered more or less what we were aiming for and other interests pulled us away form working on it. 
One of the core ideas that we came up with was a type that can manage the lifetime of OpenGL resources that normally you only have a number to track. 

This type was called 'glid' and is a template type, meaning that if a 'texture' type wants to use this (which it should) it would need to have a 'glid\<texture\>' variable. 
However, glid has a constructor and destructor that will call 'GLuint T::Create()' and 'void T::destroy(GLuint)' respectively, anything that wants to have a glid has to provide these static functions.
By doing this, anything that uses a glid for managing OpenGL resources now has automatic lifetime; 
if a 'texture' ever goes out of scope, it's resources will automatically be released, and you wouldn't have to worry about acquiring those resources in the first place! 
The only requirement is that you need to provide the logic to get and release those resources from OpenGL via static functions in the form that glid expects. 
For some reason when we developed this glid we didn't also require that classes using a glid provide a 'bind()' function; 
it seems like a good idea, but with 'programs' the function is 'use' so that could be a bit jarring, but then, maybe that is just a wrong doing in OpenGL.
Ahh decisions like this is why we didn't get that far!

Back when we were working on this, we only got as far as agreeing on the glid type. 
As a way of testing and trying out ideas, we both worked on our own branches developing classes like 'texture', 'shader' and 'buffer'. 
We would bounce ideas of each other until we were happy, then look to bring one of those classes over to the main branch once happy with it.
You can probably tell that we didn't get that far, I think we were on the verge of agreeing on the Vertex Array Object though.
Still, I plan to continue with these classes, trying to ensure all that low level stuff I use is neatly wrapped up. 

## Code Smells

One of the main focuses of this iteration was improving the code itself. 
I know full well, there are still some nasty nasty things going on in there! 
I still have a global 'camera' object, but apart from that, all objects are created within the main function now. 
This is mostly because I have to ensure that they are not constructed until after the OpenGL context has been created; 
I'd call that a nice little bonus feature of using the gldr types, it forces you to do things better. 
As such, the initialisation and draw functions are now passed the objects they need to work on, rather than accessing globals.

Speaking of the draw function, it has not improved much. 
The screen is cleared and the OpenGL 'things' are bound as before. 
When you think about it, nothing else is ever bound so why re-bind it? 
It's not a huge deal, and as I work towards fancier things, I will need to be binding like this... well, except better. 
Now I *really* got fancy, I pass a vector of positions to a 'draw box' function, along with a lambda that can be used to set the 'model view project matrix'. 
The draw box function works out what the current box's 'model matrix' should be, and needs to be able to set that in the shader, but I wanted to avoid the function having either the shader program object or the uniform location in the shader. 
So the lambda that I pass in will take the model matrix, and combine it the 'view project' matrix and then set that in the shader. 
I'll admit, it was mostly so I could play around with lambda things, there are other, better ways of doing this!

The update process has not changed a lot either. 
The user input is still done via the keyboard, it works, but I'll improve that soon. 
I also have yet to move past the terrible "as fast as possible" game loop, but that's not a concern right now for me. 
The update itself allows the player to move to where ever the keys dictate, then checks for collisions with all the boxes. 
This collision has been improved slightly, as I now use axis aligned bounding boxes (AABB) for both the player and the cubes. 
The main advantage here is the player is no longer treated as a single point, they actually have some volume! 

It took me some time to settle on a way of storing the AABB, thinking too much about how to store the data. 
Either I can store two position vectors, a minimum and maximum, or I can store a 'centre point' along with the size (width, height, depth) of the AABB, either way it's six numbers to store. 
On reflection, I took the wrong option. 
I figured it was easier to create and update where the AABB is if I stored the midpoint and size, as I only have to update one vector as the box moves. 
However, the collision detection uses the min and max value anyway and is going to be using those values a lot more than they need to be updated. 
It makes a lot more sense to store that data directly rather than having to calculate them each time they are required, especially when you consider I cache that value anyway. 

## Game Mechanics

These really didn't get improved that much to be honest, as planned. 
The challenge has been really ramped up, as now you have to get to three different boxes! 
Each time you hit one of the boxes, it will pop up into the air meaning you will have to find your way to another box. 
OK... not exactly ground breaking things. 
There really isn't much more to say about this. 

## Version Three

So far I've been trying to give myself short specifications to keep myself focused, and I think it's been working well.
For the next iteration then, I'd say it's about time I got the mouse in on this action, the WASD keys can then take on their typical movement functions. 
For now, I'll stick to the single plane of movement, so no jumping around quite yet. 
But I do want to play around with being able to interact more with these boxes, so maybe some way of adding and removing them. 
Graphically I think I should attempt actually get other styles of boxes going on, purely cosmetic for now.

## Compulsory Conclusion

Another version down, another starting off. 
One thing I am very aware of is that I feel myself working towards a bit of a MineCraft clone. 
Though really, I don't see what's wrong with that. 
Either way, I am doing stuff! 
