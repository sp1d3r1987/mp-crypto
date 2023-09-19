local QBCore = exports['qb-core']:GetCoreObject()

-- Events

RegisterServerEvent('mp-crypto:ExchangeFail', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if Config.Inventory.QB then
        if Player.Functions.GetItemByName("cryptostick") then
            Player.Functions.RemoveItem("cryptostick", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "remove")
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.cryptostick_malfunctioned'), 'error')
        end
    elseif Config.Inventory.Ox then
        local cryptostick = exports.ox_inventory:GetItem(src, 'cryptostick', nil, false)
        if cryptostick then
            exports.ox_inventory:RemoveItem(src, 'cryptostick', 1)
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.cryptostick_malfunctioned'), 'error')
        end
    end
end)

RegisterServerEvent('mp-crypto:Rebooting', function(state, percentage)
    Config.Exchange.RebootInfo.state = state
    Config.Exchange.RebootInfo.percentage = percentage
end)

RegisterServerEvent('mp-crypto:GetRebootState', function()
    local src = source
    TriggerClientEvent('mp-crypto:GetRebootState', src, Config.Exchange.RebootInfo)
end)

RegisterServerEvent('mp-crypto:ExchangeSuccess', function(LuckChance)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(1, 25)

    if not Player then return end

    if Config.Inventory.QB then
        if Player.Functions.GetItemByName("cryptostick") then
            Player.Functions.RemoveItem("cryptostick", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "remove")
        end
    elseif Config.Inventory.Ox then
        local cryptostick = exports.ox_inventory:GetItem(src, 'cryptostick', nil, false)
        if cryptostick then
            exports.ox_inventory:RemoveItem(src, 'cryptostick', 1)
        end
    end

    if Config.Crypto.Renewed then
        local luck = math.random(0,100)
        if luck <= 30 then
            exports['qb-phone']:AddCrypto(src, "gne", amount)
            TriggerClientEvent('qb-phone:client:CustomNotification', src,
                "CRYPTOMINER",
                Lang:t('success.you_have_exchanged_your_cryptostick_for_gne',{amount = amount}),
                "fas fa-coins",
                "#FFFFFF",
                7500
            )
            elseif luck > 30 and luck <= 37 then
                exports['qb-phone']:AddCrypto(src, "shung", amount)
                TriggerClientEvent('qb-phone:client:CustomNotification', src,
                    "CRYPTOMINER",
                    Lang:t('success.you_have_exchanged_your_cryptostick_for_shung',{amount = amount}),
                    "fas fa-coins",
                    "#FFFFFF",
                    7500
                )
            elseif luck > 37 and luck <= 82 then
                exports['qb-phone']:AddCrypto(src, "lme", amount)
                TriggerClientEvent('qb-phone:client:CustomNotification', src,
                    "CRYPTOMINER",
                    Lang:t('success.you_have_exchanged_your_cryptostick_for_lme',{amount = amount}),
                    "fas fa-coins",
                    "#FFFFFF",
                    7500
                )
            elseif luck > 82 and luck <= 100 then
                exports['qb-phone']:AddCrypto(src, "xcoin", amount)
                TriggerClientEvent('qb-phone:client:CustomNotification', src,
                    "CRYPTOMINER",
                    Lang:t('success.you_have_exchanged_your_cryptostick_for_xcoin',{amount = amount}),
                    "fas fa-coins",
                    "#FFFFFF",
                    7500
                )
        end
    elseif Config.Crypto.QBCore then
        Player.Functions.AddMoney('crypto', amount, 'crypto-exchange')
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.you_have_exchanged_your_cryptostick_for',{amount = amount}), "success", 3500)
    end
end)
