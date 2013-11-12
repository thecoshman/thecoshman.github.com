---
layout: default
title: KSP
---



#KSP is awesome!

Yeah, the game is great right out of the box, but you know what? Mods can make it even more awesome!
This is going to be the formation of a 'mod pack' of sorts. 
I will collate a collection of mods that I think are great, and where permission permits, bundle them together into one download. 
Either way, I shall of course be linking to the mods main page.
If you feel there is a particular mod I am not using but fits right in with what I seem to like, please do let me know.
If you fancy trying out any other mod, I suggest you take a look at [this mod index](http://forum.kerbalspaceprogram.com/threads/55401-Community-Mods-and-Plugins-Library) on the KSP forums.
There are some mods out there that are perfectly usable in the current .22 version, but lack information about the tech tree (such as the Kethane mod), [here](http://en.reddit.com/r/KerbalSpaceProgram/comments/1om2i8/how_to_integrate_mods_into_career_mode/) is a quick guide to help update part configurations so that they work with the tech tree.

Here is the list of mods that I currently use, in roughly the order I would say you should consider them. I know there are some people who want to stick to the vanilla game, but some of these mods can just add so much! Why not just try them out, add the mods, start a new career game and see how you get on; if you don't like them, just remove them, no harm done.

{% for post in site.categories.ksp %}
###{{ post.title}}
{{ post.content }}
 - [mods home page]({{ post.external_link }})

{% unless forloop.last %}
- - -
{% endunless %}
{% endfor %}


