if Config.OldESX == true then
ESX = nil
TriggerEvent(Config.TriggerESX, function(obj) ESX = obj end)
else
ESX = exports["es_extended"]:getSharedObject()
end

RegisterNetEvent(Config.TriggerLoad)
AddEventHandler(Config.TriggerLoad, function(xPlayer)
ESX.PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local vehicleClass = GetVehicleClass(vehicle)
            if Config.ClassesAutorisees[vehicleClass] then
                local speed = GetEntitySpeed(vehicle) * 3.6
                if speed > Config.VitesseMaxAutoriser then
                    DeleteEntity(vehicle)
                    TriggerServerEvent('checkSpeed', speed)
                end
            end
        end
    end
end)
