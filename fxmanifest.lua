-- ============================================================================
-- File        : fxmanifest.lua
-- Created     : 21/10/2025 21:16
-- Author      : ShadowCodding
-- YouTube     : https://www.youtube.com/@ShadowCodding
-- GitHub      : https://github.com/ShadowCodding/
-- Discord     : https://discord.com/s-dev
-- ============================================================================

fx_version 'cerulean'
game 'gta5'
author 'ShadowCodding'
description 'Personalize Menu for zUI library'
version '1.0.0'
lua54 'yes'
repository 'https://ShadowCodding/PersonalizeMenu'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

--dependencies {
--    'zUI',
--}

escrow_ignore {
    "client/*.lua",
    "server/*.lua",
    "config.lua",
}

exports {
    'getMyPersonalTheme'
}