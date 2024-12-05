local datasplayers = {}

RegisterNetEvent("cdtsports:preparedatas")
AddEventHandler("cdtsports:preparedatas", function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    if xPlayer then
        if identifier then
            local datap = MySQL.prepare.await('SELECT * FROM `sports` WHERE `identifier` = ?', {
                identifier
            })
            if datap then                
                datasplayers[identifier] = {
                    strength = datap.strength,
                    cardio = datap.cardio,
                    run = datap.run,
                    swim = datap.swim
                }
                if Options.debug then
                    print("^3[cdt-sports]^2[debug] -^7 identifier ^2"..identifier.."^7 - data - ^2"..json.encode(datap).."^7")
                    print("^3[cdt-sports]^2[debug] -^7 identifier ^2"..identifier.."^7 - datasplayers[identifier] - ^2"..json.encode(datasplayers[identifier]).."^7")
                    print("^3[cdt-sports]^2[send datas to client] -^7 identifier ^2"..identifier.."^7 - id - ^2"..xPlayer.source.."^7")                    
                end
                TriggerClientEvent("cdtsports:getdatas", xPlayer.source, datasplayers[identifier])
            else
                local strgth = 0
                local card = 0
                local sw = 0
                local run = 0
                datasplayers[identifier] = {}
                local addrow = MySQL.insert.await('INSERT INTO `sports` (identifier,strength,cardio,run,swim) VALUES (?, ?, ?, ?, ?)', {
                    identifier, strgth, card, run, sw
                })
                Wait(800)
                local datap = MySQL.prepare.await('SELECT * FROM `sports` WHERE `identifier` = ?', {
                    identifier
                })
                if datap then
                    datasplayers[identifier] = {
                        strength = datap.strength,
                        cardio = datap.cardio,
                        run = datap.run,
                        swim = datap.swim
                    }
                    if Options.debug then
                        print("^3[cdt-sports]^2[add row] -^7 identifier ^2"..identifier.."^7 - debug - ^2"..addrow.."^7")
                        print("^3[cdt-sports]^2[debug] -^7 identifier ^2"..identifier.."^7 - data - ^2"..json.encode(datap).."^7")
                        print("^3[cdt-sports]^2[debug] -^7 identifier ^2"..identifier.."^7 - datasplayers[identifier] - ^2"..json.encode(datasplayers[identifier]).."^7")
                        print("^3[cdt-sports]^2[send datas to client] -^7 identifier ^2"..identifier.."^7 - id - ^2"..xPlayer.source.."^7")                    
                    end  
                    TriggerClientEvent("cdtsports:getdatas", xPlayer.source, datasplayers[identifier])  
                else
                    local source = xPlayer.source or 0
                    print("^3[cdt-sports]^9[error] - ^2 No datasp -^7 Event:^9 cdtsports:preparedatas ^7-^9 source : ^7"..source)
                end                
            end
        else
            local source = xPlayer.source or 0
            print("^3[cdt-sports]^9[error] - ^2 No identifier -^7 Event:^9 cdtsports:preparedatas ^7-^9 source : ^7"..source)
        end
    else
        print("^3[cdt-sports]^9[error] - ^2 No xPlayer - ^7Event: ^9cdtsports:preparedatas^7")
    end
end)

RegisterNetEvent("cdtsports:majdatas")
AddEventHandler("cdtsports:majdatas", function (datasp)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    if xPlayer then
        if datasp then
            if Options.debug then
                print("^3[cdt-sports]^2[debug] -^7 datasp ^2"..json.encode(datasp).."^7")                
            end
            local strgth = tonumber(datasp.strength)
            local card = tonumber(datasp.cardio)
            local sw = tonumber(datasp.swim)
            local run = tonumber(datasp.run)
            if datasplayers[identifier] then
                local oldstrgth = datasplayers[identifier].strength
                local oldcard = datasplayers[identifier].cardio
                local oldrun = datasplayers[identifier].run
                local oldsw = datasplayers[identifier].swim
                if (strgth ~= oldstrgth) or (card ~= oldcard) or (run ~= oldrun) or (sw ~= oldsw) then
                    datasplayers[identifier].strength = strgth
                    datasplayers[identifier].cardio = card
                    datasplayers[identifier].run = run
                    datasplayers[identifier].swim = sw
                    local affectedRows = MySQL.update.await('UPDATE sports SET strength = ?, cardio = ?, run = ?, swim = ? WHERE identifier = ?', {
                        datasplayers[identifier].strength, datasplayers[identifier].cardio, datasplayers[identifier].run, datasplayers[identifier].swim, identifier
                    })
                    if Options.debug then
                        print("^3[cdt-sports]^2[maj row] -^7 identifier ^2"..identifier.."^7 - debug ^2"..affectedRows.."^7")
                        print("^3[cdt-sports]^2[debug] -^7 identifier ^2"..identifier.."^7 - data - ^2"..json.encode(datasplayers[identifier]).."^7")      
                    end
                end
            else
                local source = xPlayer.source or 0
                print("^3[cdt-sports]^9[error] - ^2 No datasplayers[identifier] -^7 Event:^9 cdtsports:majdatas ^7-^9 source : ^7"..source)
            end
        else
            local source = xPlayer.source or 0
            print("^3[cdt-sports]^9[error] - ^2 No datasp -^7 Event:^9 cdtsports:majdatas ^7-^9 source : ^7"..source)
        end
    else
        print("^3[cdt-sports]^9[error] - ^2 No xPlayer - ^7Event: ^9cdtsports:preparedatas^7")
    end
end)