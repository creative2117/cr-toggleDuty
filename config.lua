Config = {
    debug = false,
    useTarget = GetConvar('UseTarget', 'false') == 'true',

    key = 47, -- (G) https://docs.fivem.net/docs/game-references/controls/
    
    textOnDuty = "Go off duty", -- 3d text to display when you are ON duty
    textOffDuty = "Go on duty", -- 3d text to display when you are OFF duty
    targetText = "Toggle duty", -- Text to display in qb-target
    targetDontHaveJob = "You dont have this job", -- what to notify when you don't have the job when useing target
    
    --name = name of the job
    --coords = coords for the location
    --icon = the icon in qb-target
    jobLocations = {
        ["police"] = { name = "police", model = {'police', 'police2'} coords = vector3(901.46, -1060.14, 32.83), icon = "fa fa-clipboard" },
        ["ambulance"] = { name = "ambulance", model = 'ambulance', coords = vector3(896.97, -1057.59, 32.83), icon = "fa fa-clipboard" },
    },
}
