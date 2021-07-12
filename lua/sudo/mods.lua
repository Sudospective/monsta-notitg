xero()

window_mods = false

return Def.ActorFrame {
	Name = 'Sudo',
	InitCommand = function(self)
		if GAMESTATE:PlayerDifficulty(0) == DIFFICULTY_EDIT then
			GAMESTATE:LaunchAttack(109.672, 2.482, 'dunno2')
		end
	end,
	LoadCommand = function(self)
		
		definemod {
			'glitchamp', 'glitchshiftx', 'glitchshifty',
			function(n, x, y)
				GlitchShader:GetShader():uniform1f('amount', n * 0.0002)
				GlitchShader:GetShader():uniform2fv('shift', {x * 0.2, y * 0.2})
			end
		}

		local function give_monsta_bass(beat)
			func {beat + 0.25, 1, outExpo, -3, 0, function(p)
				Give:zoom(0.25)
				Give:x(sw * p)
			end}
			func {beat + 0.75, 1, outExpo, 3, 0, function(p)
				Me:zoom(0.25)
				Me:x(sw * p)
			end}
			func {beat + 1.25, 1, outExpo, -3, 0, function(p)
				That:zoom(0.25)
				That:x(sw * p)
			end}
			func {beat + 1.75, 1, outExpo, 3, 0, function(p)
				Monsta:zoom(0.25)
				Monsta:x(sw * p)
			end}
			func {beat + 2.5, 1, outExpo, -3, 0, function(p)
				Bass:zoom(0.25)
				Bass:x(sw * p)
			end}
			func {beat + 3, 1, inExpo, 0.25, 0, function(p)
				Give:zoom(p)
				Me:zoom(p)
				That:zoom(p)
				Monsta:zoom(p)
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
				Lyrics:diffusealpha(0.25)
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
				Lyrics:diffusealpha(1)
			end}
			ease {beat + 2, 2, flip(linear), 200, 'glitchamp', 20, 'glitchshiftx', 20, 'glitchshifty'}
		end

		local function move_that(t)
			local beat, dir = t[1], t[2]
			local mod, amp
			if dir == 'left' then
				mod = 'screenposx'
				amp = -scx
			elseif dir == 'right' then
				mod = 'screenposx'
				amp = scx
			elseif dir == 'up' then
				mod = 'screenposy'
				amp = -scy
			elseif dir == 'down' then
				mod = 'screenposy'
				amp = scy
			end
			ease {beat - 0.5, 1, function(x) return inverse(inOutCirc(x)) end, amp, mod}

			if FUCK_EXE and window_mods then
				if dir == 'left' then
					func {beat - 0.5, 1, function(x) return inverse(inOutCirc(x)) end, function(p)
						DISPLAY:SetWindowPosition(-6000 * p, 12)
					end}
				elseif dir == 'right' then
					func {beat - 0.5, 1, function(x) return inverse(inOutCirc(x)) end, function(p)
						DISPLAY:SetWindowPosition(6000 * p, 12)
					end}
				elseif dir == 'up' then
					func {beat - 0.5, 1, function(x) return inverse(inOutCirc(x)) end, function(p)
						DISPLAY:SetWindowPosition(0, 12 - 6000 * p)
					end}
				elseif dir == 'down' then
					func {beat - 0.5, 1, function(x) return inverse(inOutCirc(x)) end, function(p)
						DISPLAY:SetWindowPosition(0, 12 + 6000 * p)
					end}
				end
			end
		end

		local function clamp(a, b, c)
			return math.min(math.max(a, b), c)
		end

		local function aft_resize(aft, sprite, scale)
			aft:SetWidth(DISPLAY:GetWindowWidth())
			aft:SetHeight(DISPLAY:GetWindowHeight())
			sprite:zoom(1 / scale)
			aft:Recreate()
			sprite:SetTexture(aft:GetTexture())
		end

		aftsprite(LyricsAFT, LyricsSprite)


		-- Frame limited motion blur
		func {0.02, 999, function()
			local fps = DISPLAY:GetFPS()
			local a = clamp(1 - math.sqrt(LyricsAFT:GetEffectDelta() * 30), 0, 0.9)
			aft_diffuse(LyricsSprite, a)
		end}

		
		for pn = 1, #PP do
			PP[pn]:hidden(1)
		end
		func {0, function()
			for pn = 1, #PP do
				PP[pn]:hidden(0)
			end
		end}
	
		func {0, function()
			RemberHelper:hidden(1)
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
			Lyrics:diffusealpha(1)
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
				Give:x((20 * p))
				Me:x((-20 * p))
				That:x((20 * p))
				Monsta:x((-20 * p))
				Bass:x((20 * p))
			end}
			func {beat + 1, 1, flip(outCirc), function(p)
				Give:x((-20 * p))
				Me:x((20 * p))
				That:x((-20 * p))
				Monsta:x((20 * p))
				Bass:x((-20 * p))
			end}
		end

		ease {0, 8, flip(outExpo), 100, 'dark', 200, 'tiny', -400, 'drunk', 400, 'tipsy', 100, 'stealth', 100, 'disablemines'}

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
		ease {72, 6, inQuad,
			150, 'mini',
			300, 'drawsize',
			0, 'movez0',
			0, 'movez1',
			0, 'movez2',
			0, 'movez3',
			50, 'flip',
			200, 'wave',
		}
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

		-- dont ask me why i did it this way okay leave me alone
		set {78, 100, 'hidenoteflash', 50, 'waveoffset'}
		set {78, 0, 'rotationy', 0, 'targetroty', 0, 'drunk', 0, 'tipsy', 50, 'flip', 6, 'xmod', 200, 'wave', 1000, 'sudden', 100, 'dark'}
		set {78, 50, 'reverse', -300, 'tiny', 100, 'stealth', 200, 'drawsize'}
		ease {78, 0.5, linear, 0, 'stealth'}
		set {78.25, 0, 'reverse', -300, 'tiny', 0, 'hide', -300, 'movey', -180, 'targetrotz'}
		set {78.5, 0, 'hidenoteflash'}
		ease {79, 1, linear, 2.5, 'xmod', 0, 'dark', 0, 'drawsize', 0, 'sudden'}
		ease {79, 1, outBack, 0, 'targetrotz', 0, 'movey'}
		ease {79, 1, bounce, 85, 'suddenoffset'}
		ease {80, 0.25, flip(outExpo), 1000, 'drunk', 50, 'tipsy'}
		set {80, 2.5, 'xmod', 0, 'flip', 0, 'tiny', 0, 'wave'}

		kick_up(94)

		ease {94.25, 0.25, inOutCirc, 1.25, 'xmod', 50, 'tiny'}
		ease {94.75, 0.25, inOutCirc, 300, 'wave', 0, 'flip', -50, 'tiny'}
		ease {95.25, 0.5, inOutExpo, 0, 'wave', 100, 'invert', 0, 'tiny'}
		ease {95.5, 0.5, flip(outCirc), 200, 'tornado'}
		mirror {95.75, 0.25, inExpo, 250 * (sw / 640), 'realx'}
		add {95.75, 0.25, inExpo, -50, 'realx'}
		ease {95.75, 0.25, inExpo, 1600, 'wave', -2000, 'tiny', 0, 'invert', 50, 'flip', 0, 'tornado', 0, 'sudden', 0, 'suddenoffset', 100, 'dark', -99, 'longholds'}
		ease {95.5, 0.5, flip(inExpo), 360, 'rotationx', 360, 'rotationy'}
		set {96, -500, 'tiny', 50, 'reverse', 50, 'flip', 2.5, 'xmod'}
		ease {96, 1.5, flip(outCirc), -1000, 'tinyz'}
		ease {96, 1, flip(outExpo), 1000, 'tandrunk', 00, 'tiny', -90, 'rotationx'}
		ease {96, 1.5, inExpo, 0, 'reverse', 0, 'flip'}
		ease {96, 1.5, flip(inQuad), 10, 'arrowpath'}
		ease {96, 0.5, outExpo, 0, 'tiny', -600, 'tiny2', 1000, 'dizzy', 300, 'spiraly', -200, 'holdgirth', 100, 'holdstealth', -20, 'rotationy', -20, 'rotationx', -150, 'movez', 300, 'spiralx', 1000, 'spiralz', 10, 'stealth', 100, 'stealthpastreceptors', -100, 'movey', 5000, 'sudden', }
		ease {96, 0.25, outExpo, 0.02, 'xmod', 400, 'zoomz', -500, 'tipsy'}

		func {96.125, 0.125, outExpo, 0, 0.9, function(p)
			for pn = 1, #PP do
				P[pn]:vibrate()
				P[pn]:effectmagnitude(50, 0, 0)
			end
			aft_diffuse(RecursiveSprite, p)
		end}
		func {97, 0.5, inExpo, 0.9, 0, function(p)
			for pn = 1, #PP do
				P[pn]:stopeffect()
			end
			aft_diffuse(RecursiveSprite, p)
		end}

		reset {97.25, 0.5, inOutExpo}

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

		mirror {111, 1, inBack, 250 * (sw / 640), 'realx'}
		ease {112, 1, inBack, 50, 'flip', 360, 'targetrotz', 5, 'xmod', 150, 'wave', 75, 'waveoffset', -400, 'tiny', 200, 'sudden', 50, 'suddenoffset', 0, 'stealthtype', 50, 'reverse', 100, 'dark', 0, 'hidenoteflash'}
		set {113, 100, 'boomerang'}
		

		func {112, 0.5, outBack, 0, 0.5, function(p)
			That:zoom(p)
		end}
		func {112.5, 0.5, inExpo, 0.5, 0, function(p)
			That:zoom(p)
		end}
		
		--[[
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
		--]]

		local movelist = {
			{'down', 'right', 'up', 'down', 'left'},
			{'down', 'up', 'left'},
			{'right', 'left', 'down', 'up'},
		}

		local index = 1
		set {113.5, 100, 'hidenoteflash'}
		for beat = 114, 118 do
			move_that {beat, movelist[1][index]}
			ease {beat - 1, 0.5, pop, -10000, 'tinyz', -3, 'screenrotx'}
			index = index + 1
		end
		set {118.5, 0, 'hidenoteflash'}
		set {120.5, 100, 'hidenoteflash'}
		index = 1
		for beat = 121, 123 do
			move_that {beat, movelist[2][index]}
			ease {beat - 1, 0.5, pop, -10000, 'tinyz', -3, 'screenrotx'}
			index = index + 1
		end
		set {123.5, 0, 'hidenoteflash'}
		set {130.5, 100, 'hidenoteflash'}
		index = 1
		for beat = 130, 133 do
			move_that {beat, movelist[3][index]}
			if beat < 133 then ease {beat, 0.5, pop, -10000, 'tinyz', -3, 'screenrotx'} end
			index = index + 1
		end
		set {133.5, 0, 'hidenoteflash'}

		set {118, 0, 'boomerang'}
		ease {118, 0.5, outExpo, 2.5, 'xmod', 0, 'flip', 0, 'targetrotz', 0, 'reverse', 0, 'wave', 0, 'sudden', 0, 'tiny', 0, 'dark'}
		ease {119.5, 0.5, inCirc, 5, 'xmod', 50, 'flip', 360, 'targetrotz', 50, 'reverse', 150, 'wave', 200, 'sudden', -400, 'tiny', 100, 'dark'}
		set {120, 100, 'boomerang'}

		set {123, 0, 'boomerang'}
		ease {123, 0.5, outExpo, 2.5, 'xmod', 0, 'flip', 0, 'targetrotz', 0, 'reverse', 0, 'wave', 0, 'sudden', 0, 'tiny', 0, 'dark'}

		kick_up(126)

		func {128, function()
			ScreenPos:vibrate()
		end}
		func {128, 2, outCirc, 1, 0, function(p)
			ScreenPos:effectmagnitude(250 * p, 0, 0)
		end}
		func {130, function()
			ScreenPos:stopeffect()
		end}
		
		
		swap
			{126, 0.25, outBack, 'ldru'}
			{126.25, 0.25, outBack, 'dlru'}
			{126.5, 0.25, outBack, 'rldu'}
			{126.75, 0.25, outBack, 'rudl'}
			{127, 0.25, outBack, 'ldur'}
		
		ease {126.75, 0.5, inOutCirc, 1, 'xmod', -50, 'tiny'}
		swap {127.25, 0.5, inOutExpo, 'rdul'}
		ease {127.25, 0.5, inOutExpo, 100, 'tiny', -50, 'tornado'}
		swap {127.75, 0.25, inExpo, 'ldur'}
		ease {127.75, 0.25, inExpo, -2000, 'tiny', 50, 'flip', 0, 'tornado', 0, 'sudden', 0, 'suddenoffset', 100, 'dark', 100, 'hidenoteflash', -99, 'longholds'}
		ease {127.5, 0.5, flip(inExpo), -360, 'rotationz'}
		ease {128, 2, flip(inCirc), 5000, 'tinyz'}
		ease {128, 1, flip(outExpo), 1000, 'tandrunk'}
		ease {129.5, 0.5, inExpo, 50, 'suddenoffset'}
		set {128, -400, 'tiny', -25, 'reverse'}
		ease {127.5, 2.5, inOutBack, -90 * math.pi/1.8, 'confusionoffset1'}
		ease {128, 2, inQuad, 50, 'reverse'}
		ease {128, 2, outCirc, -200, 'holdgirth', 100, 'holdstealth'}
		ease {128, 2, flip(outExpo), 100, 'hidden'}
		ease {128, 2, flip(linear), 1000, 'xmod', -1500, 'tiny', 400, 'zoomz', -500, 'tipsy', -30, 'rotationx', 20, 'rotationy', 10, 'rotationz'}
		set {129, 0, 'boomerang'}
		ease {129, 1, inExpo, 5, 'xmod', 50, 'flip', 150, 'wave', 200, 'sudden', -400, 'tiny', 100, 'dark'}
		set {130, 100, 'boomerang', 0, 'confusionoffset1', 0, 'bumpyx', 0, 'stealth'}
		
		set {133, 0, 'boomerang', 95, 'stealth0', 95, 'stealth3'}
		ease {133, 0.5, outExpo, 2.5, 'xmod', 0, 'flip', 360, 'targetrotz', 0, 'reverse', 0, 'wave', 0, 'sudden', 0, 'tiny', 0, 'dark', 0, 'longholds', 0, 'holdgirth', 0, 'holdstealth'}
		
		for beat = 133, 133.95, 0.05 do
			add {beat, 0.025, linear, -10, 'stealth0', -10, 'stealth3'}
			add {beat + 0.025, 0.025, linear, 10, 'stealth0', 10, 'stealth3'}
		end

		swap {133, 0, instant, 'rdul'}
		swap {133.75, 0.5, inOutBack, 'ldur'}
		ease {134, 0.25, outCirc, 0, 'stealth0', 0, 'stealth3'}
		ease {134, 0.25, pop, -100, 'tiny0', -100, 'tiny3'}

		set {136, 100, 'euler'}

		local k = -1
		local amp = 2000
		for beat = 128, 129.8755, 0.125 do
			k = -k
			amp = amp  * 0.5
			set {beat, k * amp, 'bumpyx'}
		end
		k = -1
		amp = 10
		for beat = 136, 141.5, 0.5 do
			k = -k
			amp = amp + 10
			ease {beat - 0.25, 0.5, inOutCirc, k * amp, 'bumpyx'}
		end
		
		ease {136, 6, outCirc, -360, 'rotationx'}

		ease {136, 3, bounce, -20, 'screenroty', -10, 'screenrotz'}
		ease {139, 3, bounce, 20, 'screenroty', 10, 'screenrotz'}
		
		ease {141.5, 1, inOutExpo, 0, 'realx'}

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
		
		reset {143.5, 0, instant}

		set {144, 400, 'bumpyperiod', 125, 'waveoffset', 100, 'euler', 100, 'halgun'}

		ease {143.5, 0.5, outBack, 100, 'reverse0'}
		ease {143.667, 0.5, outBack, 100, 'reverse1'}
		ease {143.833, 0.5, outBack, 100, 'reverse2'}
		ease {144, 0.5, outExpo, 50, 'flip'}
		ease {144, 0.5, outBack, 100, 'reverse3'}
		ease {144, 0.5, outExpo, 100, 'stealth'}
		ease {144, 1, inOutBack, 0, 'reverse0'}
		ease {144.167, 1, inOutBack, 0, 'reverse1'}
		ease {144.333, 1, inOutBack, 0, 'reverse2'}
		ease {144.5, 1, inOutBack, 0, 'reverse3'}
		ease {144.5, 1, flip(outCirc), -720, 'rotationy'}
		ease {144.5, 1, inOutExpo, -200, 'tiny', 100, 'flip'}
		ease {144.5, 1, inOutCirc, 0, 'stealth'}
		ease {145, 1, inBack, 0, 'flip'}
		ease {145.5, 1, inOutExpo, 0, 'tiny'}
		
		set {146, 0, 'euler'}

		ease {145, 1, inExpo, 30, 'screenroty', 20, 'screenrotx', 100, 'mini', 100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {146, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {146, 4, outCirc, 500, 'bumpy', 200, 'longholds', 10, 'screenroty'}
		ease {146, 4, linear, -20, 'screenrotx'}
		ease {149.5, 1, inOutExpo, 0, 'movey'}
		ease {149, 2, inOutExpo, 0, 'screenroty', 0, 'screenrotx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}
		
		ease {153, 1, inExpo, -30, 'screenroty', 20, 'screenrotx', 100, 'mini', -100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {154, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {154, 4, outCirc, 500, 'bumpy', 200, 'longholds', -10, 'screenroty'}
		ease {154, 4, linear, -20, 'screenrotx'}
		ease {157.5, 1, inOutExpo, 0, 'movey'}
		ease {157, 2, inOutExpo, 0, 'screenroty', 0, 'screenrotx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}
		
		ease {161, 1, inExpo, 20, 'rotationx', 100, 'mini', 180, 'wave', 8, 'xmod', 300, 'movey', -400, 'invert'}
		ease {161, 1, inExpo, 30, 'rotationy', 50, 'movex', plr = 1}
		ease {161, 1, inExpo, -30, 'rotationy', -50, 'movex', plr = 2}
		ease {162, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
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
			if beat >= 173 then dir1 = 'movex' dir2 = 'movey' amp = 1000
			elseif beat >= 172 then dir1 = 'movey' dir2 = 'movex' amp = 1000
			elseif beat >= 171 then dir1 = 'movex' dir2 = 'movey' amp = -1000
			elseif beat >= 170 then dir1 = 'movey' dir2 = 'movex' amp = -1000
			elseif beat >= 169 then dir1 = 'movex' dir2 = 'movey' amp = 1000
			end
			ease {beat - 0.25, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'0'}
			add {beat - 0.25, 1, inOutCirc, amp * 0.1, 'reverse0'}
			ease {beat, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'1'}
			add {beat, 1, inOutCirc, amp * 0.1, 'reverse1'}
			ease {beat + 0.25, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'2'}
			add {beat + 0.25, 1, inOutCirc, amp * 0.1, 'reverse2'}
			ease {beat + 0.5, 1, function(x) return inverse(inOutCirc(x)) end, amp, dir1..'3'}
			add {beat + 0.5, 1, inOutCirc, amp * 0.1, 'reverse3'}
		end

		set {168, 100, 'euler'}
		ease {168, 6, outCirc, 25, 'flip', -360, 'rotationx'}

		ease {168, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy', 100, 'glitchshiftx', 25, 'screenposx'}
		ease {169.5, 4, flip(outElastic), -500, 'tipsy', 400, 'bumpy', 100, 'glitchshiftx', -25, 'screenposx'}
		ease {171, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy', 100, 'glitchshiftx', 25, 'screenposx'}
		ease {172.5, 4, flip(outElastic), -500, 'tipsy', 400, 'bumpy', 100, 'glitchshiftx', -25, 'screenposx'}
		ease {173, 4, flip(outElastic), 500, 'tipsy', -400, 'bumpy', 100, 'glitchshiftx', 25, 'screenposx'}
		--ease {174, 4, flip(outElastic), 200, 'tipsy', -400, 'bumpy'}

		ease {168, 3, bounce, -20, 'screenroty', -10, 'screenrotz'}
		ease {171, 3, bounce, 20, 'screenroty', 10, 'screenrotz'}
		--ease {173, 2, flip(inOutExpo), 360, 'screenrotx'}
		
		ease {174, 2, outElastic, 0, 'flip'}

		reset {176, 0, instant}

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
		
		for beat = 176, 204, 2 do
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

		give_monsta_bass(180)
		give_monsta_bass(196)

		how_she_go(206, 1)

		reset {207, 0, instant}

		ease {207, 1, inExpo,
			300, 'movex0',
			100, 'movex1',
			-100, 'movex2',
			-300, 'movex3',
			75, 'reverse',
			300, 'drawsize',
		}

		set {208, 400, 'bumpyperiod', 125, 'waveoffset', 100, 'euler', 100, 'halgun'}

		ease
			{208.5, 0.25, outExpo, 0, 'movex3'}
			{208.675, 0.25, outExpo, 0, 'movex0'}
			{208.75, 0.25, outExpo, 0, 'movex2'}
			{208.825, 0.25, outExpo, 0, 'movex1'}
			{208, 2, inOutExpo, 0, 'reverse', 0, 'drawsize'}
			{209, 1, flip(inExpo), -50, 'centered2'}
			{209, 1, function(x) return outCirc(pop(x)) end,
				-1500, 'tinyz',
				400, 'zoomz',
				1.5, 'xmod',
				100, 'tornado',
				-20, 'confusionyoffset0',
				-10, 'confusionyoffset1',
				10, 'confusionyoffset2',
				20, 'confusionyoffset3',
			}
		
		func {210, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {214, function()
			ScreenPos:stopeffect()
		end}
		func {218, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {222, function()
			ScreenPos:stopeffect()
		end}
		
		func {242, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {246, function()
			ScreenPos:stopeffect()
		end}
		
		func {250, function()
			ScreenPos:vibrate()
			ScreenPos:effectmagnitude(5, 5, 0)
		end}
		func {254, function()
			ScreenPos:stopeffect()
		end}

		ease {209, 1, inExpo, 30, 'screenroty', 20, 'screenrotx', 100, 'mini', 100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {210, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {210, 4, outCirc, 500, 'bumpy', 200, 'longholds', 10, 'screenroty'}
		ease {210, 4, linear, -20, 'screenrotx'}
		ease {213.5, 1, inOutExpo, 0, 'movey'}
		ease {213, 2, inOutExpo, 0, 'screenroty', 0, 'screenrotx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}
		
		ease {217, 1, inExpo, -30, 'screenroty', 20, 'screenrotx', 100, 'mini', -100, 'movex', 180, 'wave', 8, 'xmod', 300, 'movey'}
		ease {218, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {218, 4, outCirc, 500, 'bumpy', 200, 'longholds', -10, 'screenroty'}
		ease {218, 4, linear, -20, 'screenrotx'}
		ease {221.5, 1, inOutExpo, 0, 'movey'}
		ease {221, 2, inOutExpo, 0, 'screenroty', 0, 'screenrotx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod'}

		ease {229.75, 0.5, inOutCirc, 200, 'movex0', 90 * math.pi/1.8, 'confusionoffset0'}
		ease {230, 0.5, inOutCirc, -200, 'movex2', -90 * math.pi/1.8, 'confusionoffset2'}
		ease {230.25, 0.5, inOutCirc, 200, 'movex1', -90 * math.pi/1.8, 'confusionoffset1'}
		ease {230.5, 0.5, inOutCirc, -200, 'movex3', 90 * math.pi/1.8, 'confusionoffset3'}
		ease {230.75, 0.5, inOutCirc, 0, 'movex1', 0 * math.pi/1.8, 'confusionoffset1'}
		ease {231.25, 0.5, inOutCirc, 0, 'movex3', 0 * math.pi/1.8, 'confusionoffset3'}
		ease {231.5, 0.5, inOutCirc, 0, 'movex0', 0 * math.pi/1.8, 'confusionoffset0'}
		ease {231.75, 0.5, inOutCirc, 0, 'movex2', 0 * math.pi/1.8, 'confusionoffset2'}
		
		ease {241, 1, inExpo, 20, 'rotationx', 100, 'mini', 180, 'wave', 8, 'xmod', 300, 'movey', -400, 'invert', 100, 'split', -600, 'movey2', -600, 'movey3'}
		ease {241, 1, inExpo, 30, 'rotationy', 50, 'movex', plr = 1}
		ease {241, 1, inExpo, -30, 'rotationy', -50, 'movex', plr = 2}
		ease {242, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {242, 4, outCirc, 500, 'bumpy', 200, 'longholds'}
		ease {242, 4, outCirc, 10, 'rotationy', plr = 1}
		ease {242, 4, outCirc, -10, 'rotationy', plr = 2}
		ease {242, 4, linear, -20, 'rotationx'}
		ease {245.5, 1, inOutExpo, 0, 'movey', 0, 'invert'}
		ease {245, 2, inOutExpo, 0, 'rotationy', 0, 'rotationx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod', 0, 'split', 0, 'movey2', 0, 'movey3'}
		
		ease {249, 1, inExpo, 20, 'rotationx', 100, 'mini', 180, 'wave', 8, 'xmod', 300, 'movey', -400, 'invert', 100, 'alternate', -600, 'movey1', -600, 'movey3'}
		ease {249, 1, inExpo, 30, 'rotationy', 50, 'movex', plr = 1}
		ease {249, 1, inExpo, -30, 'rotationy', -50, 'movex', plr = 2}
		ease {250, 4, tap, 100, 'glitchamp', 10, 'glitchshiftx', 10, 'glitchshifty'}
		ease {250, 4, outCirc, 500, 'bumpy', 200, 'longholds'}
		ease {250, 4, outCirc, 10, 'rotationy', plr = 1}
		ease {250, 4, outCirc, -10, 'rotationy', plr = 2}
		ease {250, 4, linear, -20, 'rotationx'}
		ease {253.5, 1, inOutExpo, 0, 'movey', 0, 'invert'}
		ease {253, 2, inOutExpo, 0, 'rotationy', 0, 'rotationx', 0, 'mini', 0, 'movex', 0, 'bumpy', 0, 'wave', 0, 'longholds', 2.5, 'xmod', 0, 'alternate', 0, 'movey1', 0, 'movey3'}
		

		if GAMESTATE:PlayerDifficulty(0) == DIFFICULTY_EDIT then
			func {255.5, function()
				RemberHelper:hidden(0)
				RemberHelper:diffusealpha(1)
			end}
			local a = 0
			for beat = 256, 260, 2 do
				a = a + 0.25
				func {beat - 0.25, 0.5, inOutCirc, 0, 1, function(p)
					RemberHelper:y2((sh + 128) * p)
				end}
				func {beat + 0.25, 0.5, inOutCirc, 1, 0, function(p)
					RemberHelper:y2((sh + 128) * p)
				end}
				func {beat + 1, 1, inQuad, a, 0, function(p)
					Rember:hidden(0)
					Rember:diffusealpha(p)
				end}
				func {beat + 3, function()
					Rember:addz(100)
				end}
			end
		end

		reset {264, 0, instant}
		
		set {264, 100, 'euler'}

		local k = -1
		local amp = 10
		for beat = 264, 269.75, 0.5 do
			k = -k
			amp = amp + 10
			ease {beat - 0.25, 0.5, inOutCirc, k * amp, 'bumpyx'}
		end
		
		ease {264, 6, outCirc, 50, 'flip', -360, 'rotationx'}

		ease {264, 4, flip(outElastic), 200, 'tipsy', -200, 'bumpy', 100, 'glitchshiftx', 25, 'screenposx'}
		ease {265.5, 4, flip(outElastic), -200, 'tipsy', 200, 'bumpy', 100, 'glitchshiftx', -25, 'screenposx'}
		ease {267, 4, flip(outElastic), 200, 'tipsy', -200, 'bumpy', 100, 'glitchshiftx', 25, 'screenposx'}
		--ease {268.5, 4, flip(outElastic), -200, 'tipsy', 200, 'bumpy'}
		--ease {270, 4, flip(outElastic), 200, 'tipsy', -200, 'bumpy'}
		
		ease {264, 3, bounce, -20, 'screenroty', -10, 'screenrotz'}
		ease {267, 3, bounce, 20, 'screenroty', 10, 'screenrotz'}

		set {270, 0, 'rotationx', 100, 'stealth', 100, 'stealthpastreceptors'}
		ease {270, 0.25, outExpo, 0, 'bumpyx'}
		ease {270, 2, outElastic, 0, 'flip'}

		
		if FUCK_EXE and window_mods then
			local k = -1
			local w, h = DISPLAY:GetWindowWidth(), DISPLAY:GetWindowHeight()
			--RecursiveSprite:hidden(1)
			--GlitchShader:hidden(1)
			--LyricsSprite:hidden(1)
			GAMESTATE:RecompileShadersOnResize(false)
			func {72, 6, linear, function(p)
				rand.seed(rand.float(-999, 999))
				DISPLAY:SetWindowPosition(rand.float(-10, 10) * p, 12 + rand.float(-10, 10) * p)
			end}
			func {77.85, function()
				DISPLAY:SetBorderless(true)
			end}
			func {78, 0.5, flip(outBack), 1, 1.25, function(p)
				DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			func {79, 2, inOutExpo, 0, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {81, 2, inOutExpo, -1, 1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {83, 2, inOutExpo, 1, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {85, 2, inOutExpo, -1, 1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {87, 2, inOutExpo, 1, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {89, 2, inOutExpo, -1, 1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {91, 2, inOutExpo, 1, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {93, 2, inOutExpo, -1, 1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {95, 1, inExpo, 1, 0, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {96, 1.5, outCirc, 1, 0, function(p)
				k = -k
				DISPLAY:SetWindowPosition(160 * k * p, 12)
			end}
			func {97, 2, inOutExpo, 0, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {99, 2, inOutExpo, -1, 1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {101, 2, inOutExpo, 1, -1, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {103, 1, inExpo, -1, 0, function(p)
				DISPLAY:SetWindowPosition(160 * p, 12)
			end}
			func {110, 0.25, outBack, 1, 1.5, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
			func {128, 1.5, outCirc, 1, 0, function(p)
				k = -k
				DISPLAY:SetWindowPosition(160 * k * p, 12)
			end}
			func {135, 0.25, outBack, 1.5, 1, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
			func {145.5, 0.5, inExpo, 1, 1.5, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
			func {146, 3.5, inQuad, function(p)
				rand.seed(rand.float(-999, 999))
				--DISPLAY:SetWindowPositionAndSize(rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p, w * 1.5 + (w * 0.05 * p), h * 1.5 + (h * 0.05 * p))
				DISPLAY:SetWindowPosition(rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p)
			end}
			--[[
			func {146, 3.5, inQuad, 1.5, 1.6, function(p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			--]]
			func {149.5, 0.5, outExpo, 1.6, 1, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
			--[[
			func {153.75, 0.25, inExpo, 1, 1.5, function(p)
				DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			--]]
			func {154, 3.5, inQuad, function(p)
				rand.seed(rand.float(-999, 999))
				--DISPLAY:SetWindowPositionAndSize(rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p, w * 1.5 + (w * 0.05 * p), h * 1.5 + (h * 0.05 * p))
				DISPLAY:SetWindowPosition(rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p)
			end}
			--[[
			func {154, 3.5, inQuad, 1.5, 1.6, function(p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			--]]
			func {157.5, 0.5, outExpo, 1.6, 1, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
			--[[
			func {161.75, 0.25, inExpo, 1, 1.5, function(p)
				DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			--]]
			k = -1
			func {162, 4, function()
				k = -k
			end}
			func {162, 3.5, inQuad, function(p)
				rand.seed(rand.float(-999, 999))
				--k = -k
				--DISPLAY:SetWindowPositionAndSize(rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p, w * 1.5 + (w * 0.05 * p), h * 1.5 + (h * 0.05 * p))
				DISPLAY:SetWindowPosition((160 * k) + rand.float(-40, 40) * p, 12 + rand.float(-40, 40) * p)
			end}
			--[[
			func {162, 3.5, inQuad, 1.5, 1.6, function(p)
				aft_resize(RecursiveAFT, RecursiveSprite, p)
				aft_resize(GlitchAFT, GlitchShader, p)
				aft_resize(LyricsAFT, LyricsSprite, p)
			end}
			--]]
			func {165.5, 0.5, outExpo, 1.6, 1, function(p)
				--DISPLAY:SetWindowPositionAndSize(0, 12, w * p, h * p)
				--aft_resize(RecursiveAFT, RecursiveSprite, p)
				--aft_resize(GlitchAFT, GlitchShader, p)
				--aft_resize(LyricsAFT, LyricsSprite, p)
				DISPLAY:SetWindowPosition(0, 12)
			end}
		end

	end,
}