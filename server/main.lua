local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("tent", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-camp:PlaceTent", src, item.name)
    end
end)

RegisterNetEvent('qb-camp:server:RemoveTent', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('tent', 1)
end)

RegisterNetEvent('qb-camp:server:PickupTent', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('tent', 1)
end)