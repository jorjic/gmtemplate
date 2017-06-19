AddCSLuaFile()

GM.Name 		= "Zombie Panic"
GM.Author 		= "Jorji Costava <STEAM_0:0:23932200>"
GM.Email 		= ""
GM.Website 		= ""

function recursiveInclusion(scanDirectory)
	local files, directories = file.Find(scanDirectory .. "/*", "LUA")


	--Recursively scan discovered directories
	for _, v in pairs(directories) do
		recursiveInclusion(scanDirectory .. "/" .. v)
	end

	--Handle all discovered files
	for _, v in pairs(files) do
		local relativePath = string.gsub(scanDirectory .. "/" .. v, GM.FolderName .. "/gamemode/", "")

		if not (v == "shared.lua" or v == "init.lua" or v == "cl_init.lua") then

			if string.match( v, "^sv") then
				include(relativePath)
			elseif string.match( v, "^sh") then
				include(relativePath)

				if SERVER then
					AddCSLuaFile(relativePath)
				end
			elseif string.match( v, "^cl") then
				AddCSLuaFile(relativePath)

				if CLIENT then
					include(relativePath)
				end
			end

		end
	end
end

recursiveInclusion(GM.FolderName .. "/gamemode")
