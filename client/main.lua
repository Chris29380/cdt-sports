datasp = {}
isUiOpen = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
    Citizen.Wait(2000)
    -- call triggers
    TriggerEvent("cdtsports:requestdatas")

end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


RegisterNetEvent('onResourceStart')
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        Citizen.Wait(300)
        -- call trigger
        TriggerEvent("cdtsports:requestdatas")
    end
end)

RegisterNetEvent('onResourceStop')
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 

    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

---------------------------------------------------------------
--- Datas
---------------------------------------------------------------

RegisterNetEvent("cdtsports:requestdatas")
AddEventHandler("cdtsports:requestdatas", function ()
    TriggerServerEvent("cdtsports:preparedatas")
end)

RegisterNetEvent("cdtsports:getdatas")
AddEventHandler("cdtsports:getdatas", function (datasports)
    datasp = datasports
    TriggerEvent("cdtsports:startloopstrength")
    TriggerEvent("cdtsports:startlooprun")
    TriggerEvent("cdtsports:startloopswim")
    TriggerEvent("cdtsports:startloopcardio")
    TriggerEvent("cdtsports:majdatasloop")
    TriggerEvent("cdtsports:showUi")
    TriggerEvent("cdtsports:majdatasUi")
end)

---------------------------------------------------------------
--- maj db datas loop
---------------------------------------------------------------

RegisterNetEvent("cdtsports:majdatasloop")
AddEventHandler("cdtsports:majdatasloop", function ()
    Citizen.CreateThread(function ()
        local sleep = Options.majtick or 0
        while true do
            if datasp then
                TriggerServerEvent("cdtsports:majdatas", datasp)
            end
            Wait(sleep)
        end
    end)
end)

---------------------------------------------------------------
--- maj Ui loop
---------------------------------------------------------------

RegisterNetEvent("cdtsports:majdatasUi")
AddEventHandler("cdtsports:majdatasUi", function ()
    Citizen.CreateThread(function ()
        local sleep = Options.majuitick or 0
        while true do
            if datasp then
                if isUiOpen == true then
                    TriggerEvent("cdtsports:majUi", datasp)
                end
            end
            Wait(sleep)
        end
    end)
end)


---------------------------------------------------------------
--- maj datas effects loop
---------------------------------------------------------------

RegisterNetEvent("cdtsports:majdataseffectsloop")
AddEventHandler("cdtsports:majdataseffectsloop", function ()
    Citizen.CreateThread(function ()
        local sleep = Options.majeffectstick or 600000
        local strengthptvalue = 0
        local strengthmodifier = 1.0
        local runptvalue = 0
        local runmodifier = 1.0
        local staminaptvalue = 0
        local staminamodifier = 100
        local swimptvalue = 0
        local swimmodifier = 1.0
        while true do
            if datasp then
                if datasp.strength > 0 then
                    strengthptvalue = (2.0 - 1.0) / Options["strength"].levels.lvl5
                    strengthmodifier = 1 + (datasp.strength * strengthptvalue)
                end
                if datasp.run > 0 then
                    runptvalue = (1.49 - 1.0) / Options["run"].levels.lvl5
                    runmodifier = 1 + (datasp.run * runptvalue)
                end
                if datasp.cardio > 0 then
                    staminaptvalue = (200 - 100) / Options["cardio"].levels.lvl5
                    staminamodifier = 100 + (datasp.cardio * staminaptvalue)
                end
                if datasp.swim > 0 then
                    swimptvalue = (1.49 - 1.0) / Options["swim"].levels.lvl5
                    swimmodifier = 1 + (datasp.swim * swimptvalue)
                end
                SetWeaponDamageModifier("WEAPON_UNARMED", strengthmodifier)
                SetRunSprintMultiplierForPlayer(PlayerPedId(),runmodifier)
                SetPlayerStamina(PlayerPedId(),staminamodifier)
                SetSwimMultiplierForPlayer(PlayerPedId(), swimmodifier)

                if Options.debug == true then
                    print('datasp : '..json.encode(datasp))
                end

                Wait(sleep)
            end 
        end
    end)
end)

---------------------------------------------------------------
--- strength
---------------------------------------------------------------

