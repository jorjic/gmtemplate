# gmtemplate
_**gmtemplate**_ is a bare-bones Garry's Mod gamemode template designed to cut down on the hassle of creating new gamemodes. 

## Features
* An empty `content/` directory tree, to make organizing new content as easy as possible
* A recursive file includer, which eliminates the trouble of `include` and `AddCSLuaFile`
* Convenient code snippets within `gamemode/extras/` directory
  * Game taskbar icon will flash once the game has fully loaded, if the window does not have focus.

## Usage
* Clone repository as a new gamemode directory
* Rename changeme.txt and modify file to match your gamemode
* Update gamemode details in shared.lua 
* Create new lua files anywhere within the `gamemode/` subdirectory with the appropriate naming prefix
  * (Lua files will be automatically included in the appropriate context on next map refresh)
  * Files with the cl\_\* prefix will be included on clients. 
  * Files with the sh\_\* prefix will be included on clients and the server. 
  * Files with the sv\_\* prefix will be included on the server. 
  * Files with no matching prefix will be included on the server, If you want exclude files use `ExcludeFiles` parameter.

New directories created within the `gamemode/` subdirectory will automatically be searched in the automatic inclusion.
