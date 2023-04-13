local QBCore = exports['qb-core']:GetCoreObject()
local job = QBCore.Functions.GetPlayerData().job

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    job = QBCore.Functions.GetPlayerData().job
    init()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    job = JobInfo
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
	job = val.job
end)

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function init()
    if not Config.useTarget then
        CreateThread(function()
            while true do
                local inRange = false
                local sleep = 3

                local PlayerPed = PlayerPedId()
                local PlayerPos = GetEntityCoords(PlayerPed)
                
                
                for k, _ in pairs(Config.jobLocations) do
                    if job.name == Config.jobLocations[k].name then
                        local coords = vector3(Config.jobLocations[k].coords.x, Config.jobLocations[k].coords.y, Config.jobLocations[k].coords.z)
                        local dist = #(PlayerPos - coords)
                        if dist < 15 then
                            inRange = true
                            
                            if dist < 5 then
                                
                                -- print(Config.jobLocations[k].name)
                                if not job.onduty then
                                    -- print(job.onduty)
                                    DrawText3D(coords.x, coords.y, coords.z, Config.textOffDuty)
                                    if IsControlJustReleased(0, Config.key) then
                                        sleep = 1000
                                        TriggerServerEvent("QBCore:ToggleDuty")
                                    end
                                else
                                    DrawText3D(coords.x, coords.y, coords.z, Config.textOnDuty)
                                    if IsControlJustReleased(0, Config.key) then
                                        sleep = 1000
                                        TriggerServerEvent("QBCore:ToggleDuty")
                                    end
                                end
                            end
                        end
                    end
                end 

                if not inRange then
                    sleep = 2000
                end
                Wait(sleep)
            end
        end)
    else
        for k, _ in pairs(Config.jobLocations) do

            exports['qb-target']:AddCircleZone('cr-toggleDuty' .. k, vector3(Config.jobLocations[k].coords.x, Config.jobLocations[k].coords.y, Config.jobLocations[k].coords.z), 0.5,{
                name = 'cr-picking_' .. k, debugPoly = Config.debug, useZ=true}, {
                options = {{label = Config.targetText,icon = Config.jobLocations[k].icon, action = function() toggleDuty(k) end}},
                distance = 2.0
            })
        end
    end
end

function toggleDuty(k)
    if job.name == Config.jobLocations[k].name then
        TriggerServerEvent("QBCore:ToggleDuty")
    else
        QBCore.Functions.Notify(Config.targetDontHaveJob, "error", 1000)
    end
end