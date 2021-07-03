xero()

return Def.ActorFrame {
    LoadCommand = function(self)
        for pn = 1, 2 do
            setupJudgeProxy(PJ[pn], P[pn]:GetChild('Judgment'), pn)
            setupJudgeProxy(PC[pn], P[pn]:GetChild('Combo'), pn)
			PJ[pn]:zoom(0.75)
			PC[pn]:zoom(0.75)
        end
        for pn = 1, #PP do
            PP[pn]:SetTarget(P[pn])
            P[pn]:hidden(1)
        end

		alias {'confusionzoffset', 'confusionoffset'}
		local sin, cos = math.sin, math.cos
		local asin, atan2 = math.asin, math.atan2
		local pi = math.pi
		definemod {
			'targetrotx', 'targetroty', 'targetrotz',
			function(x, y, z)
				return x * pi/1.8, y * pi/1.8, z * pi/1.8
			end,
			'confusionzoffset', 'confusionyoffset', 'confusionxoffset' -- ???????
		}
		aux {'euler'}
		node {
			'rotationx', 'rotationy', 'rotationz',
			'confusionxoffset', 'confusionyoffset', 'confusionzoffset',
			'euler',
			function(rx, ry, rz, cx, cy, cz, e)
				-- transform axes
				rx, rz = rz, rx
				cx, cz = cz, cx
				
				-- helpers for r
				local rcosx, rcosy, rcosz, rsinx, rsiny, rsinz =
					cos(rx / 360 * pi), cos(ry / 360 * pi), cos(rz / 360 * pi),
					sin(rx / 360 * pi), sin(ry / 360 * pi), sin(rz / 360 * pi)
				
				-- r to quaternion
				local ra, rb, rc, rd =
					rcosx*rcosy*rcosz-rsinx*rsiny*rsinz,
					rsinx*rsiny*rcosz+rcosx*rcosy*rsinz,
					rsinx*rcosy*rcosz+rcosx*rsiny*rsinz,
					rcosx*rsiny*rcosz-rsinx*rcosy*rsinz
				
				-- helpers for c
				local ccosx, ccosy, ccosz, csinx, csiny, csinz =
					cos(cx/200), cos(cy/200), cos(cz/200),
					sin(cx/200), sin(cy/200), sin(cz/200)
				
				-- c to quaternion
				local ca, cb, cc, cd =
					ccosx*ccosy*ccosz-csinx*csiny*csinz,
					csinx*csiny*ccosz+ccosx*ccosy*csinz,
					csinx*ccosy*ccosz+ccosx*csiny*csinz,
					ccosx*csiny*ccosz-csinx*ccosy*csinz
				
				-- o = c * inverse(r)
				local oa, ob, oc, od =
					ca*ra+cb*rb+cc*rc+cd*rd,
					-ca*rb+cb*ra-cc*rd+cd*rc,
					-ca*rc+cb*rd+cc*ra-cd*rb,
					-ca*rd-cb*rc+cc*rb+cd*ra
				
				-- o to euler angles
				local ox, oy, oz =
					100 * atan2(2*oc*oa-2*ob*od, 1-2*oc*oc-2*od*od),
					100 * asin(2*ob*oc+2*od*oa),
					100 * atan2(2*ob*oa-2*oc*od, 1-2*ob*ob-2*od*od)
				
				-- transform axes
				ox, oz = oz, ox
				if e > 0 then return ox, oy, oz else return cx, cy, cz end 
			end,
			'confusionxoffset', 'confusionyoffset', 'confusionzoffset',
		}
		
		definemod {
			'screenrotx', 'screenroty', 'screenrotz',
			function(x, y, z)
				ScreenRot:rotationx(x)
				ScreenRot:rotationy(y)
				ScreenRot:rotationz(z)
			end
		}
		definemod {
			'screenposx', 'screenposy',
			function(x, y, z)
				ScreenPos:x(scx + x)
				ScreenPos:y(scy + y)
			end
		}
		definemod {
			'realx', 'realy',
			function(x, y, pn)
				local px, py
				if pn == 1 then
					px = scx * 0.5
				else 
					px = scx * 1.5
				end
				py = scy
				P[pn]:x(px + (x * 0.64 * (sw / 640)))
				P[pn]:y(py + (y * 0.64 * (sw / 640)))
			end
		}

		setdefault {
			2.5, 'xmod',
			100, 'modtimer',
			-100, 'straightholds',
			100, 'dizzyholds',
			0, 'targetrotx',
			0, 'targetroty',
			0, 'targetrotz',
			0, 'euler',
			0, 'screenrotx',
			0, 'screenroty',
			0, 'screenrotz',
			0, 'screenposx',
			0, 'screenposy',
			0, 'realx',
			0, 'realy',
		}

		rand.seed(411)

    end,
	Def.Quad {
		Name = 'HideEvent',
		InitCommand = function(self)
			self:xy(scx, scy)
			self:SetWidth(sw)
			self:SetHeight(sh)
			self:diffuse(0, 0, 0, 1)
		end,
	},
	Def.ActorFrame {
		Name = 'ScreenRot',
		InitCommand = xero.pivot,
		Def.ActorFrame {
			Name = 'ScreenPos',
			InitCommand = xero.offset,
			Def.ActorProxy { Name = 'PP[1]' },
			Def.ActorProxy { Name = 'PP[2]' },
			Def.ActorProxy { Name = 'PJ[1]' },
			Def.ActorProxy { Name = 'PJ[2]' },
			Def.ActorProxy { Name = 'PC[1]' },
			Def.ActorProxy { Name = 'PC[2]' },
		},
		loadfile('lua/sudo/mods.lua')(),
		loadfile('lua/oats/mods.lua')(),
	},
}
