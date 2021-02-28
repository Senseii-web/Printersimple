include( "shared.lua" )

function ENT:Initialize()
end

local midbox = Material("materials/theprinter/content/the_middle_box2.png")
local rectline = Material("materials/theprinter/hacker/rectangle_white.png")
local greybig = Material("materials/theprinter/hacker/gray_bg.png")
local midbox = Material("materials/theprinter/content/the_middle_box2.png")

local col_dark_gray = Color( 44, 44, 44, 100 )
local col_white = Color( 200, 200, 200, 255 )
local col_green = Color( 0, 255, 0, 255 )

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():Distance( EyePos() ) > THE_Printer.Config.DisableUIDistance then
		return
	end
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	local vector1 = Vector(0.72, -10.92, 2.10)
	local vector2 = Vector(6.12, 10.40, 3.56)
	local vector3 = Vector(-2.09, -10.92, 2.05)
	local vector4 = Vector(0.24, 10.72, 3.56)
	
	local tr = self:WorldToLocal( LocalPlayer():GetEyeTrace().HitPos )

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 3.1, Ang, 0.11)
	
		draw.RoundedBox(0,-98,-67,196,124, col_dark_gray)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(midbox)
		surface.DrawTexturedRect(-93,-61,186,112)
		surface.SetMaterial(rectline)
		surface.DrawTexturedRect(-93,-61,186,112)
		surface.SetMaterial(greybig)
		surface.DrawTexturedRect(-71,-20,142,22)
		surface.SetMaterial(greybig)
		surface.DrawTexturedRect(-71,-50,142,22)
		surface.SetMaterial(greybig)
		surface.DrawTexturedRect(-71,10,142,22)
		
		draw.DrawText( DarkRP.formatMoney( self:GetMoneyStored() ), "THEPrinter_HackerFont", 0, -46, col_white, TEXT_ALIGN_CENTER )
		
		if tr:WithinAABox( vector1, vector2) then
			draw.DrawText("Scan for printers", "THEPrinter_HackerFont", 0, 12, col_green, TEXT_ALIGN_CENTER )
		else
			draw.DrawText("Scan for printers", "THEPrinter_HackerFont", 0, 12, col_white, TEXT_ALIGN_CENTER )
		end
		
		if tr:WithinAABox( vector3, vector4) then
			draw.DrawText("Withdraw money", "THEPrinter_HackerFont", 0, -17, col_green, TEXT_ALIGN_CENTER )
		else
			draw.DrawText("Withdraw money", "THEPrinter_HackerFont", 0, -17, col_white, TEXT_ALIGN_CENTER )	
		end
	cam.End3D2D()
end