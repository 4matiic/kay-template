exports('OpenColorMenu', function()
    local vehicle = cache.vehicle

    lib.registerContext({
        id = 'colorMenu',
        title = "Couleur",
        menu = "colorMenu",
        options = {
            {
                title = "Couleur primaire",
                icon = 'droplet',
                iconColor = "rgba(99, 0, 13, 1.0)",
                onSelect = function()
                    local input = lib.inputDialog("Sélectionner une couleur", {
                        { type = 'color', label = "Color input", format = "rgb" },
                        {
                            type = 'select',
                            label = "Color type",
                            default = "0",
                            clearable = true,
                            options = {
                                { value = "0", label = "Normal" },
                                { value = "1", label = "Metalic" },
                                { value = "2", label = "Pearl" },
                                { value = "3", label = "Matte" },
                                { value = "4", label = "Metal" },
                                { value = "5", label = "Chrome" },
                            }
                        },
                    })

                    if not input then
                        openColorMenu()
                        return
                    end

                    local color = input[1] or "rgb(255,255,255)"
                    local type = tonumber(input[2])


                    local r, g, b = string.match(color, "rgb%((%d+), (%d+), (%d+)%)")

                    r = tonumber(r)
                    g = tonumber(g)
                    b = tonumber(b)

                    lib.setVehicleProperties(vehicle, { color1 = { r, g, b } })

                    SetVehicleModColor_1(vehicle, type, 0)
                    openColorMenu()

                    local newModData = {
                        modLabel = "Couleur primaire",
                        modType = "color1",
                        modLevel = "rgb (" .. math.floor(r) .. " " .. math.floor(g) .. " " .. math.floor(b) .. ")",
                    }

                    local foundMatch = false
                    for i, existingModData in ipairs(cart) do
                        if existingModData.modType == "color1" then
                            cart[i] = newModData
                            foundMatch = true
                            break
                        end
                    end

                    if not foundMatch then
                        table.insert(cart, newModData)
                    end

                    currentVehProperties.new = getVehicleProperties(vehicle)


                    lib.hideTextUI()
                    showVehicleStats()
                end,
            },
            {
                title = "Couleur secondaire",
                icon = 'droplet',
                iconColor = "rgba(244, 196, 48, 1.0)",
                onSelect = function()
                    local input = lib.inputDialog("Sélectionner une couleur", {
                        { type = 'color', label = "Color input", format = "rgb" },
                        {
                            type = 'select',
                            label = "Color type",
                            default = "0",
                            clearable = true,
                            options = {
                                { value = "0", label = "Normal" },
                                { value = "1", label = "Metalic" },
                                { value = "2", label = "Pearl" },
                                { value = "3", label = "Matte" },
                                { value = "4", label = "Metal" },
                                { value = "5", label = "Chrome" },
                            }
                        },
                    })


                    if not input then
                        openColorMenu()
                        return
                    end

                    local color = input[1] or "rgb(255,255,255)"
                    local type = tonumber(input[2])

                    local r, g, b = string.match(color, "rgb%((%d+), (%d+), (%d+)%)")
                    r = tonumber(r)
                    g = tonumber(g)
                    b = tonumber(b)

                    lib.setVehicleProperties(vehicle, { color2 = { r, g, b } })
                    SetVehicleModColor_2(vehicle, type, 0)
                    openColorMenu()

                    local newModData = {
                        modLabel = "Couleur secondaire",
                        modType = "color2",
                        modLevel = "rgb (" .. math.floor(r) .. " " .. math.floor(g) .. " " .. math.floor(b) .. ")",
                    }

                    local foundMatch = false
                    for i, existingModData in ipairs(cart) do
                        if existingModData.modType == "color2" then
                            cart[i] = newModData
                            foundMatch = true
                            break
                        end
                    end

                    if not foundMatch then
                        table.insert(cart, newModData)
                    end

                    currentVehProperties.new = getVehicleProperties(vehicle)


                end,
            },
            {
                title = "Couleur pearlescent",
                icon = 'droplet',
                iconColor = "rgba(236, 88, 0, 1.0)",
                onSelect = function()
                   exports["ars_tuning"]:OpenPearlescentMenu()
                end,
            },
        }
    })
    lib.showContext('colorMenu')
end)