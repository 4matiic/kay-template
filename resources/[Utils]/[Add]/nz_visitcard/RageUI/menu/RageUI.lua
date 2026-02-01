RegisterFontFile('Poppins-Black')
fontId = RegisterFontId('Poppins-Black')


function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@class RageUIMenus
RageUI.Menus = setmetatable({}, RageUI.Menus)

---@type table
---@return boolean
RageUI.Menus.__call = function()
    return true
end

---@type table
RageUI.Menus.__index = RageUI.Menus

---@type table
RageUI.CurrentMenu = nil

---@type table
RageUI.NextMenu = nil

---@type number
RageUI.Options = 0

---@type number
RageUI.ItemOffset = 0

---@type number
RageUI.StatisticPanelCount = 0

---@class UISize
RageUI.UI = {
    Current = "NativeUI",
    Style = {
        RageUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@class Settings
RageUI.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "NativeUI",
        RageUI = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 420, Height = 100 },
            Text = { X = 225, Y = 17, Scale = 0.5 },
        },
        Subtitle = {
            Background = { Width = 420, Height = 40 },
            Text = { X = 14, Y = 5, Scale = 0.25 },
            PreText = { X = 400, Y = 5, Scale = 0.25 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 30, Width = 420 },
        Navigation = {
            Rectangle = { Width = 0, Height = 0 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 205, Y = -6, Width = 0, Height = 0 },
        },
        Description = {
            Bar = { Y = 20, Width = 420, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 420, Height = 20 },
            Text = { X = 8, Y = 3, Scale = 0.25 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 420, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 130.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 130.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 230.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 230.5, Y = 250, Scale = 0.35 },
                Left = { X = 72.75, Y = 130, Scale = 0.35 },
                Right = { X = 388.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 420, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 443, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 230.5, Y = 15, Scale = 0.35 },
                Right = { X = 428, Y = 15, Scale = 0.35 },
            },
        },
    },
}

---@class RageUIConfig
RageUI.Config = {
    Personnaliser = "Perso", -- "Rouge", "Bleu", "Orange" ou "Perso"
    Menu = {
        ButtonColor = { R = 0, G = 89, B = 255 },
        BannerGradient = { R = 0, G = 89, B = 255 },
        DisabledColor = { R = 0, G = 89, B = 255, A = 180 }
    }
}

---@class RageUIThemes
RageUI.Themes = {
    Rouge = {
        ButtonColor = { R = 220, G = 50, B = 50 },
        BannerGradient = { R = 220, G = 50, B = 50 },
        DisabledColor = { R = 60, G = 60, B = 60, A = 180 }
    },
    Bleu = {
        ButtonColor = { R = 50, G = 100, B = 220 },
        BannerGradient = { R = 50, G = 100, B = 220 },
        DisabledColor = { R = 60, G = 60, B = 60, A = 180 }
    },
    Orange = {
        ButtonColor = { R = 255, G = 140, B = 0 },
        BannerGradient = { R = 255, G = 140, B = 0 },
        DisabledColor = { R = 60, G = 60, B = 60, A = 180 }
    },
    Gris = {
        ButtonColor = { R = 255, G = 255, B = 255 },
        BannerGradient = { R = 255, G = 255, B = 255 },
        DisabledColor = { R = 60, G = 60, B = 60, A = 180 }
    }
}

---@return void
---@public
function RageUI.InitializeTheme()
    if RageUI.Config.Personnaliser == "Perso" then
        return
    elseif RageUI.Themes[RageUI.Config.Personnaliser] then
        RageUI.Config.Menu = {
            ButtonColor = { R = RageUI.Themes[RageUI.Config.Personnaliser].ButtonColor.R, G = RageUI.Themes[RageUI.Config.Personnaliser].ButtonColor.G, B = RageUI.Themes[RageUI.Config.Personnaliser].ButtonColor.B },
            BannerGradient = { R = RageUI.Themes[RageUI.Config.Personnaliser].BannerGradient.R, G = RageUI.Themes[RageUI.Config.Personnaliser].BannerGradient.G, B = RageUI.Themes[RageUI.Config.Personnaliser].BannerGradient.B },
            DisabledColor = { R = RageUI.Themes[RageUI.Config.Personnaliser].DisabledColor.R, G = RageUI.Themes[RageUI.Config.Personnaliser].DisabledColor.G, B = RageUI.Themes[RageUI.Config.Personnaliser].DisabledColor.B, A = RageUI.Themes[RageUI.Config.Personnaliser].DisabledColor.A }
        }
    end
