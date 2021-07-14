Config = {}

Config.MaxTime = 600 -- 10 Minutes (600 seconds)
Config.CheckDistance = true -- When true, going too far from the teleport point will teleport the player back, and add time.

Config.Locations = {
	P = { -- Label for sending to a specific hospital. Can change the default in the server file.
		label = "Pillbox Hospital",
		incoords = {336.4747, -574.0878, 35.2109}, -- Where you are teleported to when being sent.
		outcoords = {325.3977, -583.0153, 35.2109}, -- Where you will be teleported to after the time ends.
		distance = 15 -- How far you can get away before teleport.
	},
	B = {
		label = "Paleto Bay Hospital",
		incoords = {-255.59, 6311.59, 32.46},
		outcoords = {-234.8, 6317.44, 31.5},
		distance = 20
	},
	S = {
		label = "Sandy Shores Hospital",
		incoords = {1821.23, 3674.59, 34.29},
		outcoords = {1841.54, 3668.97, 33.68},
		distance = 20
	}
}

Config.DefaultLocation = "P" -- Default location to send people (if player doesn't specify).