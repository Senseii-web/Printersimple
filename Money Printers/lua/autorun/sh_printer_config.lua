THE_Printer = {}
THE_Printer.Config = {}

THE_Printer.Config.CreateFireOnExplode = false
THE_Printer.Config.DefaultHeat = 25 -- The temperature any money printer start at. It will randomly increase/decrease over time.
THE_Printer.Config.DisableUIDistance = 400 -- The distance of which the UI is disabled/not shown on the printers.

THE_Printer.Config.AutoDeleteUpgrades = true -- Should printer updates automatically be deleted after x amount of seconds?
-- THIS IS ONLY IF THEY ARE NOT INSTALLED TO AVOID ENTITIES FLOATING AROUND ON THE SERVER
THE_Printer.Config.AutoDeleteTimer = 600 -- Delete after 600 seconds (10 minutes) if they do not get installed.