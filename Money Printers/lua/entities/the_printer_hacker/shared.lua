ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Hacking Device"
ENT.Author = "Mikael"
ENT.Category = "The Printer"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "MoneyStored")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Bool", 0, "HackedPrinter")
	self:NetworkVar("Bool", 1, "HackingPrinter")
	self:NetworkVar("Int", 2, "HP")
end
