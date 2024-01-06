fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
shared_scripts {"config.lua"}

client_scripts {
"client.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua",
}
