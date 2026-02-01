for k, v in ipairs(Config.Chest) do
    lib.points.new({
        coords = v.Coords,
        distance = 3,
        
        nearby = function(self)
            -- Marker
            DrawMarker(6, v.Coords.x, v.Coords.y, v.Coords.z - 1.0, -- ↙️ Z -1.0 pour bien coller au sol
            0.0, 0.0, 0.0, 
            270.0, 0.0, 0.0, 
            0.5, 0.5, 0.5, 
            v.MarkerColor.R, v.MarkerColor.G, v.MarkerColor.B, 150, 
            false, true, 2, false, false, false, false)


            if self.currentDistance < 2 then
                -- Texte natif GTA style
                BeginTextCommandDisplayHelp("STRING")
                AddTextComponentSubstringPlayerName("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre : " .. v.Label)
                EndTextCommandDisplayHelp(0, false, false, -1)

                if IsControlJustReleased(0, 38) then -- Touche E
                    local hasItem = true
                    local hasJob = true

                    if v.Item.ItemRequis then
                        local count = exports.ox_inventory:Search('count', v.Item.ItemName)
                        hasItem = count and count > 0
                    end

                    if v.Job.JobRequis then
                        hasJob = ESX.PlayerData and ESX.PlayerData.job.name == v.Job.JobName
                    end

                    if hasItem and hasJob then
                        exports.ox_inventory:openInventory('stash', { id = v.Name })
                    else
                        exports['fb_ui']:addNotification(nil, nil, nil, "Erreur", "Action impossible...", 5000)
                    end
                end
            end
        end
    })
end
