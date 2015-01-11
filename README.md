ObjectOrientedFactions
=======================

About
-----

This is a small project by me to make a factions system that uses JC MP classes effectively. While simple, the main advantage of this approach is that it allows users to expand the system easily, because it works very much like the default API and supports extendability.

A prime example of what makes the system easy to use is in how players are (currently) automatically added to factions:

```lua

Events:Subscribe("ClientModuleLoad", function(args)
 Military:AddMember(args.player)
end)

```

Notes on usage:

* You may change the way factions are handled at the bottom of shared/_init.lua. Currently there are four factions, which are the equivalents of the ones from singleplayer. 
* To define a new faction, in shared/_init.lua, write a line of code such as `MyFactionVariableName = Faction("My Faction's String Name")`

I do not recommend using this system if you are inexperienced with Lua. Compared to some other scripts, it doesn't have many features and may not be as updated often.  
