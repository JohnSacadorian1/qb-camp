local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
Shops = {}
local TentPlaced = false
local TentPickedUp = true

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.TentModel, {
        options = {
            {
                type = "client",
                event = "qb-camp:PickupTent",
                icon = "fas fa-hand",
                label = "Pickup Tent",
            },
        },
        distance = 2.5
    })
end)


RegisterNetEvent("qb-camp:shop")
AddEventHandler("qb-camp:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Tent Shop", Config.TentShop)
end)


RegisterNetEvent('qb-camp:StartConvo', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| John |",
            txt = "Hey Man hows it going?",
            isMenuHeader = true, 
        },
        {
            
            header = "Im feeling good, Thank you",
            txt = "",
            params = {
                event = "qb-camp:FeelingGood"
            }
        },
        {
            
            header = "Im not having a good day today",
            txt = "",
            params = {
                event = "qb-camp:FeelingBad"
            }
        },
    })
end)

RegisterNetEvent('qb-camp:FeelingGood', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| That is Great to hear Friend, you looking to buy a nice Tent? |",
            isMenuHeader = true, 
        },
        {
            
            header = "Yea i would love to browse your stuff",
            txt = "$ Buy $",
            params = {
                event = "qb-camp:shop"
            }
        },
        {
            
            header = "No thank you, ill be going now",
            txt = "",
            params = {
            
            }
        },
    })
end)

RegisterNetEvent('qb-camp:FeelingBad', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| Oh No that is a shame, can i interest you in a nice Tent? |",
            isMenuHeader = true, 
        },
        {
            
            header = "Sure, i guess so...",
            txt = "$ Buy $",
            params = {
                event = "qb-camp:shop"
            }
        },
        {
            
            header = "No thank you, ill be going now",
            txt = "",
            params = {
        
            }
        },
    })
end)


Citizen.CreateThread(function()
    exports['qb-target']:SpawnPed({
        model = Config.BuyPed,
        coords = Config.BuyLocation, 
        minusOne = true, --may have to change this if your ped is in the ground
        freeze = true, 
        invincible = true, 
        blockevents = true,
        scenario = 'WORLD_HUMAN_DRUG_DEALER',
        target = { 
            options = {
                {
                    type="client",
                    event = "qb-camp:StartConvo",
                    icon = "fas fa-smile",
                    label = "Greet"
                }
            },
          distance = 2.5,
        },
    })
end)

------/////////NEW PROP SHOPS///////-------
RegisterNetEvent("qb-camp:propshop")
AddEventHandler("qb-camp:propshop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Home Grillin", Config.PropShop)
end)

Shops.Draw3DText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    
    SetTextScale(0.38, 0.38)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	for i = 1, #Config.PropShopLoc do
		local blip = AddBlipForCoord(Config.PropShopLoc[i])

		SetBlipSprite(blip, 541)
		SetBlipScale(blip, 0.5)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Home Grillin')
		EndTextCommandSetBlipName(blip)	
	end

	while true do
		local player, sleepThread = PlayerPedId(), 750;

		for i = 1, #Config.PropShopLoc do
			local dst = #(GetEntityCoords(player) - Config.PropShopLoc[i]);

			if dst < 2.5 then
				Shops.Draw3DText(Config.PropShopLoc[i], '[~g~E~w~] Home Grillin');  --words you see when near shop
				sleepThread = 5;

				if dst < 1.5 then
					if IsControlJustReleased(0, 38) then
						TriggerEvent('qb-camp:propshop')
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
    meatguy = AddBlipForCoord(Config.BuyLocation)
    SetBlipSprite (meatguy, 671)
    SetBlipDisplay(meatguy, 4)
    SetBlipScale  (meatguy, 0.4)
    SetBlipAsShortRange(meatguy, true)
    SetBlipColour(meatguy, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Camping Supplies")
    EndTextCommandSetBlipName(meatguy)
end) 


----/////Tent 1 //////-----------

RegisterNetEvent("qb-camp:PlaceTent")
AddEventHandler("qb-camp:PlaceTent", function()
    if not TentPlaced then
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.5)

    local tent = `prop_skid_tent_01`
    RequestModel(tent)
    while (not HasModelLoaded(tent)) do
        Wait(1)
    end
     tentprop1 = CreateObject(tent, x, y, z-1.9, true, false, true)
    PlaceObjectOnGroundProperly(tent)
    SetEntityAsMissionEntity(tent)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'Setting Up Tent...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TentPlaced = true
        TentPickedUp = false

        --DeleteEntity(prop1)

        TriggerServerEvent('qb-camp:server:RemoveTent')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['tent'], "remove")
    end)
end
end)

RegisterNetEvent('qb-camp:PickupTent')
AddEventHandler('qb-camp:PickupTent', function()
    if not TentPickedUp and TentPlaced then
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
        QBCore.Functions.Progressbar('pick', 'Picking Up Tent', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent("qb-camp:server:PickupTent")
            Wait(200)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            DeleteEntity(tentprop1)
        QBCore.Functions.Notify('You Picked Up Your Tent', 'primary', 7500)
        TentPlaced = false
        TentPickedUp = true
        end, function()
        QBCore.Functions.Notify('Cancelled', 'error', 7500)
        TentPlaced = false
        TentPickedUp = true
        end)
     end
end)