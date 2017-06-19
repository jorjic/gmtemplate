AddCSLuaFile()

GM.Name 		= ""
GM.Author 		= ""
GM.Email 		= ""
GM.Website 		= ""

function recursiveInclusion(scanDirectory)
	--print("Searching: " .. scanDirectory .. "/")
	local files, directories = file.Find(scanDirectory .. "/*", "LUA")

	
	--Recursively scan discovered directories
	for _, v in pairs(directories) do
		recursiveInclusion(scanDirectory .. "/" .. v)
	end
	
	--Handle all discovered files
	for _, v in pairs(files) do
		--Chop off first two directories, to satisfy inclusion path requirement
		local relativePath = string.gsub(scanDirectory .. "/" .. v, GM.FolderName .. "/gamemode/", "")
		
		if not (v == "shared.lua" or v == "init.lua" or v == "cl_init.lua") then
		
			if string.match( v, "^sv") then
				--print("Found: " .. v)
				include(relativePath)
			elseif string.match( v, "^sh") then
				--print("Found: " .. v)
				include(relativePath)
			
				if SERVER then
					AddCSLuaFile(relativePath)
				end
			elseif string.match( v, "^cl") then
				--print("Found: " .. v)
				AddCSLuaFile(relativePath)
				
				if CLIENT then
					include(relativePath)
				end
			end
			
		end
	end
end

recursiveInclusion(GM.FolderName .. "/gamemode")
