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
	self:SetModel( "models/props_lab/reciever01b.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:SetColor( Color( 0,0,0,255 ) )
	self.UpgradeHP = 100
	self:SetText( "Paper Upgrade" )
	
	if THE_Printer.Config.AutoDeleteUpgrades then
		timer.Simple( THE_Printer.Config.AutoDeleteTimer, function() 
			if IsValid( self ) then 
				self:Remove() 
			end 
		end )
	end
end

function ENT:OnTakeDamage( dmg )
	self.UpgradeHP = self.UpgradeHP - dmg:GetDamage()
    if self.UpgradeHP <= 0 then
        self:Remove()
    end
end