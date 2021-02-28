--[[
THIS SCRIPT IS CREATED BY CRAP-HEAD
GMODSTORE PROFILE: https://www.gmodstore.com/users/crap-head
CRAP-HEAD STEAM ID || CRAP-HEAD ID 64
https://veryleaks.cz/
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( self.thePrinterModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:GetPhysicsObject():Wake()
	self:SetColor( self.thePrinterColor  )
	self:SetPrinterHealth( self.thePrinterHealth ) 
	self:SetPrinterArmor( self.thePrinterArmor )	
	self:SetInkAmount( self.thePrinterInkAmount )	
	self:SetPaperAmount( self.thePrinterPaperAmount )
	self:SetHeatAmount( THE_Printer.Config.DefaultHeat )
	self.Sound = CreateSound( self, self.thePrinterSound )
	self.Sound:SetSoundLevel( 55 )
    self.Sound:PlayEx(1, 100)
	self.Sound:Play()
	self:CreateMoneyTimer()
	self:Fan()
end

function ENT:OnTakeDamage( dmg )
    if self.burningup then 
		return 
	end
	
	self:SetPrinterArmor( ( self:GetPrinterArmor() or 100 ) - dmg:GetDamage() )
	if self:GetPrinterArmor() >= 1 then 
		return 
	end	
	
	self:SetPrinterHealth( ( self:GetPrinterHealth() or 100 ) - dmg:GetDamage() )  
	
    if self:GetPrinterHealth() <= 25 then       
        self:SetMoneyStored( self:GetMoneyStored() / 2 )           
    end
	
    if self:GetPrinterHealth() <= 0 then          
		local RNG = self.printerExplodeRNG           
		if ( RNG == self.printerExplodeRNGEquals ) then             
			self:BurstIntoFlames()               
        else           
			self:Destruct()
            self:Remove()               
       end	   
    end      
end

function ENT:Destruct() 
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart(vPoint)
    effectdata:SetOrigin(vPoint)
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
	
	if not THE_Printer.Config.CreateFireOnExplode then
		if IsValid( self ) then
			local Fire = ents.Create( "fire" )
			Fire:SetPos( vPoint )
			Fire:SetAngles( Angle( 0, 0, 0 ) )
			Fire:Spawn()
		end
	end
	
    DarkRP.notify(self:Getowning_ent(), 1, 4, DarkRP.getPhrase("money_printer_exploded"))   
end

function ENT:BurstIntoFlames()
    DarkRP.notify(self:Getowning_ent(), 0, 4, DarkRP.getPhrase("money_printer_overheating"))
    self.burningup = true
	
    local burntime = math.random(8, 18)
    self:Ignite( burntime, 0 )
	
    timer.Simple( burntime, function() 
		if IsValid( self ) then
			self:Fireball()
		end
	end) 
end

function ENT:Fireball() 
    if !self:IsOnFire() then
		self.burningup = false
		return
	end
    local dist = math.random( 20, 280 )
	
    self:Destruct()
	
    for k, v in pairs( ents.FindInSphere( self:GetPos(), dist ) ) do
        if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
            v:Ignite(math.random(5, 22), 0)
        elseif v:IsPlayer() then
            local distance = v:GetPos():Distance(self:GetPos())
            v:TakeDamage(distance / dist * 100, self, self)
        end
    end
	
    self:Remove()	
end

function ENT:StartTouch( ent )
	if ent:IsPlayer() then 
		return 
	end
	
	if ent:GetClass() == "the_printer_cash" then
		if not self:GetMoneyBoost() then
			self:SetMoneyBoost( true )
			ent:Remove()
		end	
	elseif ent:GetClass() == "the_printer_mute" then
		if not self:GetMutePrinter() then
			self:SetMutePrinter( true )
			self.Sound:Stop()
			ent:Remove()
		end
	elseif ent:GetClass() == "the_printer_software" then
		if not self:GetSoftWare() then
			self:SetSoftWare( true )
			ent:Remove()
		end		
	elseif ent:GetClass() == "the_printer_repair" then
		if self:GetPrinterHealth() < 100 then 
			self:SetPrinterHealth( self.thePrinterHealth )
			self:SetPrinterArmor( self.thePrinterArmor )	
			ent:Remove()
		end		
	elseif ent:GetClass() == "the_printer_fan" then
		if self:GetCoolerFan() < math.Clamp( self.MaximumFans, 0, 3 ) then
			self:SetCoolerFan( math.Clamp( self:GetCoolerFan() + 1, 0, 3 ) )
			ent:Remove()
		end
	elseif ent:GetClass() == "the_printer_paper" then
		if self:GetPaperAmount() <= 0 then 
			self:SetPaperAmount( self:GetPaperAmount() + 20 )
			timer.UnPause( "CreateMoneyTimer"..self:EntIndex() )
			ent:Remove()
		elseif ( self:GetPaperAmount() > 0 and self:GetPaperAmount() <= 119 ) then
			self:SetPaperAmount( self:GetPaperAmount() + 20 )
			timer.UnPause( "CreateMoneyTimer"..self:EntIndex() )
			ent:Remove()
		end
	elseif ent:GetClass() == "the_printer_ink" then
		if self:GetInkAmount() <= 0 then  
			timer.UnPause( "CreateMoneyTimer"..self:EntIndex() )
			self:SetInkAmount( self:GetInkAmount() + 50 )
			ent:Remove()			
		elseif ( self:GetInkAmount() > 0 and self:GetInkAmount() <= 249 ) then
			self:SetInkAmount( self:GetInkAmount() + 50 )
			timer.UnPause( "CreateMoneyTimer"..self:EntIndex() )
			ent:Remove()
		end
	end	
end

function ENT:Fan()
	timer.Create( "HeatTimer"..self:EntIndex(), self.theHeatTimer, 0, function() 	
		if self:GetHeatAmount() >= self.theOverheatNumber then
			if self:GetPrinterArmor() >= 1 then
				self:SetPrinterArmor( self:GetPrinterArmor() - 6 )
			else
				self:SetPrinterHealth( self:GetPrinterHealth() - 8 )
			end
			
			if self:GetPrinterHealth() <= 0 then
				self:Destruct()
				self:Remove()
			end
		end
		
		if self:SkyTrace() then -- Outside
			self:SetHeatAmount( math.Clamp( self:GetHeatAmount() - 1, 20, 120 ) )
		else
			self:SetHeatAmount( math.Clamp( self:GetHeatAmount() + 1, 20, 120 ) )
		end
		
		if self:GetCoolerFan() == 0 then -- No fans
			if not self:SkyTrace() then -- Inside
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() + math.random( 1, 3 ), 20, 120 ) )
			end
		elseif self:GetCoolerFan() == 1 then -- One fan installed	
			if not self:SkyTrace() then -- Inside
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() - math.random( 1, 3 ), 20, 120 ) )
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() + math.random( 1, 3 ), 20, 120 ) )
			end
		elseif self:GetCoolerFan() == 2 then -- Two fans installed
			if not self:SkyTrace() then -- Inside
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() - math.random( 2, 5 ), 20, 120 ) )
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() + math.random( 1, 4 ), 20, 120 ) )
			end
		elseif self:GetCoolerFan() == 3 then -- Three fans installed (max fans)
			if not self:SkyTrace() then -- Inside
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() - math.random( 2, 6 ), 20, 120 ) )
				self:SetHeatAmount( math.Clamp( self:GetHeatAmount() + math.random( 1, 4 ), 20, 120 ) )
			end
		end
	end)	
