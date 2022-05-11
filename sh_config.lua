Config = {
    Framework = '', -- ESX, QBCORE. --> Use BLOCK CAPS.
    MaxTime = 10, -- Max time to send to hospital. In minutes.
    CheckDistance = true, -- If player get too far away it will send them back, and increase time.
    DefaultLocation = 'P', -- Default location to send people (if player doesn't specify).
    Job = 'ambulance', -- Which job can send people to hospital.
    SendMessageToJob = true, -- When true members of the job will be informed of the new patient.
    Locations = {
        ['P'] = { -- Label for sending to a specific hospital. Can change the default in the server file.
		label = "Pillbox Hospital",
		incoords = vector3(333.88, -548.71, 28.74), -- Where you are teleported to when being sent.
		outcoords = vector3(325.3977, -583.0153, 35.2109), -- Where you will be teleported to after the time ends.
		distance = 15 -- How far you can get away before teleport.
        },
        ['B'] = {
            label = "Paleto Bay Hospital",
            incoords = vector3(-255.59, 6311.59, 32.46),
            outcoords = vector3(-234.8, 6317.44, 31.5),
            distance = 20
        },
        ['S'] = {
            label = "Sandy Shores Hospital",
            incoords = vector3(1821.23, 3674.59, 34.29),
            outcoords = vector3(1841.54, 3668.97, 33.68),
            distance = 20
        }
    },
    Config.Items = {
        burger = 2, -- To disable remove "burger" and "water" leaving just {}.
        water = 2
    }
}