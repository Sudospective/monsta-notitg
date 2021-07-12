xero()

return Def.ActorFrame {
	Def.ActorFrame {
		Name = 'Lyrics',
		LoadCommand = function(self)
			self:diffusealpha(1)
			self:xy(scx, scy)
			She:addy(-120)
			Like:addy(120)
		end,
		Def.ActorFrame {
			Def.Sprite {
				Name = 'Give',
				Texture = 'lua/sudo/lyrics/give.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			Def.Sprite {
				Name = 'Me',
				Texture = 'lua/sudo/lyrics/me.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			Def.Sprite {
				Name = 'That',
				Texture = 'lua/sudo/lyrics/that.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			Def.Sprite {
				Name = 'Monsta',
				Texture = 'lua/sudo/lyrics/monsta.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			Def.Sprite {
				Name = 'Bass',
				Texture = 'lua/sudo/lyrics/bass.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
		},
		Def.ActorFrame {
			Def.Sprite {
				Name = 'She',
				Texture = 'lua/sudo/lyrics/she.png',
				OnCommand = function(self)
					self:hidden(1)
					self:zoom(0.5)
				end,
			},
			Def.Sprite {
				Name = 'Go',
				Texture = 'lua/sudo/lyrics/go.png',
				OnCommand = function(self)
					self:hidden(1)
					self:zoom(0.5)
				end,
			},
			Def.Sprite {
				Name = 'Like',
				Texture = 'lua/sudo/lyrics/like.png',
				OnCommand = function(self)
					self:hidden(1)
					self:zoom(0.5)
				end,
			},
			Def.Sprite {
				Name = 'That2',
				Texture = 'lua/sudo/lyrics/that.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
		},
		Def.ActorFrame {
			Def.Sprite {
				Name = 'Kick',
				Texture = 'lua/sudo/lyrics/kick.png',
				OnCommand = function(self)
					self:hidden(1)
					self:y((sh + 240))
				end,
			},
			Def.Sprite {
				Name = 'Up',
				Texture = 'lua/sudo/lyrics/up.png',
				OnCommand = function(self)
					self:hidden(1)
					self:y((sh + 240))
				end,
			},
		},
		Def.ActorFrame {
			Name = 'NoPromise',
			InitCommand = function(self)
				self:zoom(0)
			end,
			Def.Sprite {
				Name = 'No',
				Texture = 'lua/sudo/lyrics/no.png',
				OnCommand = function(self)
					self:y(-300)
				end,
			},
			Def.Sprite {
				Name = 'Promise',
				Texture = 'lua/sudo/lyrics/promise.png',
				OnCommand = function(self)
					self:y(-100)
				end,
			},
			Def.Sprite {
				Name = 'Getting',
				Texture = 'lua/sudo/lyrics/getting.png',
				OnCommand = function(self)
					self:y(100)
				end,
			},
			Def.Sprite {
				Name = 'Em',
				Texture = 'lua/sudo/lyrics/em.png',
				OnCommand = function(self)
					self:y(300)
				end,
			},
			--[[ no really im super sure it says get fucked
			Def.Sprite {
				Name = 'Get',
				Texture = 'lua/sudo/lyrics/get.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			Def.Sprite {
				Name = 'Fucked',
				Texture = 'lua/sudo/lyrics/fucked.png',
				OnCommand = function(self)
					self:zoom(0)
				end,
			},
			--]]
		},
		Def.Sprite {
			Name = 'Rember',
			Texture = 'lua/sudo/assets/rember2.png',
			InitCommand = function(self)
				self:hidden(1)
				self:diffusealpha(0)
				self:zoom(0.25)
			end,
		},
		Def.Quad {
			Name = 'RemberHelper',
			InitCommand = function(self)
				self:SetWidth(sw)
				self:SetHeight(32)
				self:fadetop(0.5)
				self:fadebottom(0.5)
				self:y(-scx - 32)
				self:diffuse(0, 1, 0, 1)
			end,
		}
	},
	Def.Sprite {
		Name = 'LyricsSprite',
		InitCommand = function(self)
			self:diffusealpha(0)
		end,
		OnCommand = xero.sprite,
	},
	Def.ActorFrameTexture {
		Name = 'LyricsAFT',
		OnCommand = xero.aft,
	},
}