RegisterNetEvent("cdtsports:startloopstrength")
AddEventHandler("cdtsports:startloopstrength", function ()
    Citizen.CreateThread(function ()
        local sleep = Options["strength"].tick or 1000
        local inanim = false
        local inaction = false

        while true do
            inanim = false
            inaction = false
            if Options["strength"].anims and #Options["strength"].anims > 0 then
                for i = 1, #Options["strength"].anims do
                    if IsEntityPlayingAnim(PlayerPedId(), Options["strength"].anims[i].dict, Options["strength"].anims[i].anim, 3) then
                        if datasp.strength <= Options["strength"].levels.lvl5 then
                            datasp.strength = datasp.strength + Options["strength"].anims[i].add
                            inanim = true
                            if Options.debug then
                                print("strength : "..datasp.strength) 
                            end 
                        end
                    end
                end 
            end

            if Options["strength"].fight.value == true then
                local inmeleecombat = IsPedInMeleeCombat(PlayerPedId())
                local target = GetMeleeTargetForPed(PlayerPedId())
                if inmeleecombat then
                    if DoesEntityExist(target) and GetEntityHealth(target) > 0 then
                        if datasp.strength <= Options["strength"].levels.lvl5 then
                            datasp.strength = datasp.strength + Options["strength"].fight.add
                            inaction = true
                            if Options.debug then
                                print("strength : "..datasp.strength) 
                            end 
                        end
                    end
                end
            end

            if Options["strength"].run.value == true then
                if IsPedRunning(PlayerPedId()) then
                    if datasp.strength <= Options["strength"].levels.lvl5 then
                        datasp.strength = datasp.strength + Options["strength"].run.add
                        inaction = true
                        if Options.debug then
                            print("strength : "..datasp.strength) 
                        end 
                    end
                end
            end

            if Options["strength"].swim.value == true then
                if IsPedSwimming(PlayerPedId()) then
                    if datasp.strength <= Options["strength"].levels.lvl5 then
                        datasp.strength = datasp.strength + Options["strength"].swim.add
                        inaction = true
                        if Options.debug then
                            print("strength : "..datasp.strength) 
                        end 
                    end
                end
            end

            if Options["strength"].climb.value == true then
                if IsPedClimbing(PlayerPedId()) then
                    if datasp.strength <= Options["strength"].levels.lvl5 then
                        datasp.strength = datasp.strength + Options["strength"].climb.add
                        inaction = true
                        if Options.debug then
                            print("strength : "..datasp.strength) 
                        end 
                    end
                end
            end

            if Options["strength"].bike.value == true then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle and vehicle > 0 then
                    local classveh = GetVehicleClass(vehicle)
                    if classveh == 13 and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        if GetEntitySpeed(vehicle) > 0.2 then
                            if datasp.strength <= Options["strength"].levels.lvl5 then
                                datasp.strength = datasp.strength + Options["strength"].bike.add
                                inaction = true
                                if Options.debug then
                                    print("strength : "..datasp.strength) 
                                end 
                            end 
                        end
                    end
                end
            end

            if not inanim and not inaction then
                if datasp.strength >= Options["strength"].minus then
                    datasp.strength = datasp.strength - Options["strength"].minus 
                end
            end

            Wait(sleep)
        end
    end)
end)

---------------------------------------------------------------
--- running
---------------------------------------------------------------

