AddCSLuaFile()

GM.Name 		= ""
GM.Author 		= ""
GM.Email 		= ""
GM.Website 		= ""

function recursiveInclusion( scanDirectory, isGamemode, ExcludeFiles )
	-- Null-coalescing for optional argument
	isGamemode = isGamemode or false
	ExcludeFiles = ExcludeFiles or {}
	local queue = { scanDirectory }
	
	-- Loop until queue is cleared
	while #queue > 0 do
		-- For each directory in the queue...
		for _, directory in pairs( queue ) do
			-- print( "Scanning directory: ", directory )
			
			local files, directories = file.Find( directory .. "/*", "LUA" )
			
			-- Include files within this directory
			for _, fileName in pairs( files ) do
				if fileName != "shared.lua" and fileName != "init.lua" and fileName != "cl_init.lua" then
					-- print( "Found: ", fileName )
					
					-- Create a relative path for inclusion functions
					-- Also handle pathing case for including gamemode folders
					local relativePath = directory .. "/" .. fileName
					if isGamemode then
						relativePath = string.gsub( directory .. "/" .. fileName, GM.FolderName .. "/gamemode/", "" )
					end
					
					-- Include server files
					if string.match( fileName, "^sv" ) then
						if !table.HasValue(ExcludeFiles, relativePath) then
							if SERVER then
								include( relativePath )
							end
						end
					end
					
					-- Include shared files
					if string.match( fileName, "^sh" ) then
						if !table.HasValue(ExcludeFiles, relativePath) then
							AddCSLuaFile( relativePath )
							include( relativePath )
						end
					end
					
					-- Include client files
					if string.match( fileName, "^cl" ) then
						if !table.HasValue(ExcludeFiles, relativePath) then
							AddCSLuaFile( relativePath )
							
							if CLIENT then
								include( relativePath )
							end
						end
					end

					-- Include all another files not prefixed 
					if !string.match( fileName, "^sv" ) and !string.match( fileName, "^sh" ) and !string.match( fileName, "^cl" ) then
						if !table.HasValue(ExcludeFiles, relativePath) then
                        	if SERVER then
                                include( relativePath )
                            end
                        end
                    end
				end
			end
			
			-- Append directories within this directory to the queue
			for _, subdirectory in pairs( directories ) do
				-- print( "Found directory: ", subdirectory )
				table.insert( queue, directory .. "/" .. subdirectory )
			end
			
			-- Remove this directory from the queue
			table.RemoveByValue( queue, directory )
		end
	end
end

recursiveInclusion( GM.FolderName .. "/gamemode", true, {
	-- "extras/cl_flash_on_ready.lya"
} )
