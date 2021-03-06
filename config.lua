--[[

    Airplanedealer • v1.0

    This script was made by Pablo1610 
        
    Twitch: https://twitch.tv/pablo_1610)

    Discord: https://discord.gg/Ksyc97N

]]

-- ESX getter
trigger = "esx:getSharedObject"

-- Discord webhook
webhook = "putYourWebhookHere" -- CHANGE ME

-- Locales
menu_garage_separator_owned_vehicles = "Véhicules disponibles"
menu_garage_rightlabel_out = "Sortir"

menu_garage_title = "Concessionnaire aérien"
menu_garage_subtitle = "~b~Sélectionnez votre véhicule"

menu_airplanedealer_title = "Concessionnaire aérien"
menu_airplanedealer_subtitle = "~b~Faites votre choix"
menu_airplanedealer_button_showVehicles = "Voir les véhicules disponibles"

msg_loading_server_synchronization = "En attente de la synchro. serveur..."
msg_loading_airplanedealer_vehicles = "Chargement des véhicules..."
msg_awaiting_server_response = "~r~En attente d'une réponse du serveur"
msg_awaiting_server_infos = "Récupération des informations en cours..."
msg_loading_owned_aeronefs = "Récupération de vos aéronefs..."
msg_aeronef_purchassed = "~g~Vous avez un nouveau véhicule !"
msg_not_vehicle_owner = "~r~Ce véhicule ne vous appartient pas !"
msg_no_enough_money = "~r~Vous n'avez pas assez d'argent"
msg_no_aeronefs = "Vous n'avez pas d'aéronefs"
msg_out_prefix = "[SORTI]"

blip_airplanedealer = "Concessionnaire aéronautique"
blip_garage_out = "Garage aéronefs (sortie)"
blip_garage_back = "Garage aéronefs (rentrée)"

help_open_airplanedealer = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le concessionnaire de véhicules aériens"
help_open_garage = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage aérien"
help_open_garage_back = "Appuyez sur ~INPUT_CONTEXT~ pour ranger votre vehicle"

-- Airplanes dealer position
buy_marker = vector3(1745.34, 3294.06, 41.11)
preview_position = vector3(1745.06, 3265.21, 41.26)

-- Airplanes garages
entry_points = {
    {
        open = vector3(1689.77, 3289.76, 41.15),
        outPossibilites = {
            {
                pos = vector3(1669.05, 3231.27, 40.63),
                heading = 103.76
            },

            {
                pos = vector3(1661.4, 3249.26, 40.65),
                heading = 103.76
            }
        }
    }
}

return_points = {
    vector3(1535.57, 3130.3, 40.53)
}