AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/props_lab/reciever01a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:SetColor( Color( 0,0,0,255 ) )
	self:SetHP(100)
	
	self.Vector1 = Vector(0.72, -10.92, 2.10)
	self.Angle1 = Vector(6.12, 10.40, 3.56)
	self.Vector3 = Vector(-2.09, -10.92, 2.05)
	self.Angle3 = Vector(0.24, 10.72, 3.56)
	
	if THE_Printer.Config.AutoDeleteUpgrades then
		timer.Simple( THE_Printer.Config.AutoDeleteTimer, function() 
			if IsValid( self ) then 
				self:Remove() 
			end 
		end )
	end
end

function ENT:OnTakeDamage( dmg )
	self:SetHP( ( self:GetHP() or 100 ) - dmg:GetDamage() )
    if ( self:GetHP() <= 0 ) then
        self:Remove()
    end
end

function ENT:Use( ply, ent )
	if not ply:IsPlayer() then 
		return 
	end

	local EI = self:EntIndex()
	local calc = math.random( 1, 100 )

	if ( ( self.lastUsed or CurTime() ) <= CurTime() ) then

		self.lastUsed = CurTime() + 0.5
		
		if ply:GetEyeTrace().Entity != self then 
			return 
		end
		local tr = self:WorldToLocal( ply:GetEyeTrace().HitPos ) 
		
		if tr:WithinAABox( self.Vector1 , self.Angle1 ) then
			if not timer.Exists( "the_printer_hacker_id"..EI ) then 
				for k, v in pairs( ents.FindByModel( "models/theprinter/reciever01a.mdl" ) ) do
					if self:GetPos():Distance( v:GetPos() ) < 700 then 
						if v:GetSoftWare() then
							if (calc > -1 and calc <= 35) then
								self:Remove()
								DarkRP.notify( ply, 1, 5, "The printers software destroyed your hacking device and stopped your hacking attempt." )
							elseif (calc > 35 and calc <= 75) then
								 ply:Ignite( 10 )
								 DarkRP.notify( ply, 1, 5, "The printers software took action and set you on fire." )
							elseif (calc > 75 and calc <= 100) then
								DarkRP.notify( ply, 1, 5, "The printers software failed to take action." )
							end
						elseif not v:GetSoftWare() then
							sound.Play( "buttons/blip1.wav", self:GetPos() )
							self:SetHackingPrinter( true )
							
							timer.Create( "the_printer_hacker_id"..EI, 3, 0, function()
								if IsValid( self ) then
									self:SetMoneyStored( self:GetMoneyStored() + v:GetMoneyStored() )
									v:SetMoneyStored( 0 )
									
									self:SetHackedPrinter( true )
									self:SetHackingPrinter( false )
								end
							end)
						end
					end
				end
			end	
		elseif tr:WithinAABox( self.Vector3, self.Angle3 ) then
			if self:GetMoneyStored() == 0 then
				DarkRP.notify( ply, 1, 5, "The hacking device contains no money at the moment." )
				return 
			end
			
			sound.Play( "buttons/blip1.wav", self:GetPos() )
			ply:addMoney( self:GetMoneyStored() )	
			DarkRP.notify( ply, 1, 5, "You've taken "..DarkRP.formatMoney( self:GetMoneyStored() ).." from the hacker device." )
			self:SetMoneyStored( 0 )	
		end
	end
end

function ENT:OnRemove()
	local EI = self:EntIndex()
	timer.Remove( "the_printer_hacker_id"..EI )
end