DataLoader = {}

--[[
	Use the data loader to load json files from the filesystem. The load 
	function has a callback function parameter that can be used to precess the 
	data.
]]
function DataLoader:load(path, f)
	f = f or function() end

	print('\n' .. path)

	local files = love.filesystem.getDirectoryItems(path)
	for _, filename in ipairs(files) do		
		print('- ' .. filename)

		local filepath = path .. '/' .. filename
		local contents, _ = love.filesystem.read(filepath)
		local fileJs = json.decode(contents)
		f(fileJs)
	end
end