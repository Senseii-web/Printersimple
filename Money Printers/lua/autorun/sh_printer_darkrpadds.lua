-- Add all caterogies and DarkRP entities here automatically.

function SH_THEPRINTER_DarkRPAdds()
	-- Create two categories
	DarkRP.createCategory{
		name = "The Printer - Money Printers",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 107, 0, 255),
		canSee = function(ply) return true end,
		sortOrder = 50,
	}
	DarkRP.createCategory{
		name = "The Printer - Printer Upgrades",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 107, 0, 255),
		canSee = function(ply) return true end,
		sortOrder = 51,
	}
	
	DarkRP.createCategory{
		name = "The Printer - Others",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 107, 0, 255),
		canSee = function(ply) return true end,
		sortOrder = 51,
	}
	
	-- Bronze Printer
	DarkRP.createEntity("Bronze Printer", {
		ent = "1money_bronze",
		model = "models/theprinter/reciever01a.mdl",
		price = 1500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buybronzeprinter"
	})
	
	-- Silver Printer
	DarkRP.createEntity("Silver Printer", {
		ent = "2money_silver",
		model = "models/theprinter/reciever01a.mdl",
		price = 2500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buysilverprinter"
	})
	
	-- Gold Printer
	DarkRP.createEntity("Gold Printer", {
		ent = "3money_gold",
		model = "models/theprinter/reciever01a.mdl",
		price = 3500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buygoldprinter"
	})
	
	-- Platinum Printer
	DarkRP.createEntity("Platinum Printer", {
		ent = "4money_plat",
		model = "models/theprinter/reciever01a.mdl",
		price = 4500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buyplatinumprinter"
	})
	
	-- Diamond Printer
	DarkRP.createEntity("Diamond Printer", {
		ent = "5money_diamond",
		model = "models/theprinter/reciever01a.mdl",
		price = 5500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buydiamondprinter"
	})
	
	-- Lava Printer
	DarkRP.createEntity("Lava Printer", {
		ent = "6money_lava",
		model = "models/theprinter/reciever01a.mdl",
		price = 6500,
		max = 1,
		category = "The Printer - Money Printers",
		cmd = "buylavaprinter"
	})
	
	-- Donator Printer
	DarkRP.createEntity("Donator Printer", {
		ent = "7money_donator",
		model = "models/theprinter/reciever01a.mdl",
		price = 7500,
		max = 1,
		customCheck = function(ply) return ply:GetUserGroup() == "donator" end,
		CustomCheckFailMsg = function(ply, entTable) return "You need to be a donator to buy this entity!" end,
		category = "The Printer - Money Printers",
		cmd = "buydonatorprinter"
	})
	
	-- Printer Upgrades
	DarkRP.createEntity("Cash Boost Upgrade", {
		ent = "the_printer_cash",
		model = "models/props_lab/reciever01b.mdl",
		price = 10000,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buycashboostupgrade"
	})
	DarkRP.createEntity("Fan Upgrade", {
		ent = "the_printer_fan",
		model = "models/props_lab/reciever01b.mdl",
		price = 1500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buyfanupgrade"
	})
	DarkRP.createEntity("Ink Upgrade", {
		ent = "the_printer_ink",
		model = "models/props_lab/reciever01b.mdl",
		price = 500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buyinkupgrade"
	})
	DarkRP.createEntity("Mute Upgrade", {
		ent = "the_printer_mute",
		model = "models/props_lab/reciever01b.mdl",
		price = 500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buymuteupgrade"
	})
	DarkRP.createEntity("Paper Upgrade", {
		ent = "the_printer_paper",
		model = "models/props_lab/reciever01b.mdl",
		price = 500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buypaperupgrade"
	})
	DarkRP.createEntity("Repair Upgrade", {
		ent = "the_printer_repair",
		model = "models/props_lab/reciever01b.mdl",
		price = 1500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buyrepairupgrade"
	})
	DarkRP.createEntity("Software Upgrade", {
		ent = "the_printer_software",
		model = "models/props_lab/reciever01b.mdl",
		price = 1500,
		max = 1,
		category = "The Printer - Printer Upgrades",
		cmd = "buysoftwareupgrade"
	})
	
	-- Others
	DarkRP.createEntity("Hacking Device", {
		ent = "the_printer_hacker",
		model = "models/props_lab/reciever01b.mdl",
		price = 5000,
		max = 1,
		category = "The Printer - Others",
		cmd = "buyhackingdevice"
	})
end
hook.Add( "loadCustomDarkRPItems", "SH_THEPRINTER_DarkRPAdds", SH_THEPRINTER_DarkRPAdds )