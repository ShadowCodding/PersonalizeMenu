-- ============================================================================
-- File        : loadTheme.lua
-- Created     : 21/10/2025 21:40
-- Author      : ShadowCodding
-- YouTube     : https://www.youtube.com/@ShadowCodding
-- GitHub      : https://github.com/ShadowCodding/
-- Discord     : https://discord.com/s-dev
-- ============================================================================

CreateThread(function()
    while (true) do
        Wait(1)
        if (NetworkIsPlayerActive(PlayerId())) then
            TriggerServerEvent("PersonalizeMenu:LoadDefaultTheme")
            break
        end
    end
end)

input_showBox = function(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    local blockInput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockInput = false
        if isValueInt then
            local isNumber = tonumber(result)
            if isNumber and isNumber >= 0 then
                return result
            else
                return nil
            end
        end

        return result
    else
        Wait(500)
        blockInput = false
        return nil
    end
end

function getMyPersonalTheme()
    local isInCreating = isCreatingStyle()
    if (not (isInCreating)) then
        local themes = GetResourceKvpString("PersonalizeMenu:CurrentTheme")
        if themes then
            local myThemes = GetResourceKvpString("PersonalizeMenu:MyThemes")
            if myThemes then
                local decodedThemes = json.decode(myThemes)
                if decodedThemes and decodedThemes[themes] then
                    return decodedThemes[themes]
                end
            end
        end
    else
        local theme = getInPersonalizeTheme()
        if theme then
            return theme
        end
    end
    return nil
end

function rgbaToHex(color)
    if type(color) ~= "string" then return color, 1.0 end
    local r, g, b, a = color:match("rgba%((%d+),%s*(%d+),%s*(%d+),%s*([%d%.]+)%)")
    if r and g and b then
        return string.format("#%02X%02X%02X", r, g, b), tonumber(a) or 1.0
    end
    return color, 1.0
end

function rgbToHexFromString(color)
    local r, g, b = color:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
    if r and g and b then
        return string.format("#%02X%02X%02X", r, g, b)
    end
    return color
end

function rgbToHex(r, g, b)
    return string.format("#%02X%02X%02X", tonumber(r), tonumber(g), tonumber(b))
end

function startsWith(s, pat) return type(s)=="string" and s:sub(1, #pat) == pat end