end

---@param theme string|table
---@return void
---@public
function RageUI.SetMenuTheme(theme)
    if type(theme) == "string" then
        RageUI.Config.Personnaliser = theme
        if theme == "Perso" then
            return
        elseif RageUI.Themes[theme] then
            RageUI.Config.Menu = {
                ButtonColor = { R = RageUI.Themes[theme].ButtonColor.R, G = RageUI.Themes[theme].ButtonColor.G, B = RageUI.Themes[theme].ButtonColor.B },
                BannerGradient = { R = RageUI.Themes[theme].BannerGradient.R, G = RageUI.Themes[theme].BannerGradient.G, B = RageUI.Themes[theme].BannerGradient.B },
                DisabledColor = { R = RageUI.Themes[theme].DisabledColor.R, G = RageUI.Themes[theme].DisabledColor.G, B = RageUI.Themes[theme].DisabledColor.B, A = RageUI.Themes[theme].DisabledColor.A }
            }
        end
    elseif type(theme) == "table" then
        RageUI.Config.Personnaliser = "Perso"
        if theme.ButtonColor and theme.BannerGradient then
            RageUI.Config.Menu = {
                ButtonColor = { R = theme.ButtonColor.R, G = theme.ButtonColor.G, B = theme.ButtonColor.B },
                BannerGradient = { R = theme.BannerGradient.R, G = theme.BannerGradient.G, B = theme.BannerGradient.B },
                DisabledColor = theme.DisabledColor and { R = theme.DisabledColor.R, G = theme.DisabledColor.G, B = theme.DisabledColor.B, A = theme.DisabledColor.A } or { R = 60, G = 60, B = 60, A = 180 }
            }
        end
    end
end

function RageUI.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

function RageUI.IsMouseInBounds(X, Y, Width, Height)
    local GetControlNormal = IsControlEnabled(2, 239) and GetControlNormal or GetDisabledControlNormal
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function RageUI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

function RageUI.Visible(Menu, Value)
    if Menu ~= nil and Menu() then
        if Value == true or Value == false then
            if Value then
                if RageUI.CurrentMenu ~= nil then
                    if RageUI.CurrentMenu.Closed ~= nil then
                        RageUI.CurrentMenu.Closed()
                    end
                    RageUI.CurrentMenu.Open = not Value
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();

                end
                RageUI.CurrentMenu = Menu
            else
                RageUI.CurrentMenu = nil
            end
            Menu.Open = Value
            RageUI.Options = 0
            RageUI.ItemOffset = 0
            RageUI.LastControl = false
        else
            return Menu.Open
        end
    end
end

function RageUI.CloseAll()
    if RageUI.CurrentMenu ~= nil then
        local parent = RageUI.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = parent.Pagination.Total
            parent = parent.Parent
        end
        RageUI.CurrentMenu.Index = 1
        RageUI.CurrentMenu.Pagination.Minimum = 1
        RageUI.CurrentMenu.Pagination.Maximum = RageUI.CurrentMenu.Pagination.Total
        RageUI.CurrentMenu.Open = false
        RageUI.CurrentMenu = nil
    end
    RageUI.Options = 0
    RageUI.ItemOffset = 0
    ResetScriptGfxAlign()
end

