
RegisterNetEvent("cdtsports:showUi")
AddEventHandler("cdtsports:showUi", function ()
    SendNUIMessage(
            {
                type = "showUi",
                data = datasp,
                lvlstrength = Options["strength"].levels,
                lvlrun = Options["run"].levels,
                lvlswim = Options["swim"].levels,
                lvlcardio = Options["cardio"].levels,
            }
        )
    isUiOpen = true
end)

RegisterNetEvent("cdtsports:majUi")
AddEventHandler("cdtsports:majUi", function ()
    SendNUIMessage(
            {
                type = "majDatas",
                data = datasp,
            }
        )
end)

RegisterNetEvent("cdtsports:hideUi")
AddEventHandler("cdtsports:hideUi", function ()
    SendNUIMessage(
            {
                type = "hideUi",
            }
        )
    isUiOpen = false
end)

RegisterKeyMapping("uisports", "UiSports Show|Hide","keyboard", Options.key)

RegisterCommand("uisports", function ()
    if isUiOpen == true then
        TriggerEvent("cdtsports:hideUi")
    else
        TriggerEvent("cdtsports:showUi")
    end
end, false)