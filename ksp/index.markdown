---
layout: default
title: KSP
---



#KSP is awesome!

Yeah, the game is great right out of the box; but you know what? 
Mods can make it even more awesome!
Here I collate a collection of mods that I think are great, and where permission permits, bundle them together into one download. 
Either way, I shall of course be linking to the mods main page (almost always the KSP forums).
If you feel there is a particular mod I am not using but fits right in with what I seem to like, please do let me know.
I suggest you take a look at [this mod index](http://forum.kerbalspaceprogram.com/threads/55401-Community-Mods-and-Plugins-Library) on the KSP forums for other mods that may interest you.
There are some mods out there that are perfectly usable in the current .22 version, but lack information about the tech tree (<del>such as the Kethane mod</del> the Kethane mod was my example here), [here](http://en.reddit.com/r/KerbalSpaceProgram/comments/1om2i8/how_to_integrate_mods_into_career_mode/) is a quick guide to help update part configurations so that they work with the tech tree.

## The Pirate Pack

I have bundled together all the mods that I like (where permission permits) into this mod pack. 
Not all the mods I would like to add grant permission, in which case you will have to get them separately yourself.

Pack contains:
{% assign had_first = false %}{% for mod in site.categories.ksp %}{% if mod.in_pack %}{% if had_first %},{% else %}{% assign had_first = true %}{% endif %} [{{ mod.title}}](#{{ mod.title | remove:' ' }}){% endif %}{% endfor %}.

I will add some tweaks to the mods (again, where permission permits) to help them work together, such as RealChutes having the 'drag' set down to 0 when tow work better with FAR, or replacing the textures in TAC Life Support rather than suffer the crude mock textures. 
Some of the changes in this mod pack will impact the vanilla items, so you will need to 'merge' thse changes into your KSP install, letting it replace files where needs be. 
As with all mods, I suggest you back up KSP install first, and probably start a new save file once you have thrown all these mods into the mix.

I have also tweaked the stock KSP parts, the stock parachutes, so that they do not show up in career mode. 
The RealChutes mod replaces them all, but does not remove the existing ones.

Like I said, some MODs  are not included (for what ever reason) you should get them separately: 
{% assign had_first = false %}{% for mod in site.categories.ksp %}{% unless mod.in_pack %}{% if had_first %},{% else %}{% assign had_first = true %}{% endif %} [{{ mod.title}}](#{{ mod.title | remove:' ' }}){% endunless %}{% endfor %}.

### Download and Install

Any way, on to the download! You can get a copy from the [Kerbal Spaceport](http://kerbalspaceport.com/thepiratepack/). 
To install this, just extract the 'GameData' folder into you KSP installation, there should be an existing 'GameData' folder to merge into.
You will need to allow some of the files to be replaced; 
if you do not allow this, the Mk2 cockpit will not work correctly, and you will still have the stock parachutes even though you don't need them.

## The MODs in Detail

Here is a more complete description of the mods that I currently use, in no particular order. 
I know there are some people who want to stick to the vanilla game, but some of these mods can just add so much! 
Why not just try them out, add the mods, start a new career game and see how you get on; 
if you don't like them, just remove them, no harm done.

{% for mod in site.categories.ksp %}

<a name="{{ mod.title | remove:' ' }}">
</a>
### {{ mod.title}}
{{ mod.content }}
 - [mods home page]({{ mod.external_link }})
{% unless forloop.last %}
- - -
{% endunless %}
{% endfor %}