RegisterNetEvent("cdtsports:startlooprun")
AddEventHandler("cdtsports:startlooprun", function ()
    Citizen.CreateThread(function ()
        local sleep = Options["run"].tick or 1000
        local inanim = false
        local inaction = false

        while true do
            inanim = false
            inaction = false
            if Options["run"].anims and #Options["run"].anims > 0 then
                for i = 1, #Options["run"].anims do
                    if IsEntityPlayingAnim(PlayerPedId(), Options["run"].anims[i].dict, Options["run"].anims[i].anim, 3) then
                        if datasp.run <= Options["run"].levels.lvl5 then
                            datasp.run = datasp.run + Options["run"].anims[i].add
                            inanim = true
                            if Options.debug then
                                print("run : "..datasp.run) 
                            end 
                        end
                    end
                end 
            end

            if Options["run"].fight.value == true then
                local inmeleecombat = IsPedInMeleeCombat(PlayerPedId())
                local target = GetMeleeTargetForPed(PlayerPedId())
                if inmeleecombat then
                    if DoesEntityExist(target) and GetEntityHealth(target) > 0 then
                        if datasp.run <= Options["run"].levels.lvl5 then
                            datasp.run = datasp.run + Options["run"].fight.add
                            inaction = true
                            if Options.debug then
                                print("run : "..datasp.run) 
                            end 
                        end
                    end
                end
            end

            if Options["run"].run.value == true then
                if IsPedRunning(PlayerPedId()) then
                    if datasp.run <= Options["run"].levels.lvl5 then
                        datasp.run = datasp.run + Options["run"].run.add
                        inaction = true
                        if Options.debug then
                            print("run : "..datasp.run) 
                        end 
                    end
                end
            end

            if Options["run"].swim.value == true then
                if IsPedSwimming(PlayerPedId()) then
                    if datasp.run <= Options["run"].levels.lvl5 then
                        datasp.run = datasp.run + Options["run"].swim.add
                        inaction = true
                        if Options.debug then
                            print("run : "..datasp.run) 
                        end 
                    end
                end
            end

            if Options["run"].climb.value == true then
                if IsPedClimbing(PlayerPedId()) then
                    if datasp.run <= Options["run"].levels.lvl5 then
                        datasp.run = datasp.run + Options["run"].climb.add
                        inaction = true
                        if Options.debug then
                            print("run : "..datasp.run) 
                        end 
                    end
                end
            end

            if Options["run"].bike.value == true then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle and vehicle > 0 then
                    local classveh = GetVehicleClass(vehicle)
                    if classveh == 13 and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        if GetEntitySpeed(vehicle) > 0.2 then
                            if datasp.run <= Options["run"].levels.lvl5 then
                                datasp.run = datasp.run + Options["run"].bike.add
                                inaction = true
                                if Options.debug then
                                    print("run : "..datasp.run) 
                                end 
                            end 
                        end
                    end
                end
            end

            if not inanim and not inaction then
                if datasp.run >= Options["run"].minus then
                    datasp.run = datasp.run - Options["run"].minus 
                end
            end

            Wait(sleep)
        end
    end)
end)

---------------------------------------------------------------
--- swimming
---------------------------------------------------------------

RegisterNetEvent("cdtsports:startloopswim")
AddEventHandler("cdtsports:startloopswim", function ()
    Citizen.CreateThread(function ()
        local sleep = Options["swim"].tick or 1000
        local inanim = false
        local inaction = false

        while true do
            inanim = false
            inaction = false
            if Options["swim"].anims and #Options["swim"].anims > 0 then
                for i = 1, #Options["swim"].anims do
                    if IsEntityPlayingAnim(PlayerPedId(), Options["swim"].anims[i].dict, Options["swim"].anims[i].anim, 3) then
                        if datasp.swim <= Options["swim"].levels.lvl5 then
                            datasp.swim = datasp.swim + Options["swim"].anims[i].add
                            inanim = true
                            if Options.debug then
                                print("swim : "..datasp.swim) 
                            end 
                        end
                    end
                end 
            end

            if Options["swim"].fight.value == true then
                local inmeleecombat = IsPedInMeleeCombat(PlayerPedId())
                local target = GetMeleeTargetForPed(PlayerPedId())
                if inmeleecombat then
                    if DoesEntityExist(target) and GetEntityHealth(target) > 0 then
                        if datasp.swim <= Options["swim"].levels.lvl5 then
                            datasp.swim = datasp.run + Options["swim"].fight.add
                            inaction = true
                            if Options.debug then
                                print("swim : "..datasp.run) 
                            end 
                        end
                    end
                end
            end

            if Options["swim"].run.value == true then
                if IsPedRunning(PlayerPedId()) then
                    if datasp.swim <= Options["swim"].levels.lvl5 then
                        datasp.swim = datasp.swim + Options["swim"].run.add
                        inaction = true
                        if Options.debug then
                            print("swim : "..datasp.swim) 
                        end 
                    end
                end
            end

            if Options["swim"].swim.value == true then
                if IsPedSwimming(PlayerPedId()) then
                    if datasp.swim <= Options["swim"].levels.lvl5 then
                        datasp.swim = datasp.swim + Options["swim"].swim.add
                        inaction = true
                        if Options.debug then
                            print("swim : "..datasp.swim) 
                        end 
                    end
                end
            end

            if Options["swim"].climb.value == true then
                if IsPedClimbing(PlayerPedId()) then
                    if datasp.swim <= Options["swim"].levels.lvl5 then
                        datasp.swim = datasp.swim + Options["swim"].climb.add
                        inaction = true
                        if Options.debug then
                            print("swim : "..datasp.swim) 
                        end 
                    end
                end
            end

            if Options["swim"].bike.value == true then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle and vehicle > 0 then
                    local classveh = GetVehicleClass(vehicle)
                    if classveh == 13 and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        if GetEntitySpeed(vehicle) > 0.2 then
                            if datasp.swim <= Options["swim"].levels.lvl5 then
                                datasp.swim = datasp.swim + Options["swim"].bike.add
                                inaction = true
                                if Options.debug then
                                    print("swim : "..datasp.swim) 
                                end 
                            end 
                        end
                    end
                end
            end


            if not inanim and not inaction then
                if datasp.swim >= Options["swim"].minus then
                    datasp.swim = datasp.swim - Options["swim"].minus 
                end
            end

            Wait(sleep)
        end
    end)
end)

