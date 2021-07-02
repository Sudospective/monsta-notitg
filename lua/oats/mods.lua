xero()

return Def.ActorFrame {
	Name = 'Oats',
	LoadCommand = function(self)

		-- funy arrow stuff goes here here

	end,
	-- shaders are done like this
	--[[
	Def.Shader {
		Name = 'myShader',
		Frag = 'lua/notitg/glitch-lines.frag'
	}
	--]]
	-- references to files are based on songs root directory rather than xml location thanks xml
	-- sorry the template does a few things a little wacky but thats how i had to implement it
	-- everything else should be the same
}