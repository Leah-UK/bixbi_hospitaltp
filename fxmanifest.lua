--[[----------------------------------
Creation Date:	15/03/21
]]------------------------------------
fx_version 'cerulean'
game 'gta5'
author 'Leah#0001'
version '2.0'
versioncheck 'https://raw.githubusercontent.com/Bixbi-FiveM/bixbi_hospitaltp/main/fxmanifest.lua'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'sh_config.lua'
}

client_scripts {
	'client/cl_framework.lua',
	'client/cl_functions.lua'
}

server_scripts {
	'server/sv_framework.lua',
	'server/sv_functions.lua',
	'server/sv_version.lua'
}
