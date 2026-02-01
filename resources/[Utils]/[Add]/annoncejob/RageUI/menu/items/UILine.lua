local SettingsButton = {     
    Rectangle = { Y = 0, Width = 431, Height = 40 },
    Text = { X = 8, Y = 10, Scale = 0.30 },
    SelectedSprite = { Dictionary = "RageUI_", Texture = "custom_background", Y = 5, Width = 431, Height = 38 },
}

function RageUI.Line()
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                local base = (CurrentMenu.WidthOffset ~= 0) and (CurrentMenu.WidthOffset * 2.5) or 200
                RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X + base - 150 + 8, CurrentMenu.Y + RageUI.ItemOffset + 25, 300, 3, false, 255,255,255, 220)

          
          
          
          
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end