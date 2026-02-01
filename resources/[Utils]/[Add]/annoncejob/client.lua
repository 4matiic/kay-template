local ESX = exports["framework"]:getSharedObject()

-- ===== Helpers =====
local function isValidIcon(icon)
    if not icon or icon == "" then return false end
    if icon:match("^https?://") then return true end
    if icon:upper():match("^CHAR_") then return true end
    return false
end

local function Notify(icon, title, msg, duration, sticky)
    exports["ava"]:addNotification(
        icon or nil,
        nil, -- header
        title or "",
        "Annonce entreprise",
        msg or "",
        duration or 10000,
        sticky or false
    )
end

local function getJobLabel()
    if ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.label then
        return ESX.PlayerData.job.label
    end
    return "Annonce entreprise"
end

-- ===== State =====
local MenuAnnonce   = nil
local menuOpen      = false

local annTitle      = ""
local annMessage    = ""

-- Icônes
local selectedIcon  = nil
local jobIcons      = {}
local idxIconAction = {}

-- Messages prédéfinis
local jobMessages   = {}
local idxMsgAction  = {}
local selectedMsg   = nil

local lastPreviewAt = 0
local PREVIEW_COOLDOWN_MS = 1500

-- ===== Validation / Reset =====
local function iconExistsForCurrentJob(id)
    if not id then return false end
    for _, it in ipairs(jobIcons) do
        if it.id == id then return true end
    end
    return false
end

local function messageExistsForCurrentJob(id)
    if not id then return false end
    for _, it in ipairs(jobMessages) do
        if it.id == id then return true end
    end
    return false
end

local function resetSelectionsForCurrentJob()
    annTitle      = getJobLabel()
    annMessage    = ""
    selectedIcon  = nil
    selectedMsg   = nil
end

local function validateSelections()
    -- invalider l'icône si elle n'appartient plus au job
    if selectedIcon and not iconExistsForCurrentJob(selectedIcon.id) then
        selectedIcon = nil
        ESX.ShowNotification("~y~Icône désélectionnée (changement de métier).")
    end
    -- invalider le message si plus dans ce job
    if selectedMsg and not messageExistsForCurrentJob(selectedMsg.id) then
        selectedMsg = nil
        annTitle   = getJobLabel()
        annMessage = ""
        ESX.ShowNotification("~y~Message prédéfini désélectionné (changement de métier).")
    end
end

-- ===== Data =====
local function RefreshIcons(cb)
    ESX.TriggerServerCallback('fb_announce:getIcons', function(rows)
        jobIcons = rows or {}
        idxIconAction = {}
        for i = 1, #jobIcons do idxIconAction[i] = 1 end
        if cb then cb() end
    end)
end

local function RefreshMessages(cb)
    ESX.TriggerServerCallback('fb_announce:getMessages', function(rows)
        jobMessages = rows or {}
        idxMsgAction = {}
        for i = 1, #jobMessages do idxMsgAction[i] = 1 end
        if cb then cb() end
    end)
end

-- ===== Events ESX =====
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    resetSelectionsForCurrentJob()
    if menuOpen then
        RefreshIcons(function() validateSelections() end)
        RefreshMessages(function() validateSelections() end)
    end
end)

RegisterNetEvent('esx:setJob', function(job)
    if not ESX.PlayerData then ESX.PlayerData = {} end
    ESX.PlayerData.job = job

    -- reset local et recharge des listes du nouveau job
    resetSelectionsForCurrentJob()
    if menuOpen then
        RefreshIcons(function() validateSelections() end)
        RefreshMessages(function() validateSelections() end)
    end
end)

-- ===== Menus =====
local function EnsureMenus()
    if MenuAnnonce then return end
    MenuAnnonce = RageUI.CreateMenu("Annonces", "ANNONCES D'ENTREPRISE")
    MenuAnnonce.EnableMouse = false
end

