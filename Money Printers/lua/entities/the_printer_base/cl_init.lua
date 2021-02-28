include( "shared.lua" )

function ENT:Initialize()
end

-- LOAD FONTS
surface.CreateFont( "THEPrinter_DefaultFont", {
	font = "coolvetica", 
	size = ScreenScale( 7 ),
	weight = 400,
} )

surface.CreateFont( "THEPrinter_HackerFont", {
	font = "Arial",
	size = ScreenScale( 5.5 ),
	weight = 500,
} )

local midbox = Material("materials/theprinter/content/the_middle_box2.png")
local coin = Material("materials/theprinter/content/the_coin_icon.png")
local speaker = Material("materials/theprinter/content/the_speaker_icon.png")
local logo = Material("materials/theprinter/content/the_x_logo.png")
local front = Material("materials/theprinter/content/the_front_main.png")
local ink = Material("materials/theprinter/content/the_front_ink.png")
local paper = Material("materials/theprinter/content/the_front_paper.png")
local backhole = Material("materials/theprinter/content/the_back_hole.png")
local backvent = Material("materials/theprinter/content/the_back_vent.png")
local armor = Material("materials/theprinter/content/the_bar_armor.png")
local health = Material("materials/theprinter/content/the_bar_health.png")
local fan = Material("materials/theprinter/content/the_back_fan.png") 
local box = Material("materials/theprinter/content/the_middle_bot.png")

local col_dark_gray = Color( 44, 44, 44, 100 )

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():Distance( EyePos() ) > THE_Printer.Config.DisableUIDistance then 
		return 
	end	
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	local spin = CurTime() * 180
	
	local thePrinterHealth = math.Clamp(self:GetPrinterHealth(), 0, 100)
	local thePrinterArmor = math.Clamp(self:GetPrinterArmor(), 0, 100)
	local thePrinterInk = math.Clamp(self:GetInkAmount(), 0, 250)
	local thePrinterPaper = math.Clamp(self:GetPaperAmount(), 0, 120)

	Ang:RotateAroundAxis(Ang:Up(), 180)

	cam.Start3D2D(Pos + Ang:Up() * 3.1, Ang, 0.11)
	
		draw.RoundedBox( 0, -98, -67, 196, 124, col_dark_gray)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(midbox)
		surface.DrawTexturedRect(-93,-27,186,27)
		surface.SetMaterial(midbox)
		surface.DrawTexturedRect(-93,-58,186,27)
		surface.SetMaterial(box)
		surface.DrawTexturedRect(-93,21,186,27)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(logo)
		surface.DrawTexturedRect(-100,-65,200,120)
		
		if (self:GetMutePrinter()) then
			surface.SetMaterial(speaker)
			surface.DrawTexturedRect(69,26,23,18)
		end

		if (self:GetMoneyBoost()) then
			surface.SetMaterial(coin)
			surface.DrawTexturedRect(47,27,20,15)
		end
		
		if self:GetSoftWare() then
			draw.DrawText( DarkRP.formatMoney( self:GetMoneyStored() ).." (Protected)", "THEPrinter_DefaultFont", 0, -54, self.thePrinterTextColor, TEXT_ALIGN_CENTER )
		else
 			draw.DrawText( DarkRP.formatMoney( self:GetMoneyStored() ), "THEPrinter_DefaultFont", 0, -54, self.thePrinterTextColor, TEXT_ALIGN_CENTER ) 
		end
		
		draw.DrawText("Temp: "..self:GetHeatAmount().."C", "THEPrinter_DefaultFont", 0, -23, self.thePrinterTextColor, TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(health)
		surface.DrawTexturedRect(-88, 24, thePrinterHealth*1.3, 21)
		surface.SetMaterial(armor)
		surface.DrawTexturedRect(-88, 24, thePrinterArmor*1.3, 21)
			
	cam.End3D2D()	
	
	Ang:RotateAroundAxis(self:GetAngles():Up(), 270)
	Ang:RotateAroundAxis(self:GetAngles():Right(), 270)
	Ang:RotateAroundAxis(self:GetAngles():Up(), 450)

	cam.Start3D2D(Pos + Ang:Up() * 6.47, Ang, 0.11)
	
		draw.RoundedBox(0,-99,-28,198,55,self.thePrinterUIColor)
		surface.SetDrawColor(255,255,255,255)
		
		surface.SetMaterial(front)
		surface.DrawTexturedRect(-93,-23,186,46)
		
		surface.SetMaterial(ink)
		surface.DrawTexturedRect( -88, -19,thePrinterInk / 5.5,15 )

		surface.SetMaterial(paper)
		surface.DrawTexturedRect(-88,3,thePrinterPaper / 2.62, 15 )
		
		draw.DrawText(self.thePrinterName, "THEPrinter_DefaultFont", 27, -11, self.thePrinterTextColor, TEXT_ALIGN_CENTER )

	cam.End3D2D()
	
	Ang:RotateAroundAxis(self:GetAngles():Up(), 270)
	Ang:RotateAroundAxis(self:GetAngles():Right(), 180) 
	Ang:RotateAroundAxis(self:GetAngles():Up(), 450) 

	cam.Start3D2D(Pos + Ang:Up() * 7.5, Ang, 0.11)
	
		draw.RoundedBox(0,-99,-28,198,55,self.thePrinterUIColor)
	
		surface.SetDrawColor(100,100,100,255)
		surface.SetMaterial(backhole)
		surface.DrawTexturedRect(-93,-23,186,46)
		surface.SetDrawColor( 255,255,255,255 )
		
		-- Set in separate if checks, since the 3 fans need to be displayed on same time.
		
		if (self:GetCoolerFan()) >= 1 then
			surface.SetMaterial( fan )
			surface.DrawTexturedRectRotated( -50, 0, 45, 45, spin )
		end
			
		if (self:GetCoolerFan()) >= 2 then
			surface.SetMaterial( fan )
			surface.DrawTexturedRectRotated( 0, 0, 45, 45, spin )			
		end
		
		if (self:GetCoolerFan()) >= 3 then
			surface.SetMaterial( fan )
			surface.DrawTexturedRectRotated( 50, 0, 45, 45, spin )	
		end
		
		surface.SetDrawColor(100,100,100,255)
		surface.SetMaterial(backvent)
		surface.DrawTexturedRect(-93,-23,186,46)
		
	cam.End3D2D()
end