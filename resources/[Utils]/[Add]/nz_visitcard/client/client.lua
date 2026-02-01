ESX = exports["framework"]:getSharedObject()

local open = false
local mainMenu = RageUI.CreateMenu('Carte de Visite', 'Création')
local cardUrl, cardName, cardDesc, cardNumber, cardWidth, cardHeight, cardImageRight = nil, nil, nil, nil, nil, nil, nil
local menuDescription = "Créer votre carte de visite"

exports('openVisitCardCreator', function(caca)  
    if open then
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true
        RageUI.Visible(mainMenu, true)

        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function() 
                    RageUI.Button('URL de l\'image', menuDescription, { RightLabel = cardImageRight or ">>>" }, true, {
                        onSelected = function()
                            cardUrl = exports['ava']:ShowInput('Entrez l\'URL de l\'image', true, 999999, 'text', '', false, 'top-right')
                            cardImageRight = (string.len(cardUrl) > 30) and (string.sub(cardUrl, 1, 30) .. "...") or cardUrl
                        end
                    }) 

                    RageUI.Button('Nom de carte', menuDescription, { RightLabel = cardName or ">>>" }, true, {
                        onSelected = function()
                            cardName = exports['ava']:ShowInput('Entrez le nom', true, 100, 'small_text', '', false, 'top-right')
                        end
                    }) 

                    RageUI.Button('Description de carte', menuDescription, { RightLabel = cardDesc or ">>>" }, true, {
                        onSelected = function()
                            cardDesc = exports['ava']:ShowInput('Entrez la description', true, 100, 'text', '', false, 'top-right')
                        end
                    }) 

                    RageUI.Button('Numéro de carte', menuDescription, { RightLabel = cardNumber or ">>>" }, true, {
                        onSelected = function()
                            cardNumber = exports['ava']:ShowInput('Entrez le numéro', true, 100, 'small_text', '', false, 'top-right')
                        end
                    }) 

                    RageUI.Button('Largeur de carte', menuDescription, { RightLabel = (cardWidth and (cardWidth..'%') or ">>>") }, true, {
                        onSelected = function()
                            cardWidth = exports['ava']:ShowInput('Entrez la largeur (%)', true, 100, 'number', '', false, 'top-right')
                        end
                    }) 

                    RageUI.Button('Hauteur de carte', menuDescription, { RightLabel = (cardHeight and (cardHeight..'%') or ">>>") }, true, {
                        onSelected = function()
                            cardHeight = exports['ava']:ShowInput('Entrez la hauteur (%)', true, 100, 'number', '', false, 'top-right')
                        end
                    }) 

                    RageUI.Separator('Créer la carte')

                    RageUI.Button('~g~ Visualiser la carte', menuDescription, { RightLabel = ">>>" }, true, {
                        onSelected = function()
                            local data = {
                                action = "open", 
                                name = cardName, 
                                description = cardDesc, 
                                number = cardNumber, 
                                image = cardUrl,
                                width = cardWidth, 
                                height = cardHeight,
                                blur = false, 
                                tilt = false 
                            }
                            TriggerEvent('nz:card:show', data)
                        end
                    }) 

                    RageUI.Button('Créer la carte', menuDescription, { RightLabel = ">>>" }, true, {
                        onSelected = function()
                            if not cardUrl or cardUrl == "" then
                                ESX.ShowNotification("~r~Veuillez entrer une URL d'image avant de créer la carte !")
                                return
                            end
                    
                            local data = {
                                action = "open", 
                                name = cardName, 
                                description = cardDesc, 
                                number = cardNumber, 
                                image = cardUrl,
                                width = cardWidth, 
                                height = cardHeight,
                                blur = false, 
                                tilt = false 
                            } 
                    
                            TriggerServerEvent('nz:giveVisitCard', data)
                    
                            if caca then 
                                TriggerServerEvent('nz:delEmptyCard')
                            end
                        end
                    })                      

                end)

                Wait(0)
            end
        end)
    end
end)

RegisterCommand("visitcard", function()
    exports["nz_visitcard"]:openVisitCardCreator(false)
end, false)  

RegisterNetEvent('nz_visitcard:useVisitCard', function(metadata)
    TriggerServerEvent('nz:server:useVisitCard', metadata, 3)   
end)
