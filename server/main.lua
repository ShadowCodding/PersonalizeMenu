-- ============================================================================
-- File        : main.lua
-- Created     : 21/10/2025 21:16
-- Author      : ShadowCodding
-- YouTube     : https://www.youtube.com/@ShadowCodding
-- GitHub      : https://github.com/ShadowCodding/
-- Discord     : https://discord.com/s-dev
-- ============================================================================

RegisterNetEvent("PersonalizeMenu:LoadDefaultTheme", function()
    local _src = source
    local theme = LoadResourceFile("zUI", "themes/default.json")
    TriggerClientEvent("PersonalizeMenu:sendDefaultTheme", _src, theme)
end)