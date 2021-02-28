ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "The Printer"
ENT.Author = "Mikael"
ENT.Category = "The Printer"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 0, "PrinterArmor")
	self:NetworkVar("Bool", 0, "MoneyBoost")
	self:NetworkVar("Bool", 1, "MutePrinter")
	self:NetworkVar("Bool", 2, "SoftWare")
	self:NetworkVar("Int", 2, "PaperAmount")
	self:NetworkVar("Int", 3, "PrinterHealth")
	self:NetworkVar("Int", 4, "InkAmount")
	self:NetworkVar("Int", 5, "MoneyStored")
	self:NetworkVar("Int", 6, "CoolerFan")
	self:NetworkVar("Int", 7, "HeatAmount")
end