function RageUI.Banner()
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Header) then
            RageUI.ItemsSafeZone(CurrentMenu)
            
            local height = RageUI.Settings.Items.Title.Background.Height
            local segments = 10
            local segmentHeight = height / segments
            
            for i = 0, segments - 1 do
                local alpha = 170 
                local intensity = (i / segments)
                RenderRectangle(
                    CurrentMenu.X, 
                    CurrentMenu.Y + (i * segmentHeight), 
                    RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, 
                    segmentHeight, 
                    math.floor(intensity * RageUI.Config.Menu.BannerGradient.R * 0.2),
                    math.floor(intensity * RageUI.Config.Menu.BannerGradient.G * 0.2),
                    math.floor(intensity * RageUI.Config.Menu.BannerGradient.B * 0.2),
                    alpha
                )
            end
            
            
            if (CurrentMenu.Display.Glare) then
                local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                ---@type number
                local Glarewidth = RageUI.Settings.Items.Title.Background.Width
                ---@type number
                local Glareheight = RageUI.Settings.Items.Title.Background.Height
                ---@type number
                local GlareX = CurrentMenu.X / 1920 + (CurrentMenu.SafeZoneSize.X / (64.399 - (CurrentMenu.WidthOffset * 0.065731)))
                ---@type number
                local GlareY = CurrentMenu.Y / 1080 + CurrentMenu.SafeZoneSize.Y / 33.195020746888
                RageUI.SetScaleformParams(ScaleformMovie, {
                    { name = "SET_DATA_SLOT", param = { GetGameplayCamRelativeHeading() } }
                })
                DrawScaleformMovie(ScaleformMovie, GlareX, GlareY, Glarewidth / 430, Glareheight / 100, 255, 255, 255, 255, 0)
            end
            
            RenderText(CurrentMenu.Title, CurrentMenu.X - 15 + RageUI.Settings.Items.Title.Text.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Items.Title.Text.Y + 5, fontId, CurrentMenu.TitleScale, 255, 255, 255, 255, 1)
            
            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Title.Background.Height
        end
    end
end

function RageUI.Subtitle()
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Subtitle) then
            RageUI.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Subtitle ~= "" then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + RageUI.ItemOffset, RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight - 3, 0, 0, 0, 135)
                
                RenderText((CurrentMenu.PageCounterColour .. CurrentMenu.Subtitle), CurrentMenu.X + RageUI.Settings.Items.Subtitle.Text.X, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.Text.Y + RageUI.ItemOffset, fontIdButton, RageUI.Settings.Items.Subtitle.Text.Scale, 255, 255, 255, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset)
                
                if CurrentMenu.Index > CurrentMenu.Options or CurrentMenu.Index < 0 then
                    CurrentMenu.Index = 1
                end
                if (CurrentMenu ~= nil) then
                    if (CurrentMenu.Index > CurrentMenu.Pagination.Total) then
                        local offset = CurrentMenu.Index - CurrentMenu.Pagination.Total
                        CurrentMenu.Pagination.Minimum = 1 + offset
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total + offset
                    else
                        CurrentMenu.Pagination.Minimum = 1
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                    end
                end

                if CurrentMenu.Display.PageCounter then
                    if CurrentMenu.PageCounter == nil then
                        RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Index .. " / " .. CurrentMenu.Options, CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, fontIdButton, RageUI.Settings.Items.Subtitle.PreText.Scale, 255, 255, 255, 255, 2)
                    else
                        RenderText(CurrentMenu.PageCounter, CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, fontIdButton, RageUI.Settings.Items.Subtitle.PreText.Scale, 255, 255, 255, 255, 2)
                    end
                end
                RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

function RageUI.Background()
    local CurrentMenu = RageUI.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Background) then
            RageUI.ItemsSafeZone(CurrentMenu)
            SetScriptGfxDrawOrder(0)

            RenderRectangle(CurrentMenu.X, 110 + CurrentMenu.Y + RageUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, RageUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, RageUI.ItemOffset - 120, 0, 0, 0, 135)
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + RageUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 15, RageUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, 2, 0, 0, 0, 0)

            SetScriptGfxDrawOrder(1)
        end
    end
end

