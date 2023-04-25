local onDutyWebhook = "PASTE_YOUR_WEBHOOK_HERE"
local offDutyWebhook = "PASTE_YOUR_WEBHOOK_HERE"

RegisterServerEvent('cr-toggleduty:server:log', function(hook, citizenid, job)
    local discord
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local identifier = GetPlayerIdentifier(source, i)

        if identifier:find('discord') then
            discord = string.sub(identifier, 9)
        end
    end
    if hook == "on" then
        local embedData = {
            {
                ['title'] = "**User went on duty.**",
                ['color'] = 65280,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = "CitizenID: ".. citizenid .. "\nDiscord: <@".. discord .. ">\nJob: ".. job,
                ['author'] = {
                    ['name'] = 'Creative Development',
                    ['icon_url'] = 'https://media.discordapp.net/attachments/957021435652620298/1100495355755376640/Creative_development.png?width=449&height=449',
                },
            }
        }
        PerformHttpRequest(onDutyWebhook, function() end, 'POST', json.encode({ username = 'cr-toggleDuty', embeds = embedData}), { ['Content-Type'] = 'application/json' })
        Citizen.Wait(100)
    else

        local embedData = {
            {
                ['title'] = "**User went off duty.**",
                ['color'] = 16711680,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = "CitizenID: ".. citizenid .. "\nDiscord: <@".. discord .. ">\nJob: ".. job,
                ['author'] = {
                    ['name'] = 'Creative Development',
                    ['icon_url'] = 'https://media.discordapp.net/attachments/957021435652620298/1100495355755376640/Creative_development.png?width=449&height=449',
                },
            }
        }
        PerformHttpRequest(offDutyWebhook, function() end, 'POST', json.encode({ username = 'cr-toggleDuty', embeds = embedData}), { ['Content-Type'] = 'application/json' })
        Citizen.Wait(100)
    end
end)