end

function ENT:CreateMoneyTimer()
	timer.Create( "CreateMoneyTimer"..self:EntIndex(), self.thePrintTimer, 0, function() 
		if (self:GetPaperAmount() == 0) or (self:GetInkAmount() == 0) then 
			timer.Pause( "CreateMoneyTimer"..self:EntIndex() )	
		end

		if self:GetMoneyBoost() then
			self:SetMoneyStored( self:GetMoneyStored() + self.thePrintAmount + self.theMoneyBoostAmount )	
		else
			self:SetMoneyStored( self:GetMoneyStored() + self.thePrintAmount )	
		end
		
		self:SetPaperAmount( self:GetPaperAmount() - self.thePrinterPaperUsage )
		self:SetInkAmount( self:GetInkAmount() - self.thePrinterInkUsage )		
	end)
end

function ENT:Use( ply, ent )
	if self:GetMoneyStored() == 0 then
		return 
	end
	if ( ( self.lastUsed or CurTime() ) <= CurTime() ) then
		self.lastUsed = CurTime() + 0.25
		ply:addMoney( self:GetMoneyStored() )	
		DarkRP.notify( ply, 1, 5, "You've taken "..DarkRP.formatMoney( self:GetMoneyStored() ).." from the printer." )
		self:SetMoneyStored( 0 )		
	end	
end

function ENT:SkyTrace()
    local sky = {}
    sky.start = self:GetPos()
    sky.endpos = self:GetPos() + Vector(0, 0, 100000)
    sky.filter = self
    local tsky = util.TraceLine(sky)  
    return tsky.HitSky
end

function ENT:OnRemove()
    if self.Sound then self.Sound:Stop() end
	timer.Remove( "CreateMoneyTimer"..self:EntIndex() )
	timer.Remove( "HeatTimer"..self:EntIndex() )
end