function startmihra(atm)
    TriggerEvent("open:minigame", 4, 2, 2, function(outcome, reason)
        if outcome == true then 
            TriggerServerEvent('nb_atmrob:server:getcash', true, atm)
        elseif outcome == false then
            TriggerServerEvent('nb_atmrob:server:getcash', false, atm)
        end
    end)
end
