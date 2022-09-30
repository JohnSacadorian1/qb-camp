Config = {}


Config.TentModel = {
    -596943609,
}

--tent you get back
Config.TentAmount = 1 --Tent


--buying tent
Config.BuyPed = 'a_m_m_hillbilly_01'
Config.BuyLocation = vector4(2746.5313, 3467.9224, 55.6760, 277.0664)  --must be vector 4 not 3  -- blip will follow this guy too


Config.TentShop = {
    label = "Tent Shop",
        slots = 1,  --make sure this number is the same as the amount of items you have in this list or it wont work
        items = {
            [1] = {
                name = "tent",
                price = 45,
                amount = 12,
                info = {},
                type = "item",
                slot = 1,
            },
        }
    }

    Config.PropShopLoc = {  --add as many prop stores as you like
    vector3(53.35, -1480.2, 29.27),
    vector3(1893.2, 3714.28, 32.77),
}