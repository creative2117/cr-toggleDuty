Config = {
    debug = false,
    useTarget = true, -- GetConvar('UseTarget', 'false') == 'true',

    key = 47, -- (G) https://docs.fivem.net/docs/game-references/controls/
    
    textOnDuty = "Go off duty",
    textOffDuty = "Go on duty",
    targetText = "Toggle duty",
    targetDontHaveJob = "You dont have this job",
    
    jobLocations = {
        ["police"] = { name = "police", coords = vector3(901.46, -1060.14, 32.83 - 1), icon = "fa fa-clipboard" },
        ["ambulance"] = { name = "ambulance", coords = vector3(896.97, -1057.59, 32.83), icon = "fa fa-clipboard" },
    },
}