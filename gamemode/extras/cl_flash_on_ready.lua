--[[-------------------------------------------------------------------------
Flashes the taskbar icon once the game has fully loaded, if the window does not have focus.
This works best on Windows, and is untested on OSX and Linux versions.
---------------------------------------------------------------------------]]--

local function flashOnInitPostEntity()
	if not system.HasFocus() then
		system.FlashWindow()
	end
end
hook.Add( "InitPostEntity", "FlashOnGameLoad", flashOnInitPostEntity )