local function Render()
    CreateThread(function()
        while menuOpen do
            validateSelections()

            RageUI.IsVisible(MenuAnnonce, function()
                local jobLabel = getJobLabel()
                if annTitle == "" then annTitle = jobLabel end

                RageUI.Separator("Icônes")

                RageUI.Button("Créer un icône", nil, { RightLabel = "→→→" }, true, {
                    onSelected = function()
                        local name = exports["ava"]:ShowInput("Nom de l'icône", false, 50, "small_text", "")
                        local url  = exports["ava"]:ShowInput("URL de l'icône (https://... ou CHAR_*)", false, 255, "text", "")
                        if not name or name == "" or not url or url == "" then
                            ESX.ShowNotification("~r~Champs requis manquants."); return
                        end
                        if not isValidIcon(url) then
                            ESX.ShowNotification("~r~Icône invalide (URL http(s) ou sprite CHAR_*)."); return
                        end
                        TriggerServerEvent('fb_announce:addIcon', name, url)
                        Wait(200)
                        RefreshIcons(function() validateSelections() end)
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })

                RageUI.Button("Aucune icône", nil, { RightLabel = (selectedIcon == nil) and "✅" or "→→→" }, true, {
                    onSelected = function()
                        selectedIcon = nil
                        ESX.ShowNotification("~g~Aucune icône sélectionnée.")
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })

                if #jobIcons > 0 then
                    for i = 1, #jobIcons do
                        local icon = jobIcons[i]
                        local opts = { (selectedIcon and icon.id == selectedIcon.id) and "✅" or "Utiliser", "Modifier", "Supprimer" }

                        RageUI.List(("N° %s | %s"):format(icon.id, icon.name), opts, idxIconAction[i] or 1, icon.url, {}, true, {
                            onListChange = function(Index) idxIconAction[i] = Index end,
                            onSelected = function(Index)
                                if Index == 1 then
                                    selectedIcon = icon
                                    ESX.ShowNotification("~g~Icône sélectionnée: ~s~" .. icon.name)
                                    RageUI.Visible(MenuAnnonce, true)
                                elseif Index == 2 then
                                    local newName = exports["ava"]:ShowInput("Nom de l'icône", false, 50, "small_text", icon.name)
                                    local newURL  = exports["ava"]:ShowInput("URL de l'icône", false, 255, "text", icon.url)
                                    if newName and newURL and newName ~= "" and newURL ~= "" and isValidIcon(newURL) then
                                        TriggerServerEvent('fb_announce:editIcon', icon.id, newName, newURL)
                                        Wait(200)
                                        RefreshIcons(function() validateSelections() end)
                                    else
                                        ESX.ShowNotification("~r~Champs invalides.")
                                    end
                                    RageUI.Visible(MenuAnnonce, true)
                                elseif Index == 3 then
                                    TriggerServerEvent('fb_announce:deleteIcon', icon.id)
                                    Wait(200)
                                    RefreshIcons(function() validateSelections() end)
                                    if selectedIcon and selectedIcon.id == icon.id then selectedIcon = nil end
                                    RageUI.Visible(MenuAnnonce, true)
                                end
                            end
                        })
                    end
                else
                    RageUI.Separator('~r~Aucun icône prédéfini')
                end

                RageUI.Separator('Messages')

                RageUI.Button("Créer un message prédéfini", nil, { RightLabel = "→→→" }, true, {
                    onSelected = function()
                        local t = exports["ava"]:ShowInput("Titre du message", false, 80,  "small_text", "")
                        local c = exports["ava"]:ShowInput("Contenu du message", false, 255, "small_text", "")
                        if not t or t=="" or not c or c=="" then
                            ESX.ShowNotification("~r~Champs requis manquants."); return
                        end
                        TriggerServerEvent('fb_announce:addMessage', t, c)
                        Wait(200)
                        RefreshMessages(function() validateSelections() end)
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })

                RageUI.Button("Aucun message prédéfini", nil, { RightLabel = (selectedMsg == nil) and "✅" or "→→→" }, true, {
                    onSelected = function()
                        selectedMsg = nil
                        annTitle   = getJobLabel()
                        annMessage = ""
                        ESX.ShowNotification("~g~Aucun message prédéfini sélectionné.")
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })

                if #jobMessages > 0 then
                    for i = 1, #jobMessages do
                        local m = jobMessages[i]
                        local opts = { (selectedMsg and m.id == selectedMsg.id) and "✅" or "Utiliser", "Modifier", "Supprimer" }

                        RageUI.List(("N° %s | %s"):format(m.id, m.title), opts, idxMsgAction[i] or 1, m.content, {}, true, {
                            onListChange = function(Index) idxMsgAction[i] = Index end,
                            onSelected = function(Index)
                                if Index == 1 then
                                    selectedMsg = m
                                    annTitle   = m.title
                                    annMessage = m.content
                                    ESX.ShowNotification("~g~Message sélectionné: ~s~" .. m.title)
                                    RageUI.Visible(MenuAnnonce, true)
                                elseif Index == 2 then
                                    local nt = exports["ava"]:ShowInput("Modifier le titre",   false, 80,  "small_text", m.title)
                                    local nc = exports["ava"]:ShowInput("Modifier le contenu", false, 255, "small_text", m.content)
                                    if nt and nc and nt ~= "" and nc ~= "" then
                                        TriggerServerEvent('fb_announce:editMessage', m.id, nt, nc)
                                        Wait(200)
                                        RefreshMessages(function() validateSelections() end)
                                        if selectedMsg and selectedMsg.id == m.id then
                                            selectedMsg.title = nt; selectedMsg.content = nc
                                            annTitle = nt; annMessage = nc
                                        end
                                    else
                                        ESX.ShowNotification("~r~Champs invalides.")
                                    end
                                    RageUI.Visible(MenuAnnonce, true)
                                elseif Index == 3 then
                                    TriggerServerEvent('fb_announce:deleteMessage', m.id)
                                    Wait(200)
                                    RefreshMessages(function() validateSelections() end)
                                    if selectedMsg and selectedMsg.id == m.id then
                                        selectedMsg = nil
                                        annTitle   = getJobLabel()
                                        annMessage = ""
                                    end
                                    RageUI.Visible(MenuAnnonce, true)
                                end
                            end
                        })
                    end
                else
                    RageUI.Separator('~r~Aucun message prédéfini')
                end

                RageUI.Separator('Actions')

                RageUI.Button("Aperçu", nil, { RightLabel = "▶" }, (annMessage ~= ""), {
                    onSelected = function()
                        validateSelections()
                        if annMessage == "" then
                            ESX.ShowNotification("~r~Aucun message sélectionné.")
                            return
                        end
                        local now = GetGameTimer()
                        if now - lastPreviewAt < PREVIEW_COOLDOWN_MS then
                            ESX.ShowNotification("~y~Patiente un instant avant un nouvel aperçu."); return
                        end
                        lastPreviewAt = now
                        local iconToUse = selectedIcon and selectedIcon.url or nil
                        Notify(iconToUse, annTitle, annMessage, 5000, false)
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })

                RageUI.Button("~g~Envoyer l'annonce", nil, { RightLabel = "✅" }, (annMessage ~= ""), {
                    onSelected = function()
                        validateSelections()
                        if annMessage == "" then
                            ESX.ShowNotification("~r~Aucun message sélectionné.")
                            return
                        end
                        local iconToSend = (selectedIcon and iconExistsForCurrentJob(selectedIcon.id)) and selectedIcon.url or nil
                        TriggerServerEvent("announce:server:syncNotif", annTitle, annMessage, iconToSend)
                        ESX.ShowNotification("~g~Annonce envoyée.")
                        RageUI.Visible(MenuAnnonce, true)
                    end
                })
            end)

            Wait(1)
        end
    end)
end

RegisterNetEvent("announce:syncNotif", function(title, msg, icon)
    Notify(icon, title, msg, 10000, false)
end)

RegisterCommand("annoncejob", function()
    ESX.PlayerData = ESX.GetPlayerData()
    if not (ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name ~= "unemployed") then
        ESX.ShowNotification("~r~Vous n'avez pas de métier."); return
    end

    annTitle = getJobLabel() 

    EnsureMenus()
    RefreshIcons(function()
        RefreshMessages(function()
            validateSelections()
        end)
    end)

    if not menuOpen then
        menuOpen = true
        RageUI.Visible(MenuAnnonce, true)
        Render()
    else
        menuOpen = false
        RageUI.Visible(MenuAnnonce, false)
    end
end, false)


CreateThread(function()
    while true do
        if MenuAnnonce and not RageUI.Visible(MenuAnnonce) then
            menuOpen = false
        end
        Wait(300)
    end
end)
