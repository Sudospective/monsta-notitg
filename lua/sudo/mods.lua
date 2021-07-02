xero()

return Def.ActorFrame {
	Name = 'Sudo',
	LoadCommand = function(self)
		
		local function give_monsta_bass(beat)
			func {beat + 0.25, 1, outExpo, -3, 0, function(p)
				Give:x(sw * p)
			end}
			func {beat + 0.25, 3, inExpo, 0.25, 0, function(p)
				Give:zoom(p)
			end}
			func {beat + 0.75, 1, outExpo, 3, 0, function(p)
				Me:x(sw * p)
			end}
			func {beat + 0.75, 3, inExpo, 0.25, 0, function(p)
				Me:zoom(p)
			end}
			func {beat + 1.25, 1, outExpo, -3, 0, function(p)
				That:x(sw * p)
			end}
			func {beat + 1.25, 3, inExpo, 0.25, 0, function(p)
				That:zoom(p)
			end}
			func {beat + 1.75, 1, outExpo, 3, 0, function(p)
				Monsta:x(sw * p)
			end}
			func {beat + 1.75, 3, inExpo, 0.25, 0, function(p)
				Monsta:zoom(p)
			end}
			func {beat + 2.5, 1, outExpo, -3, 0, function(p)
				Bass:x(sw * p)
			end}
			func {beat + 2.5, 3, inExpo, 0.25, 0, function(p)
				Bass:zoom(p)
			end}
		end

		local function how_she_go(beat, dir)
			func {beat + 0.75, 0.5, outExpo, dir, 0, function(p)
				She:hidden(0)
				She:zoom(0.5)
				She:x(scx * p)
			end}
			func {beat + 1, 0.5, outExpo, dir, 0, function(p)
				Go:hidden(0)
				Go:zoom(0.5)
				Go:x(scx * p)
			end}
			func {beat + 1.5, 0.5, outExpo, dir, 0, function(p)
				Like:hidden(0)
				Like:zoom(0.5)
				Like:x(scx * p)
			end}
			func {beat + 1.5, 0.5, inExpo, 0.5, 0, function(p)
				She:zoom(p)
				Go:zoom(p)
				Like:zoom(p)
			end}
			func {beat + 2, function()
				She:hidden(1)
				Go:hidden(1)
				Like:hidden(1)
			end}
			ease {beat + 1.5, 1, flip(inOutExpo), -360 * dir, 'screenrotz'}
			ease {beat + 1, 2, spike, -1500, 'tiny', 50, 'reverse'}
		end

		local function kick_up(beat)
			func {beat, function()
				Kick:hidden(0)
				Up:hidden(0)
			end}
			func {beat + 0.25, 0.5, outExpo, 1, 0, function(p)
				Kick:y((sh + 240) * p)
				Kick:rotationz(-10 * (1 - p))
				Up:rotationz(10 * (1 - p))
			end}
			func {beat + 0.75, 0.5, outBack, 1, 0, function(p)
				Kick:y(-120 * (1 - p))
				Up:y(120 + (sh + 240) * p)
				Kick:rotationz(10 * (0.5 - p * 2))
				Up:rotationz(-10 * (0.5 - p * 2))
			end}
			func {beat + 1.25, 0.5, inExpo, 0, 1, function(p)
				Kick:y(-120 - (sh + 240) * p)
				Up:y(120 - (sh + 240) * p)
				Kick:rotationz(5 * (1 - p))
				Up:rotationz(-5 * (1 - p))
			end}
			func {beat + 2, function()
				Kick:hidden(0)
				Up:hidden(0)
			end}
		end
	
		func {0, function()
			Lyrics:zoom(2)
			Give:y(-60)
			Me:y(0)
			That:y(60)
		end}
		func {4, function()
			Lyrics:diffusealpha(0.1)
			Give:zoom(0.25)
			Give:x(-sw * 3)
			Me:zoom(0.25)
			Me:x(sw * 3)
			That:zoom(0.25)
			That:x(-sw * 3)
		end}
		func {4, 1, outExpo, 1, 0, function(p)
			Give:x(-sw * 3 * p)
		end}
		func {4.5, 1, outExpo, 1, 0, function(p)
			Me:x(sw * 3 * p)
		end}
		func {5, 1, outExpo, 1, 0, function(p)
			That:x(-sw * 3 * p)
		end}
		func {5.5, 0.5, linear, 0.1, 0, function(p)
			Lyrics:diffusealpha(p)
		end}

		func {16, function()
			Lyrics:diffusealpha(0.75)
			Give:zoom(0)
			Me:zoom(0)
			That:zoom(0)
			Give:y(-120)
			Me:y(-60)
			That:y(0)
			Monsta:y(60)
			Bass:y(120)
		end}

		for beat = 16, 76, 2 do
			func {beat, 1, flip(outCirc), function(p)
				Give:x((50 * p))
				Me:x((-50 * p))
				That:x((50 * p))
				Monsta:x((-50 * p))
				Bass:x((50 * p))
			end}
			func {beat + 1, 1, flip(outCirc), function(p)
				Give:x((-50 * p))
				Me:x((50 * p))
				That:x((-50 * p))
				Monsta:x((50 * p))
				Bass:x((-50 * p))
			end}
		end

		for pn = 1, #PP do
			PP[pn]:hidden(1)
		end
		func {0, function()
			for pn = 1, #PP do
				PP[pn]:hidden(0)
			end
		end}

		ease {0, 8, flip(outExpo), 200, 'tiny', -400, 'drunk', 400, 'tipsy', 100, 'stealth'}

		set {15.5, 50, 'beat'}

		ease {15, 2, inOutExpo, 150, 'mini', 300, 'drawsize'}
		ease {16, 52, inQuad, 0, 'mini', 0, 'drawsize'}

		ease {16, 2, pop, -100, 'drunk', 100, 'tipsy'}
		ease {16, 8, flip(linear), 30, 'stealth'}
		ease {32, 2, pop, -100, 'drunk', 100, 'tipsy'}
		ease {32, 8, flip(linear), 30, 'stealth'}
		ease {48, 2, pop, -100, 'drunk', 100, 'tipsy'}
		ease {48, 8, flip(linear), 30, 'stealth'}
		ease {64, 2, pop, -100, 'drunk', 100, 'tipsy'}
		ease {64, 8, flip(linear), 30, 'stealth'}

		for beat = 16, 56, 8 do
			swap
				{beat, 1, outExpo, 'ldur'}
				{beat + 2, 1, outExpo, 'dlru'}
				{beat + 4, 1, outExpo, 'ldur'}
				{beat + 6, 1, outExpo, 'ulrd'}
				{beat + 7, 1, outExpo, 'dlru'}
		end
		for beat = 64, 68, 4 do
			swap
				{beat, 1, outExpo, 'ldur'}
				{beat + 1, 1, outExpo, 'dlru'}
				{beat + 2, 1, outExpo, 'rudl'}
				{beat + 3, 1, outExpo, 'urld'}
		end
		swap {72, 1, outExpo, 'ldur'}

		func {16, 52, inQuad, 0.25, 1, function(p)
			Lyrics:zoom(p)
		end}

		give_monsta_bass(20)
		give_monsta_bass(36)
		give_monsta_bass(52)
		give_monsta_bass(68)

		set {71.5,
			50, 'movez0',
			-150, 'movez1',
			150, 'movez2',
			-50, 'movez3',
			0, 'zoomz',
			0, 'beat',
		}
		ease {72, 6, inQuad, 190, 'mini', 300, 'drawsize'}
		ease {72, 6, inCirc, 2160, 'rotationy', -2160, 'targetroty', 100, 'drunk', 100, 'tipsy', 1.5, 'xmod'}
		ease {78, 0.25, outBack,
			0, 'movez0',
			0, 'movez1',
			0, 'movez2',
			0, 'movez3',
			100, 'zoomz',
			0, 'mini',
			0, 'drawsize'
		}

		how_she_go(78, -1)

		func {112, 0.5, outBack, 0, 0.5, function(p)
			That:zoom(p)
		end}
		func {112.5, 0.5, inExpo, 0.5, 0, function(p)
			That:zoom(p)
		end}
		
		for beat = 114, 118 do
			local x, y = rand.float(-scx * 0.75, scy * 0.75), rand.float(-scy * 0.75, scy * 0.75)
			func {beat, 0.75, bounce, 0, 0.25, function(p)
				That:xy(x, y)
				That:zoom(p)
			end}
		end
		for beat = 121, 125 do
			local x, y = rand.float(-scx * 0.75, scy * 0.75), rand.float(-scy * 0.75, scy * 0.75)
			func {beat, 0.75, bounce, 0, 0.25, function(p)
				That:xy(x, y)
				That:zoom(p)
			end}
		end
		
		local x2, y2 = rand.float(-scx * 0.75, scy * 0.75), rand.float(-scy * 0.75, scy * 0.75)
		func {124.5, 0.75, bounce, 0, 0.25, function(p)
			That2:xy(x2, y2)
			That2:zoom(p)
		end}
		
		for beat = 130, 133 do
			local x, y = rand.float(-scx * 0.75, scy * 0.75), rand.float(-scy * 0.75, scy * 0.75)
			func {beat, 0.75, bounce, 0, 0.25, function(p)
				That:xy(x, y)
				That:zoom(p)
			end}
		end
		
		func {134, 0.75, bounce, 0, 0.25, function(p)
			That:xy(0, 0)
			That:zoom(p)
		end}

		set {78, 100, 'hidenoteflash'}
		set {78, 0, 'rotationy', 0, 'targetroty', 0, 'drunk', 0, 'tipsy', 50, 'flip', 6, 'xmod', -150, 'wave', 100, 'dark'}
		set {78, 50, 'reverse', -500, 'tiny', 100, 'stealth', 200, 'drawsize'}
		ease {78, 0.5, linear, 0, 'stealth'}
		set {78.25, 0, 'reverse', -200, 'tiny', 0, 'hide', -300, 'movey', -180, 'targetrotz'}
		ease {78.75, 1.25, linear, 10, 'xmod', 0, 'dark', 0, 'drawsize'}
		ease {79, 1, outBack, 0, 'targetrotz', 0, 'movey'}
		set {78.5, 0, 'hidenoteflash'}
		ease {80, 0.25, flip(outExpo), 1000, 'drunk', 50, 'tipsy'}
		set {80, 2.5, 'xmod', 0, 'flip', 0, 'tiny', 0, 'wave'}

		kick_up(94)

		--[[ but it sounds like it says get fucked
		func {94, function()
			Get:y(-90)
			Fucked:y(90)
		end}
		func {94.5, 0.5, outBack, function(p)
			Get:zoom(p)
		end}
		func {95, 0.5, outBack, function(p)
			Fucked:zoom(p)
		end}
		func {95.5, 0.5, inExpo, 1, 0, function(p)
			Get:zoom(p)
			Fucked:zoom(p)
		end}
		--]]

		how_she_go(110, 1)

		kick_up(126)

		func {141.5, function()
			for _, v in ipairs(NoPromise:GetChildren()) do
				v:vibrate()
				v:effectmagnitude(5, 5, 0)
			end
		end}
		func {141.5, 1, outExpo, 1.5, 0.35, function(p)
			NoPromise:zoom(p)
			NoPromise:rotationz(90 * (p - 0.35))
		end}
		func {143, 1, inExpo, 1, 0, function(p)
			NoPromise:zoom(0.35 * p)
			NoPromise:rotationz(-90 * (1 - p))
		end}
		func {144, function()
			for _, v in ipairs(NoPromise:GetChildren()) do
				v:stopeffect()
			end
		end}
		

		set {144, 400, 'bumpyperiod', 125, 'waveoffset', 100, 'euler'}

		ease {144, 0.5, outExpo, 50, 'flip'}
		ease {143.5, 0.5, outBack, 100, 'reverse0'}
		ease {143.667, 0.5, outBack, 100, 'reverse1'}
		ease {143.833, 0.5, outBack, 100, 'reverse2'}
		ease {144, 0.5, outBack, 100, 'reverse3'}
		ease {144, 1, inOutBack, 0, 'reverse0'}
		ease {144.167, 1, inOutBack, 0, 'reverse1'}
		ease {144.333, 1, inOutBack, 0, 'reverse2'}
		ease {144.5, 1, inOutBack, 0, 'reverse3'}
		ease {144.5, 1, flip(outCirc), -720, 'rotationy'}
		ease {144.5, 1, inOutExpo, -200, 'tiny', 100, 'flip'}
		ease {145, 1, inBack, 0, 'flip'}
		ease {145.5, 1, inOutExpo, 0, 'tiny'}
		
		set {146, 0, 'euler'}

		ease {145, 1, inExpo, 30, 'rotationy', 20, 'rotationx', 100, 'mini', 100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {146, 4, outCirc, 500, 'bumpy', 200, 'longholds', 10, 'rotationy'}
		ease {146, 4, linear, -20, 'rotationx'}
		ease {149.5, 1, inOutExpo, 0, 'movey'}
		ease {149, 2, inOutExpo, 0, 'rotationy', 0, 'rotationx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}
		
		ease {153, 1, inExpo, -30, 'rotationy', 20, 'rotationx', 100, 'mini', -100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {154, 4, outCirc, 500, 'bumpy', 200, 'longholds', -10, 'rotationy'}
		ease {154, 4, linear, -20, 'rotationx'}
		ease {157.5, 1, inOutExpo, 0, 'movey'}
		ease {157, 2, inOutExpo, 0, 'rotationy', 0, 'rotationx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}
		
		ease {161, 1, inExpo, 20, 'rotationx', 100, 'mini', 180, 'wave', 8, 'xmod', 300, 'movey', -400, 'invert'}
		ease {161, 1, inExpo, 30, 'rotationy', 50, 'movex', plr = 1}
		ease {161, 1, inExpo, -30, 'rotationy', -50, 'movex', plr = 2}
		ease {162, 4, outCirc, 500, 'bumpy', 200, 'longholds'}
		ease {162, 4, outCirc, 10, 'rotationy', plr = 1}
		ease {162, 4, outCirc, -10, 'rotationy', plr = 2}
		ease {162, 4, linear, -20, 'rotationx'}
		ease {165.5, 1, inOutExpo, 0, 'movey', 0, 'invert'}
		ease {165, 2, inOutExpo, 0, 'rotationy', 0, 'rotationx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}

		for beat = 168, 173 do
			local dir1 = 'movey'
			local dir2 = 'movex'
			local amp = 1000
			---[[
			if beat >= 173 then dir1 = 'movex' dir2 = 'movey' amp = 1000
			elseif beat >= 172 then dir1 = 'movey' dir2 = 'movex' amp = 1000
			elseif beat >= 171 then dir1 = 'movex' dir2 = 'movey' amp = -1000
			elseif beat >= 170 then dir1 = 'movey' dir2 = 'movex' amp = -1000
			elseif beat >= 169 then dir1 = 'movex' dir2 = 'movey' amp = 1000
			end
			--]]
			---[[
			ease {beat - 0.25, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'0'}
			add {beat - 0.25, 1, inOutCirc, amp * 0.1, 'reverse0'}
			ease {beat, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'1'}
			add {beat, 1, inOutCirc, amp * 0.1, 'reverse1'}
			ease {beat + 0.25, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'2'}
			add {beat + 0.25, 1, inOutCirc, amp * 0.1, 'reverse2'}
			ease {beat + 0.5, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'3'}
			add {beat + 0.5, 1, inOutCirc, amp * 0.1, 'reverse3'}
			--]]
		end

		set {168, 100, 'euler'}
		ease {168, 6, outCirc, -360, 'rotationx'}

		ease {168, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy'}
		ease {169.5, 4, flip(outElastic), -500, 'tipsy', 400, 'bumpy'}
		ease {171, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy'}
		ease {172.5, 4, flip(outElastic), -500, 'tipsy', 400, 'bumpy'}
		ease {173, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy'}
		--ease {174, 4, flip(outElastic), 200, 'tipsy', -400, 'bumpy'}

		ease {168, 3, bounce, -20, 'screenroty', -10, 'screenrotz'}
		ease {171, 3, bounce, 20, 'screenroty', 10, 'screenrotz'}
		ease {173, 2, flip(inOutExpo), 360, 'screenrotx'}

		func {146, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {150, function()
			ScreenPos:stopeffect()
		end}
		func {154, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {158, function()
			ScreenPos:stopeffect()
		end}
		func {162, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {166, function()
			ScreenPos:stopeffect()
		end}

		func {174, function()
			for _, v in ipairs(NoPromise:GetChildren()) do
				v:vibrate()
				v:effectmagnitude(5, 5, 0)
			end
		end}
		func {174, 1, outExpo, 1.5, 0.35, function(p)
			NoPromise:zoom(p)
			NoPromise:rotationz(90 * (p - 0.35))
		end}
		for i, v in ipairs(NoPromise:GetChildren()) do
			local rot = (i % 2 == 0 and 30) or -30
			local child = NoPromise:GetChildAt(NoPromise:GetNumChildren() - i)
			func {173.75 + ((i - 1) * 0.125), 1, inCirc, 0, 1, function(p)
				child:y2(sh * 3 * p)
				child:rotationz(rot * p)
			end}
		end
		func {176, function()
			for i, v in ipairs(NoPromise:GetChildren()) do
				v:stopeffect()
			end
		end}

		give_monsta_bass(180)
		give_monsta_bass(196)

		how_she_go(206, 1)

	end,
	Def.ActorFrame {
		Name = 'Lyrics',
		LoadCommand = function(self)
			self:diffusealpha(0.75)
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
		}
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
}