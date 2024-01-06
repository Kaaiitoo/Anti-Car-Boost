if Config.OldESX == true then
ESX = nil
TriggerEvent(Config.TriggerESX, function(obj) ESX = obj end)
else
ESX = exports["es_extended"]:getSharedObject()
end

local PRIMARY_IDENTIFIER = ESX.GetConfig().Identifier or GetConvar('sv_lan', '') == 'true' and 'ip' or "license"
local function GetIdentifier(source)
    local identifier = PRIMARY_IDENTIFIER..':'
    for _, v in pairs(GetPlayerIdentifiers(source)) do
        if string.match(v, identifier) then
            identifier = string.gsub(v, identifier, '')
            return identifier
        end
    end
end

RegisterServerEvent('checkSpeed')
AddEventHandler('checkSpeed', function(speed)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceName = xPlayer.getName()
    local license = GetIdentifier(source)
    local playerIP = GetPlayerEndpoint(source)
    local ipLink = ""
    if playerIP ~= "" then
        ipLink = "**IP:** [||" .. playerIP .. "||](https://www.ip-tracker.org/locator/ip-lookup.php?ip=" .. playerIP .. ")"
    else
        ipLink = "**IP :** N/A"
    end
    if speed > Config.VitesseMaxAutoriser then
        DropPlayer(source, Config.MessageKick)
        local w = {
            { 
                ["author"] = { ["name"] = Config.DescriptionLogs, ["icon_url"] = Config.IconLogs },
                ["color"] = Config.CouleurLogs,
                ["title"] = Title,
                ["description"] = "\nNom du joueur : " .. sourceName .. "\nLicense du joueur : " .. license .. "\n" .. ipLink .. "\n Il a été détecté à **" .. speed .. "** km/h, il a donc été kick du serveur !"
            }
        }
        PerformHttpRequest(Config.LogsAntiCarBoost, function(err, text, headers) end, 'POST', json.encode({username = Config.NameLogs, embeds = w, avatar_url = Config.IconLogs}), { ['Content-Type'] = 'application/json'})
    end
end)
