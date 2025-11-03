[//]: # (Generate to me a readme, A list to use this script)
[//]: # (Need change to zUI/functions/applyTheme.lua comment this line : assert&#40;type&#40;theme&#41; == "table", "zUI.ApplyTheme: Le thème '" .. theme .. "' n'est pas dans un format valide"&#41;)

# PersonalizeMenu
Le module PersonalizeMenu permet aux utilisateurs de personnaliser l'apparence et le comportement de l'interface utilisateur de zUI. Il offre une variété d'options pour ajuster les thèmes, les couleurs, les polices et d'autres aspects visuels selon les préférences personnelles.
## Fonctionnalités
- **Sélection de Thèmes** : Choisissez parmi plusieurs thèmes prédéfinis ou créez votre propre thème personnalisé.
- **Personnalisation des Couleurs** : Modifiez les couleurs des éléments de l'interface utilisateur pour correspondre à vos goûts.
- **Ajustement des Polices** : Changez les polices utilisées dans l'interface pour une meilleure lisibilité.
- **Options de Disposition** : Ajustez la disposition des éléments de l'interface pour
    une expérience utilisateur optimale.
- **Prévisualisation en Temps Réel** : Voyez les modifications apportées en temps réel avant de les appliquer.

## Utilisation
1. Ouvrez le menu de personnalisation via l'interface zUI.
2. Sélectionnez les options que vous souhaitez modifier.
3. Appliquez les modifications et profitez de votre interface personnalisée.

## Installation
1. Téléchargez le module PersonalizeMenu.
2. Placez-le dans le répertoire de vos ressources
3. Assurez-vous que zUI est correctement installé et configuré.

## Modifications
1. Commenter la ligne 3 du fichier zUI/functions/applyTheme.lua
    ```lua
    assert(type(theme) == "table", "zUI.ApplyTheme: Le thème '" .. theme .. "' n'est pas dans un format valide")
    ```
   pour que le script fonctionne correctement.
2. Ajouter ces 2 lignes dans zUI/menu/main.lua en dessous de la ligne 95
    ```lua
        local myTheme = nil
        if (GetResourceState("PersonalizeMenu") == "started") then
            myTheme = exports["PersonalizeMenu"]:getMyPersonalTheme()
        end
        menu.theme = myTheme and myTheme or menu.theme
    ```
3. N'oubliez pas de start le script PersonalizeMenu.
### Auteur
- **ShadowCodding**