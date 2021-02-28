ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Ink Upgrade"
ENT.Author = "Mikael"
ENT.Category = "The Printer"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "price")
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("String", 0, "Text")
end