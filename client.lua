-- Register the event to send a notification to the frontend
RegisterNetEvent('noxen:notify')
AddEventHandler('noxen:notify', function(title, message, type, time)
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

-- Command to test the notification system
if Config.CommandTest then
    RegisterCommand("notify", function(source, args)
        local title = args[1] or "Notification"
        local message = args[2] or "Message"
        local type = args[3] or "info"
        local time = args[4] or 20000
        TriggerEvent('noxen:notify', title, message, type, time)
    end, false)
end

--Add fonction initalisation Config LUA
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