-- Register the event to send a notification to the frontend
RegisterNetEvent('noxen:notify')
AddEventHandler('noxen:notify', function(title, message, type, time, playSound, image)
    local title = title or "Notification"
    local message = message or "Message"
    local type = type or "info"
    local time = time or 5000
    local playSound = playSound or false
    local image = image or false
    SendNUIMessage({
        action = "notification",
        title = title,
        message = message,
        type = type,
        time = time,
        playSound = playSound,
        image = image
    })
end)

-- Command to test the notification system
if Config.CommandTest then
    RegisterCommand("notify", function(source, args)
        local title = args[1] or "Notification"
        local message = args[2] or "Message"
        local type = args[3] or "info"
        local time = args[4] or 20000
        local playSound = args[5] or false
        local image = args[6] or false
        TriggerEvent('noxen:notify', title, message, type, time, playSound, image)
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