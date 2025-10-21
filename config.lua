-- ============================================================================
-- File        : config.lua
-- Created     : 21/10/2025 21:18
-- Author      : ShadowCodding
-- YouTube     : https://www.youtube.com/@ShadowCodding
-- GitHub      : https://github.com/ShadowCodding/
-- Discord     : https://discord.com/s-dev
-- ============================================================================


local config = {}

config.menu = {
    title = "Personalize Menu",
    titleSubMenu = "My Themes",
    subtitle = "Customize your experience",
    subtitleSubMenu = "Your saved themes",
    description = "Interact with settings menu",
    descriptionSubMenu = "Manage your saved themes",
    key = "F5",
    keyMapping = "Ouvrir le menu de personnalisation",
    theme = "default",
    banner = nil,
    lang = "fr"
}

config.locales = {
    ["fr"] = {
        ["menu"] = {
            ["width"] = {label = "Taille du menu", help = "Définir la taille du menu (ex: 20vw (defaut)", step = 1},
            ["displayBanner"] = {label = "Afficher la bannière", help = "Activer ou désactiver l'affichage de la bannière en haut du menu"},
            ["displayInformations"] = {label = "Afficher les informations", help = "Activer ou désactiver l'affichage des informations en bas du menu"},
            ["displayControlsIndicator"] = {label = "Afficher l'indicateur de contrôles", help = "Activer ou désactiver l'affichage de l'indicateur de contrôles"},
            ["cornersRadius"] = {label = "Rayon des coins", help = "Définir le rayon des coins du menu", step = 0.25},
            ["perspective"] = {label = "Perspective", help = "Activer ou désactiver l'effet de perspective du menu"},
            ["margin"] = {label = "Marge", help = "Activer ou désactiver la marge autour du menu"},
            ["shadow"] = {label = "Ombre", help = "Activer ou désactiver l'ombre du menu"},
            ["hoverStyle"] = {label = "HoverStyle des boutons", help = "Permet de changer le bouton selectionné", items = {"liquid", "complete", "rod", "neon", "border", "modern", "glowInset", "twist"}, index = 1},
            ["animations"] = {
                ["entry"] = {label = "Animation d'entrée", desc = "Permet de changer l'animation d'entrée", items = {"fadeIn", "slideInHorizontal", "slideInVertical", "zoomIn", "rotateIn", "bounceIn", "flipIn"}, index = 1},
                ["exit"] = {label = "Animation de sortie", desc = "Permet de changer l'animation de sortie", items = {"fadeOut", "slideOutHorizontal", "slideOutVertical", "zoomOut", "rotateOut", "bounceOut", "flipOut"}, index = 1},
                ["onScroll"] = {label = "Animation au scroll", desc = "Permet d'activer l'animation au scroll"},
                ["onSwitch"] = {label = "Animation au changement", desc = "Permet d'activer l'animation au changement"}
            },
            ["colors"] = {
                ["primary"] = {label = "Couleur primaire", desc = "Définir la couleur primaire du menu"},
                ["background"] = {label = "Couleur de fond", desc = "Définir la couleur de fond du menu"},
                ["description"] = {label = "Couleur de la description", desc = "Définir la couleur de la description du menu"},
                ["informations"] = {label = "Couleur des informations", desc = "Définir la couleur des informations du menu"},
                ["controlsIndicator"] = {label = "Couleur de l'indicateur de contrôles", desc = "Définir la couleur de l'indicateur de contrôles du menu"},
                ["itemSelected"] = {label = "Couleur de l'item sélectionné", desc = "Définir la couleur de l'item sélectionné du menu"},
                ["banner"] = {label = "Couleur de la bannière", desc = "Définir la couleur de la bannière du menu"}
            },
            ["keyPressDelay"] = {label = "Délai de pression des touches", help = "Définir le délai de pression des touches en ms", step = 10},
            ["sound"] = {label = "Son du menu", help = "Activer ou désactiver les sons du menu"},
            ["font"] = {label = "Police du menu", help = "Définir la police du menu", items = {"default", "arial", "comic", "pixel", "futura"}, index = 1},
            ["maxVisibleItems"] = {label = "Nombre maximum d'items visibles", help = "Définir le nombre maximum d'items visibles dans le menu", step = 1}
        }
    }
}

config.logs = {
    enable = true,
    -- Create log with style and text colored for easier identification
    suc = function(msg, ...)
        print(("[^2PersonalizeMenu^7] [^2SUCCESS^7] : %s %s"):format(msg, table.concat({...}, " - ")))
    end,
    err = function(msg, ...)
        print(("[^2PersonalizeMenu^7] [^1ERROR^7] : %s %s"):format(msg, table.concat({...}, " - ")))
    end,
    info = function(msg, ...)
        print(("[^2PersonalizeMenu^7] [^3INFO^7] : %s %s"):format(msg, table.concat({...}, " - ")))
    end
}

config.functions = {
    countTable = function(t)
        local count = 0
        for _ in pairs(t) do
            count = count + 1
        end
        return count
    end,
    title = function(key)
        local locale = config.locales[config.menu.lang]
        if not locale or not locale.menu then
            return key
        end

        if (locale.menu[key] and locale.menu[key].label) then
            return locale.menu[key].label
        end

        if (locale.menu.colors and locale.menu.colors[key] and locale.menu.colors[key].label) then
            return locale.menu.colors[key].label
        end

        if (locale.menu.animations and locale.menu.animations[key] and locale.menu.animations[key].label) then
            return locale.menu.animations[key].label
        end

        return key
    end,
    help = function(key)
        local locale = config.locales[config.menu.lang]
        if not locale or not locale.menu then
            return ""
        end

        if (locale.menu[key] and locale.menu[key].help) then
            return locale.menu[key].help
        end

        if (locale.menu.colors and locale.menu.colors[key] and locale.menu.colors[key].desc) then
            return locale.menu.colors[key].desc
        end

        if (locale.menu.animations and locale.menu.animations[key] and locale.menu.animations[key].desc) then
            return locale.menu.animations[key].desc
        end

        return ""
    end,
    step = function(key)
        local locale = config.locales[config.menu.lang]
        if not locale or not locale.menu then
            return 1
        end

        if (locale.menu[key] and locale.menu[key].step) then
            return locale.menu[key].step
        end

        return 1
    end,
    items = function(key)
        local locale = config.locales[config.menu.lang]
        if not locale or not locale.menu then
            return {}
        end

        if (locale.menu[key] and locale.menu[key].items) then
            return locale.menu[key].items
        end

        return {}
    end,
    index = function(key)
        local locale = config.locales[config.menu.lang]
        if not locale or not locale.menu then
            return 1
        end

        if (locale.menu[key] and locale.menu[key].index) then
            return locale.menu[key].index
        end

        return 1
    end
}

config.logs.info("Configuration loaded.")

function getConfig()
    return config
end