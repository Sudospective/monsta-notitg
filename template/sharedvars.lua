xero()
yes = (FUCK_EXE and 1) or true
no = (FUCK_EXE and 0) or false

function hide_actor(self)
    if FUCK_EXE then
		self:hidden(1)
	else
		self:visible(false)
	end
end
function show_actor(self)
    if FUCK_EXE then
		self:hidden(0)
	else
		self:visible(true)
	end
end

function aft_diffuse(self, a)
	if not FUCK_EXE then
		self:diffusealpha(a * 0.9)
	else
		local aftMult = 1.0
		if DISPLAY:GetVendor() == 'nvidia' then aftMult = 0.9 end
		self:diffusealpha(a * aftMult)
	end
end

Blend = {
    Normal = (FUCK_EXE and 'normal') or 'BlendMode_Normal',
    Add = (FUCK_EXE and 'add') or 'BlendMode_Add',
    WeightedAdd = (FUCK_EXE and 'weightedadd') or 'BlendMode_WeightedAdd',
    Subtract = (FUCK_EXE and 'subtract') or 'BlendMode_Subtract',
    Multiply = (FUCK_EXE and 'multiply') or 'BlendMode_Multiply',
    WeightedMultiply = (FUCK_EXE and 'weightedmultiply') or 'BlendMode_WeightedMultiply',
    InvertDest = (FUCK_EXE and 'invertdest') or 'BlendMode_InvertDest',
    NoEffect = (FUCK_EXE and 'noeffect') or 'BlendMode_NoEffect',
    CopySrc = (FUCK_EXE and 'copysrc') or 'BlendMode_CopySrc',
}
ZTestMode = {
    Pass = (FUCK_EXE and 'writeonpass') or 'ZTestMode_WriteOnPass',
    Fail = (FUCK_EXE and 'writeonfail') or 'ZTestMode_WriteOnFail',
}
