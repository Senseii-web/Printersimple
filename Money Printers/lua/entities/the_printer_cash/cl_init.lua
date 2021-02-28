--[[
THIS SCRIPT IS CREATED BY CRAP-HEAD
GMODSTORE PROFILE: https://www.gmodstore.com/users/crap-head
CRAP-HEAD STEAM ID || CRAP-HEAD ID 64
https://veryleaks.cz/
--]]

include("shared.lua")

function ENT:Initialize()
end

local midbox = Material("materials/theprinter/content/the_middle_box2.png")
local coin = Material("materials/theprinter/content/the_coin_icon.png")

function ENT:Draw()
	self:DrawModel()
	
	if self:GetPos():Distance( EyePos() ) > THE_Printer.Config.DisableUIDistance then
		return
	end

	local ang = self:GetAngles()
	local pos = self:GetPos()
	
	ang:RotateAroundAxis(self:GetAngles():Up(), 90)
	
	cam.Start3D2D(pos + ang:Up() * 3.35, ang, 0.11)
	
		draw.RoundedBox(0,-77,-65,154,120,Color(44,44,44,200))
		
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(midbox)
		surface.DrawTexturedRect(-69, 15, 138, 30)
		surface.SetMaterial(midbox)
		surface.DrawTexturedRect(-69, -60, 138, 70)
		surface.SetMaterial( coin )
		surface.DrawTexturedRect( -20, -48, 45, 45 )
		
		draw.SimpleText( self:GetText(), "THEPrinter_DefaultFont", 0, 29, Color(155, 155, 155, 255), 1, 1 )
	
	cam.End3D2D()
end