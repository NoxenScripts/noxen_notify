RegisterNetEvent('noxen:notify')
AddEventHandler('noxen:notify', function(title, message, type, time)
    -- Envoie les informations au NUI pour les afficher dans l'interface HTML
    local title = title or "Notification"
    local message = message or "Message"
    local type = type or "info"
    local time = time or 5000
    SendNUIMessage({
        action = "notification",
        title = title,
        message = message,
        type = type,
        time = time
    })
end)


RegisterCommand("notify", function(source, args)
    local title = args[1] or "Notification"
    local message = args[2] or "Message"
    local type = args[3] or "info"
    local time = args[4] or 20000
    TriggerEvent('noxen:notify', title, message, type, time)
end, false)

function SendConfigToFrontEnd()
    SendNUIMessage({
        action = "setConfig",
        defaultPosition = Config.Position
    })
end


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(500)
    SendConfigToFrontEnd()
end)