---------------------------------------------------------------
--- cardio
---------------------------------------------------------------

RegisterNetEvent("cdtsports:startloopcardio")
AddEventHandler("cdtsports:startloopcardio", function ()
    Citizen.CreateThread(function ()
        local sleep = Options["cardio"].tick or 1000
        local inanim = false
        local inaction = false

        while true do
            inanim = false
            inaction = false
            if Options["cardio"].anims and #Options["cardio"].anims > 0 then
                for i = 1, #Options["cardio"].anims do
                    if IsEntityPlayingAnim(PlayerPedId(), Options["cardio"].anims[i].dict, Options["cardio"].anims[i].anim, 3) then
                        if datasp.cardio <= Options["cardio"].levels.lvl5 then
                            datasp.cardio = datasp.cardio + Options["cardio"].anims[i].add
                            inanim = true
                            if Options.debug then
                                print("cardio : "..datasp.cardio) 
                            end 
                        end
                    end
                end 
            end

            if Options["cardio"].fight.value == true then
                local inmeleecombat = IsPedInMeleeCombat(PlayerPedId())
                local target = GetMeleeTargetForPed(PlayerPedId())
                if inmeleecombat then
                    if DoesEntityExist(target) and GetEntityHealth(target) > 0 then
                        if datasp.cardio <= Options["cardio"].levels.lvl5 then
                            datasp.cardio = datasp.cardio + Options["cardio"].fight.add
                            inaction = true
                            if Options.debug then
                                print("cardio : "..datasp.cardio) 
                            end 
                        end
                    end
                end
            end

            if Options["cardio"].run.value == true then
                if IsPedRunning(PlayerPedId()) then
                    if datasp.cardio <= Options["cardio"].levels.lvl5 then
                        datasp.cardio = datasp.cardio + Options["cardio"].run.add
                        inaction = true
                        if Options.debug then
                            print("cardio : "..datasp.cardio) 
                        end 
                    end
                end
            end

            if Options["cardio"].swim.value == true then
                if IsPedSwimming(PlayerPedId()) then
                    if datasp.cardio <= Options["cardio"].levels.lvl5 then
                        datasp.cardio = datasp.cardio + Options["cardio"].swim.add
                        inaction = true
                        if Options.debug then
                            print("cardio : "..datasp.cardio) 
                        end 
                    end
                end
            end

            if Options["cardio"].climb.value == true then
                if IsPedClimbing(PlayerPedId()) then
                    if datasp.cardio <= Options["cardio"].levels.lvl5 then
                        datasp.cardio = datasp.cardio + Options["cardio"].climb.add
                        inaction = true
                        if Options.debug then
                            print("cardio : "..datasp.cardio) 
                        end 
                    end
                end
            end

            if Options["cardio"].bike.value == true then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle and vehicle > 0 then
                    local classveh = GetVehicleClass(vehicle)
                    if classveh == 13 and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        if GetEntitySpeed(vehicle) > 0.2 then
                            if datasp.cardio <= Options["cardio"].levels.lvl5 then
                                datasp.cardio = datasp.cardio + Options["cardio"].bike.add
                                inaction = true
                                if Options.debug then
                                    print("cardio : "..datasp.cardio) 
                                end 
                            end 
                        end
                    end
                end
            end

            if not inanim and not inaction then
                if datasp.cardio >= Options["cardio"].minus then
                    datasp.cardio = datasp.cardio - Options["cardio"].minus 
                end
            end

            Wait(sleep)
        end
    end)
end)