function RageUI.Description()
    local CurrentMenu = RageUI.CurrentMenu;
    local Description = RageUI.Settings.Items.Description;
    if CurrentMenu ~= nil and CurrentMenu.Description ~= nil then
        if CurrentMenu() then
            RageUI.ItemsSafeZone(CurrentMenu)

            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Description.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 28, Description.Background.Width + CurrentMenu.WidthOffset, CurrentMenu.DescriptionHeight + 5, 0, 0, 0, 135)
                        
            RenderText(CurrentMenu.Description, CurrentMenu.X + Description.Text.X, CurrentMenu.Y + Description.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 30, fontIdButton, Description.Text.Scale, 255, 255, 255, 255, nil, false, false, Description.Background.Width + CurrentMenu.WidthOffset - 8.0)
            
            RageUI.ItemOffset = RageUI.ItemOffset + CurrentMenu.DescriptionHeight + Description.Bar.Y
        end
    end
end

function RageUI.Render()
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end

            if (CurrentMenu.Display.InstructionalButton) then
                if not CurrentMenu.InitScaleform then
                    CurrentMenu:UpdateInstructionalButtons(true)
                    CurrentMenu.InitScaleform = true
                end
                DrawScaleformMovieFullscreen(CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            CurrentMenu.Options = RageUI.Options
            CurrentMenu.SafeZoneSize = nil
            RageUI.Controls()
            RageUI.Options = 0
            RageUI.StatisticPanelCount = 0
            RageUI.ItemOffset = 0
            if CurrentMenu.Controls.Back.Enabled then
                if CurrentMenu.Controls.Back.Pressed and CurrentMenu.Closable and (not isWaitingForServer) then
                    CurrentMenu.Controls.Back.Pressed = false
                    local Audio = RageUI.Settings.Audio
                    RageUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)

                    if CurrentMenu.Closed ~= nil then
                        collectgarbage()
                        CurrentMenu.Closed()
                    end

                    if CurrentMenu.Parent ~= nil then
                        if CurrentMenu.Parent() then
                            RageUI.NextMenu = CurrentMenu.Parent
                            CurrentMenu:UpdateCursorStyle()
                        else
                            RageUI.NextMenu = nil
                            RageUI.Visible(CurrentMenu, false)
                        end
                    else
                        RageUI.NextMenu = nil
                        RageUI.Visible(CurrentMenu, false)
                    end
                elseif CurrentMenu.Controls.Back.Pressed and not CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                end
            end
            if RageUI.NextMenu ~= nil then
                if RageUI.NextMenu() then
                    RageUI.Visible(CurrentMenu, false)
                    RageUI.Visible(RageUI.NextMenu, true)
                    CurrentMenu.Controls.Select.Active = false
                    RageUI.NextMenu = nil
                    RageUI.LastControl = false
                end
            end
        end
    end
end

function RageUI.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = RageUI.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsDescription.Text.Scale, 20, 24, 28, 1, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount + 10
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 15
            end
        end
    end
end

function RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = RageUI.Settings.Audio
            RageUI.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
        end
    end
    return Hovered;
end

function RageUI.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function RageUI.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    return Current == To and Style or DefaultStyle or {};
end

function RageUI.IsVisible(Menu, Items, Panels)
    if (RageUI.Visible(Menu)) and (UpdateOnscreenKeyboard() ~= 0) and (UpdateOnscreenKeyboard() ~= 3) then

        local Pagination = GetResourceKvpInt('MENU_LENGTH') == 2 and 8 or 13
        RageUI.CurrentMenu.Pagination = { Minimum = 1, Maximum = Pagination, Total = Pagination }
        
        RageUI.Banner()
        RageUI.Subtitle()
        if (Items ~= nil) then
            Items()
        end
        RageUI.Background();
        RageUI.Description();
        if (Panels ~= nil) then
            Panels()
        end
        RageUI.Render()
        RageUI.Navigation()
    end
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function RageUI.SetStyleAudio(StyleAudio)
    RageUI.Settings.Audio.Use = StyleAudio or "RageUI"
end

function RageUI.GetStyleAudio()
    return RageUI.Settings.Audio.Use or "RageUI"
end

