local zUI = exports["zUI"]:getObject()
local config = getConfig()
local configMenu = config.menu
local logs = config.logs
local functions = config.functions
local main_menu = zUI.CreateMenu(configMenu.title, configMenu.subtitle, configMenu.description, configMenu.theme, configMenu.banner, configMenu.key, configMenu.keyMapping)
local my_themes_menu = zUI.CreateSubMenu(main_menu, configMenu.titleSubMenu, configMenu.subtitleSubMenu, configMenu.descriptionSubMenu)

local data = {
    personalizeMenu = {},
    defaultTheme = {},
    myThemes = {}
}
local basedTheme = {}


RegisterNetEvent("PersonalizeMenu:sendDefaultTheme", function(theme)
    basedTheme = json.decode(theme)
    data.defaultTheme = json.decode(theme)
    data.personalizeMenu = json.decode(theme)
    local kvp = GetResourceKvpString("PersonalizeMenu:MyThemes")
    data.myThemes = kvp and json.decode(kvp) or {}
end)

function getDefaultTheme()
    return basedTheme
end
local isInCreate = false
function isCreatingStyle()
    return isInCreate
end
function getInPersonalizeTheme()
    return data.personalizeMenu
end

zUI.SetItems(main_menu, function()
    zUI.Checkbox("Création de style", "Désactiver cette option si vous souhaitez revenir a un thème validé !", isInCreate, {  }, function(onSelected)
        if (onSelected) then
            isInCreate = not isInCreate
            logs.suc(("Mode création de style %s."):format(isInCreate and "activé" or "désactivé"))
            if (isInCreate) then
                zUI.ApplyTheme(data.personalizeMenu)
            else
                local currentTheme = getMyPersonalTheme()
                if currentTheme then
                    zUI.ApplyTheme(currentTheme)
                    logs.suc("Thème actuel réappliqué.")
                end
            end
        end
    end)

    zUI.Button("Remettre le thème à zéro", nil, {}, function(onSelected)
        if onSelected then
            data.personalizeMenu = json.decode(json.encode(basedTheme))
            zUI.ApplyTheme(data.personalizeMenu)
            logs.suc("Remise à zéro du thème effectuée.")
        end
    end)

    zUI.Button("Enregistrer ce thème", nil, {}, function(onSelected)
        if onSelected then
            zUI.ManageFocus(false)
            local themeName = input_showBox("Nom du thème", "", 30)
            if themeName and themeName ~= "" then
                if data.myThemes[themeName] then
                    logs.err("Un thème avec ce nom existe déjà.")
                    return
                end
                data.myThemes[themeName] = data.personalizeMenu
                SetResourceKvp("PersonalizeMenu:MyThemes", json.encode(data.myThemes))
                logs.suc(("Thème enregistré sous le nom : %s"):format(themeName))
                zUI.ManageFocus(true)
            else
                logs.err("Nom de thème invalide.")
            end
        end
    end)

    zUI.Button(("Voir mes thèmes (%s)"):format(functions.countTable(data.myThemes) or 0), nil, {}, function(onSelected) end, my_themes_menu)

    zUI.Line()
    if (isInCreate) then
        if data.personalizeMenu and data.personalizeMenu.menu then
            zUI.Separator("Paramêtre du menu")
            for key, value in pairs(data.personalizeMenu.menu) do
                if type(value) == "boolean" then
                    zUI.Checkbox(functions.title(key), functions.help(key), value, {}, function(onSelected)
                        if (onSelected) then
                            local newValue = not data.personalizeMenu.menu[key]
                            data.personalizeMenu.menu[key] = newValue
                            logs.suc(("Changement de la valeur '%s' à '%s'"):format(key, tostring(newValue)))
                            zUI.ApplyTheme(data.personalizeMenu)
                        end
                    end)
                elseif type(value) == "number" then
                    if (key ~= "keyPressDelay") then
                        zUI.Slider(functions.title(key), functions.help(key), value, functions.step(key), {  }, function(onSelected, onChange, newValue)
                            if (onChange) then
                                data.personalizeMenu.menu[key] = newValue
                                logs.suc(("Changement de la valeur '%s' à '%s'"):format(key, tostring(newValue)))
                                zUI.ApplyTheme(data.personalizeMenu)
                            end
                        end)
                    end
                end
            end
            zUI.Line()
            zUI.Separator("Animations")
            local key = "hoverStyle"
            local locale = config.locales[config.menu.lang]
            local path = locale and locale.menu and locale.menu[key]
            if path and type(path.items) == "table" and #path.items > 0 then
                zUI.List(path.label, path.help, path.items, path.index, {}, function(onSelected, onChange, index)
                    if (onChange) then
                        if not path.items[index] then
                            logs.err(("Index invalide pour '%s' (%s)"):format(key, tostring(index)))
                            return
                        end

                        local selectedStyle = path.items[index]
                        data.personalizeMenu.menu[key] = selectedStyle

                        -- met à jour l'index côté config locales pour garder la position sélectionnée
                        path.index = index

                        logs.suc(("Changement de la valeur '%s' à '%s'"):format(key, tostring(selectedStyle)))
                        zUI.ApplyTheme(data.personalizeMenu)
                    end
                end)
            end
            local key = "entry"
            local path = config.locales[config.menu.lang].menu.animations[key]
            if path and type(path.items) == "table" and #path.items > 0 then
                zUI.List(
                        path.label or key,
                        path.help or "",
                        path.items,
                        path.index or 1,
                        {},
                        function(onSelected, onChange, index)
                            if onChange then
                                if not path.items[index] then return end
                                local selectedAnim = path.items[index]
                                data.personalizeMenu.menu.animations[key] = selectedAnim
                                path.index = index
                                logs.suc(("Changement de l'animation '%s' à '%s'"):format(key, tostring(selectedAnim)))
                                zUI.ApplyTheme(data.personalizeMenu)
                            end
                        end
                )
            end
            local key = "exit"
            local path = config.locales[config.menu.lang].menu.animations[key]
            if path and type(path.items) == "table" and #path.items > 0 then
                zUI.List(
                        path.label or key,
                        path.help or "",
                        path.items,
                        path.index or 1,
                        {},
                        function(onSelected, onChange, index)
                            if onChange then
                                if not path.items[index] then return end
                                local selectedAnim = path.items[index]
                                data.personalizeMenu.menu.animations[key] = selectedAnim
                                path.index = index
                                logs.suc(("Changement de l'animation '%s' à '%s'"):format(key, tostring(selectedAnim)))
                                zUI.ApplyTheme(data.personalizeMenu)
                            end
                        end
                )
            end

            if (data.personalizeMenu.menu.colors) then
                zUI.Line()
                zUI.Separator("Couleurs")

                for colorKey, colorValue in pairs(data.personalizeMenu.menu.colors) do
                    local isRGBA = colorValue:find("^rgba")
                    local hexColor, alpha = rgbaToHex(colorValue)

                    zUI.ColorPicker(functions.title(colorKey), functions.help(colorKey), hexColor, {}, function(onChange, value)
                        if not onChange or not value then return end

                        if isRGBA then
                            -- Convertit le hex reçu (#rrggbb) en r, g, b
                            local r, g, b = value:match("#?(%x%x)(%x%x)(%x%x)")
                            if not (r and g and b) then return end
                            r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

                            -- reconstruit la couleur rgba avec l’alpha d’origine
                            data.personalizeMenu.menu.colors[colorKey] =
                            string.format("rgba(%d, %d, %d, %.2f)", r, g, b, alpha)
                        else
                            -- si c’était déjà du hex → on garde tel quel
                            data.personalizeMenu.menu.colors[colorKey] = value
                        end

                        logs.suc(("Changement de la couleur '%s' à '%s'"):format(colorKey, data.personalizeMenu.menu.colors[colorKey]))
                        zUI.ApplyTheme(data.personalizeMenu)
                    end)
                end




                local backgroundColor = data.personalizeMenu.menu.colors.background
                local opacity = backgroundColor:match("rgba%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*(%d*%.?%d+)%s*%)")

                if opacity then
                    local opacityNumber = tonumber(opacity) * 100

                    zUI.Slider(
                            "Opacité du fond",
                            "Permet de changer l'opacité du fond du menu",
                            opacityNumber,
                            1,
                            {
                                IsDisabled = false,
                                ShowPercentage = true,
                            },
                            function(onSelected, onChange, value)
                                if onChange then
                                    local newOpacity = value / 100
                                    local r, g, b = backgroundColor:match("rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*[%d%.]+%s*%)")

                                    if not (r and g and b) then return end

                                    data.personalizeMenu.menu.colors.background = ("rgba(%s, %s, %s, %.2f)"):format(r, g, b, newOpacity)
                                    zUI.ApplyTheme(data.personalizeMenu)
                                    logs.suc(("Opacité du fond modifiée à %.0f%%"):format(value))
                                end

                                if onSelected then
                                    zUI.ManageFocus(false)

                                    -- permet de saisir une valeur manuellement
                                    local input = input_showBox("Opacité du fond", "", 3)
                                    if not input then return end

                                    local num = tonumber(input)
                                    if num and num >= 0 and num <= 100 then
                                        local op = num / 100

                                        -- ⚠️ ici on redéfinit r, g, b pour éviter les nil
                                        local r, g, b = backgroundColor:match("rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,%s*[%d%.]+%s*%)")
                                        if not (r and g and b) then return end

                                        data.personalizeMenu.menu.colors.background =
                                        ("rgba(%s, %s, %s, %.2f)"):format(r, g, b, op)
                                        zUI.ApplyTheme(data.personalizeMenu)
                                        logs.suc(("Opacité du fond modifiée à %.0f%%"):format(num))
                                        zUI.ManageFocus(true)
                                    end
                                end
                            end
                    )
                end
            end

        end
    end
end)

zUI.SetItems(my_themes_menu, function()
    for themeName, themeData in pairs(data.myThemes) do
        zUI.Button(themeName, nil, {}, function(onSelected)
            if onSelected then
                data.personalizeMenu = themeData
                zUI.ApplyTheme(data.personalizeMenu)
                if (GetResourceKvpString("PersonalizeMenu:CurrentTheme")) then
                    DeleteResourceKvp("PersonalizeMenu:CurrentTheme")
                end
                SetResourceKvp("PersonalizeMenu:CurrentTheme", themeName)
                logs.suc(("Thème '%s' appliqué."):format(themeName))
                print(json.encode(themeData, { indent = true }))
                zUI.CloseAll()
                zUI.SetVisible(main_menu, true)
            end
        end)
    end
end)