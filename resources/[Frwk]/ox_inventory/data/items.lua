

return	{

	['carkeys']  = {
		label = 'Car Key',
		weight = 5,
		stack = true,
		client = {
		event = 'sy_carkeys:llavesindatos'
		}
	},
	-------------Cloth----------------
	['cloth'] = {
		label = 'Tenue',
		weight = 1,
		stack = false,
		close = false,
	},
	['cloth_torso'] = {
		label = 'Veste',
		weight = 0.50,
		stack = false,
		close = false,
	},
	['cloth_tshirt'] = {
		label = 'T-Shirt',
		weight = 0.20,
		stack = false,
		close = false,
	},
	['cloth_arms'] = {
		label = 'Bras',
		weight = 0,
		stack = false,
		close = false,
	},
	['cloth_pants'] = {
		label = 'Pantalon',
		weight = 0.40,
		stack = false,
		close = false,
	},
	['cloth_shoes'] = {
		label = 'Chaussures',
		weight = 0.80,
		stack = false,
		close = false,
	},
	['cloth_decals'] = {
		label = 'Calques',
		weight = 0,
		stack = false,
		close = false,
	},
	['cloth_ears'] = {
		label = "Boucle d'Oreilles",
		weight = 0.01,
		stack = false,
		close = false,
	},
	['cloth_mask'] = {
		label = 'Masque',
		weight = 0.01,
		stack = false,
		close = false,
	},
	['cloth_bproof'] = {
		label = 'Gilet Par Balle',
		weight = 0.8,
		stack = false,
		close = false,
	},
	['cloth_chain'] = {
		label = 'Collier',
		weight = 0.03,
		stack = false,
		close = false,
	},
	['cloth_bags'] = {
		label = 'Sac',
		weight = 0.5,
		stack = false,
		close = false,
	},
	['cloth_glasses'] = {
		label = 'Lunettes',
		weight = 0.01,
		stack = false,
		close = false,
	},
	['cloth_watches'] = {
		label = 'Montre',
		weight = 0.01,
		stack = false,
		close = false,
	},
	['cloth_bracelets'] = {
		label = 'Bracelet',
		weight = 0.01,
		stack = false,
		close = false,
	},
	['cloth_helmet'] = {
		label = 'Chapeaux',
		weight = 0.05,
		stack = false,
		close = false,
	},

	-----------------------------------
	-- ILLEGAL BB
	--------------------------------

	['weed_pot'] = {
		label = 'Pot de plantation',
		weight = 1000,
		stack = true,
		close = true,
		description = 'Un pot pour planter de la weed',
		client = {
			export = 'drugs.useItem'  -- Maintenant c'est drugs.useItem direct
		}
	},
	
	['fertilizer'] = {
		label = 'Fertilisant',
		weight = 500,
		stack = true,
		close = true,
		description = 'Du fertilisant pour faire pousser les plantes'
	},
	
	['grow_light'] = {
		label = 'Lampe de croissance',
		weight = 1500,
		stack = true,
		close = true,
		description = 'Une lampe pour favoriser la croissance des plantes'
	},
	
	['weed'] = {
		label = 'Cannabis',
		weight = 100,
		stack = true,
		close = true,
		description = 'Du cannabis fraîchement récolté'
	},

	---------------------------------
	-- LEGAL BB
	['dispatch'] = {
        label = 'Dispatch Police',
        weight = 1,
        stack = false,
        close = false,
        client = {
            export = 'dispatch'
        }
    },
	
	['locker_card'] = {
		label = 'Carte de casier',
		weight = 50,
		stack = false,
		close = true,
		description = 'Carte d\'accès pour un casier'
	},
	
	['contrat_vierge'] = {
		label = 'Contrat Vierge',
		weight = 50,
		stack = true,
		close = true,
		description = 'Un contrat vierge à remplir',
		client = {
			export = 'modules.contrat_vierge',
			image = 'contrat_vierge.png'
		}
	},
	
	['contrat'] = {
		label = 'Contrat Signé',
		weight = 50,
		stack = false,
		close = true,
		description = 'Un contrat officiel signé',
		client = {
			export = 'modules.contrat'
		}
	},
	
	['carte_visite'] = {
		label = 'Carte de visite',
		weight = 1,
		stack = false,
		close = true,
		description = "Une carte de visite personnalisée",
		client = {
			image = 'carte_visite.png'
		}
	},
	
	['carte_visite_vierge'] = {
		label = 'Carte de visite vierge',
		weight = 1,
		stack = true,
		close = true,
		description = "Une carte de visite à personnaliser",
		client = {
			event = 'cartevisite:openCreationMenu'
		}
	},

	['cb'] = {
		label = 'Carte Bancaire',
		stack = false,
		weight = 0.4,
		client = {
			image = 'card_bank.png'
		}
	},

	['acetone'] = {
		label = "Acétone",
		weight = 0.01,
	},
	['ace_of_spades'] = {
		label = "As de Pique",
		weight = 0.01,
	},
	['acid'] = {
		label = "Acide",
		weight = 0.01,
	},
	['acide_lysergique'] = {
		label = "Acide Lysergique",
		weight = 0.01,
	},
	['acide_nitrique'] = {
		label = "Acide Nitrique",
		weight = 0.01,
	},
	['acier'] = {
		label = "Acier",
		weight = 0.01,
	},
	['acier_compact'] = {
		label = "Acier Compact",
		weight = 0.01,
	},
	['action_figure'] = {
		label = "Figurine d'Action",
		weight = 0.01,
	},
	['adobo'] = {
		label = "Adobo",
		weight = 0.01,
	},
	['adrenaline'] = {
		label = "Adrénaline",
		weight = 0.01,
	},
	['advancedhackware'] = {
		label = "Logiciel de Piratage modulesncé",
		weight = 0.01,
	},
	['advancedkit'] = {
		label = "Kit modulesncé",
		weight = 0.01,
	},
	['advanced_lockpick'] = {
		label = "Crochet de Serrure modulesncé",
		weight = 0.01,
	},
	['advdecryptor'] = {
		label = "Décodeur modulesncé",
		weight = 0.01,
	},
	['advrepairkit'] = {
		label = "Kit de Réparation modulesncé",
		weight = 0.01,
	},
	['afishysandwich'] = {
		label = "Sandwich de Poisson",
		weight = 0.01,
	},
	['agrafe'] = {
		label = "Agrafe",
		weight = 0.01,
	},
	['airplane_ticket'] = {
		label = "Billet d'Avion",
		weight = 0.01,
	},
	['akabe'] = {
		label = "Akabé",
		weight = 0.01,
	},
	['album'] = {
		label = "Album",
		weight = 0.01,
	},
	['alcool'] = {
		label = "Alcool",
		weight = 0.01,
	},
	['alette'] = {
		label = "Alette",
		weight = 0.01,
	},
	['alienware'] = {
		label = "Alienware",
		weight = 0.01,
	},
	['alive_chicken'] = {
		label = "Poulet Vivant",
		weight = 0.01,
	},
	['allrepairkit'] = {
		label = "Kit de Réparation Complet",
		weight = 0.01,
	},
	['aluminium'] = {
		label = "Aluminium",
		weight = 0.01,
	},
	['aluminum'] = {
		label = "Aluminum",
		weight = 0.01,
	},
	['aluminum_oxide'] = {
		label = "Oxyde d'Aluminium",
		weight = 0.01,
	},
	['american_gothic'] = {
		label = "Gothique Américain",
		weight = 0.01,
	},
	['ammonia'] = {
		label = "Ammoniac",
		weight = 0.01,
	},

-------------------- Munition --------------------

	['ammo_45acp'] = {
		label = "Munitions 45 ACP",
		weight = 0.02,
	},
	['ammo_9mm'] = {
		label = "Munitions 9MM",
		weight = 0.04,
	},
	['ammo_5.56'] = {
		label = "Munitions 5.56",
		weight = 0.05,
	},
	['ammo_musket'] = {
		label = "Munitions de Musket",
		weight = 0.05,
	},
	['ammo_7.62'] = {
		label = "Munitions 7.62",
		weight = 0.08,
	},
	['ammo_pompe'] = {
		label = "Munitions de fusil à pompe",
		weight = 0.07,
	},
    ['ammo_sniper'] = {
		label = "Munitions Sniper",
		weight = 0.10,
	},
	['ammo_rpg'] = {
		label = "Munitions RPG",
		weight = 0.25,
	},
	['ammo_grenade'] = {
		label = "Munitions de Grenade",
		weight = 0.15,
	},
	['ammo_paintball'] = {
		label = "Munitions de Paintball",
		weight = 0.15,
	},


---------------------------------------------------

	['amnesia'] = {
		label = "Amnésie",
		weight = 0.01,
	},
	['anelli'] = {
		label = "Anelli",
		weight = 0.01,
	},
	['anime_poster'] = {
		label = "Affiche d'Anime",
		weight = 0.01,
	},
	['anneau'] = {
		label = "Anneau",
		weight = 0.01,
	},
	['antidouleur'] = {
		label = "Antidouleur",
		weight = 0.01,
	},
	['antlers'] = {
		label = "Bois de Cerf",
		weight = 0.01,
	},
	['aod_cut'] = {
		label = "AOD Cut",
		weight = 0.01,
	},
	['applepie'] = {
		label = "Tarte aux Pommes",
		weight = 0.01,
	},
	['apple_iphone'] = {
		label = "iPhone Apple",
		weight = 0.01,
	},
	['armor'] = {
		label = "Armure",
		weight = 0.01,
	},
	['armor1'] = {
		label = "Armure 1",
		weight = 0.01,
	},
	['armor2'] = {
		label = "Armure 2",
		weight = 0.01,
	},
	['armor3'] = {
		label = "Armure 3",
		weight = 0.01,
	},
	['armor_plate'] = {
		label = "Plaque d'Armure",
		weight = 0.01,
	},
	['armor_plate_2'] = {
		label = "Plaque d'Armure 2",
		weight = 0.01,
	},
	['arm_xray'] = {
		label = "Radiographie du Bras",
		weight = 0.01,
	},
	['aspartam'] = {
		label = "Aspartame",
		weight = 0.01,
	},
	['aspirin'] = {
		label = "Aspirine",
		weight = 0.01,
	},
	['atelle'] = {
		label = "Atelle",
		weight = 0.01,
	},
	['autocollant'] = {
		label = "Autocollant",
		weight = 0.01,
	},
	['avocat'] = {
		label = "Avocat",
		weight = 0.01,
	},
	['badlsdtab'] = {
		label = "Bad LSD Tab",
		weight = 0.01,
	},
	['bagel'] = {
		label = "Bagel",
		weight = 0.01,
	},
	['bagel_legumes'] = {
		label = "Bagel aux Légumes",
		weight = 0.01,
	},
	['bagel_saumon'] = {
		label = "Bagel au Saumon",
		weight = 0.01,
	},
	['bagel_viande'] = {
		label = "Bagel à la Viande",
		weight = 0.01,
	},
	['bait'] = {
		label = "Appât",
		weight = 0.01,
	},
	['bakingsoda'] = {
		label = "Bicarbonate de Soude",
		weight = 0.01,
	},
	['ball_bag'] = {
		label = "Sac de Balles",
		weight = 0.01,
	},
	['bandage'] = {
		label = "Bandage",
		weight = 0.01,
	},
	['bang_cbd'] = {
		label = "Bang CBD",
		weight = 0.01,
	},
	['baquette'] = {
		label = "Baguette",
		weight = 0.01,
	},
	['barillet'] = {
		label = "Barillet",
		weight = 0.01,
	},
	['barillet_double_action'] = {
		label = "Barillet Double Action",
		weight = 0.01,
	},
	['barley'] = {
		label = "Orge",
		weight = 0.01,
	},
	['bar_420'] = {
		label = "Bar 420",
		weight = 0.01,
	},
	['basic_repair_kit'] = {
		label = "Kit de Réparation de Base",
		weight = 0.01,
	},
	['basketball'] = {
		label = "Ballon de Basket",
		weight = 0.01,
	},
	['basketball_hoop'] = {
		label = "Panier de Basket",
		weight = 0.01,
	},
	['battery'] = {
		label = "Batterie",
		weight = 0.01,
	},
	['bbtea_bleu'] = {
		label = "Thé Bleu",
		weight = 0.01,
	},
	['bbtea_marron'] = {
		label = "Thé Marron",
		weight = 0.01,
	},
	['bbtea_rose'] = {
		label = "Thé Rose",
		weight = 0.01,
	},
	['bbtea_vert'] = {
		label = "Thé Vert",
		weight = 0.01,
	},
	['bcaa'] = {
		label = "BCAA",
		weight = 0.01,
	},
	['beans'] = {
		label = "Haricots",
		weight = 0.01,
	},
	['becks'] = {
		label = "Becks",
		weight = 0.01,
	},
	['beefjerky'] = {
		label = "Jerky de Boeuf",
		weight = 0.01,
	},
	['beef_wellington'] = {
		label = "Beef Wellington",
		weight = 0.01,
	},
	['beer'] = {
		label = "Bières",
		weight = 0.01,
	},
	['beerbottle'] = {
		label = "Bouteille de Bière",
		weight = 0.01,
	},
	['bellini'] = {
		label = "Bellini",
		weight = 0.01,
	},
	['bequilles'] = {
		label = "Béquilles",
		weight = 0.01,
	},
	['berrymix'] = {
		label = "Mélange de Baies",
		weight = 0.01,
	},
	['bidon_acetone'] = {
		label = "Bidon d'Acétone",
		weight = 0.01,
	},
	['bidon_peinture'] = {
		label = "Bidon de Peinture",
		weight = 0.01,
	},
	['bierehite'] = {
		label = "Bières Hite",
		weight = 0.01,
	},
	['bigdrill'] = {
		label = "Grosse Perceuse",
		weight = 0.01,
	},
	['big_key'] = {
		label = "Grosse Clé",
		weight = 0.01,
	},
	['bimx'] = {
		label = "BIMX",
		weight = 0.01,
	},
	['binoculars'] = {
		label = "Jumelles",
		weight = 0.01,
	},
	['bironlack_spray_paint'] = {
		label = "Peinture en Spray Bironlack",
		weight = 0.01,
	},
	['bismuth'] = {
		label = "Bismuth",
		weight = 0.01,
	},
	['bitcoin'] = {
		label = "Bitcoin",
		weight = 0.01,
	},
	['blackcoffee'] = {
		label = "Café Noir",
		weight = 0.01,
	},
	['black_belt'] = {
		label = "Ceinture Noire",
		weight = 0.01,
	},
	['black_chip'] = {
		label = "Puce Noire",
		weight = 0.01,
	},
	['black_money'] = {
		label = "Argent Noir",
		weight = 0.01,
	},
	['ble'] = {
		label = "Ble",
		weight = 0.01,
	},
	['bloody_mary'] = {
		label = "Bloody Mary",
		weight = 0.01,
	},
	['blood_bag'] = {
		label = "Sac de Sang",
		weight = 0.01,
	},
	['blood_tube'] = {
		label = "Tube de Sang",
		weight = 0.01,
	},
	['blueberry'] = {
		label = "Myrtille",
		weight = 0.01,
	},
	['blue_bandana'] = {
		label = "Bandana Bleue",
		weight = 0.01,
	},
	['blue_chip'] = {
		label = "Puce Bleue",
		weight = 0.01,
	},
	['blue_ice'] = {
		label = "Glace Bleue",
		weight = 0.01,
	},
	['bmx'] = {
		label = 'BMX',
		weight = 5.0, 
		stack = false, 
		close = true, 
		client = {
			event = 'vape:bmx-useItem',
		},
	},
	['bobamilktea'] = {
		label = "Thé au Lait Boba",
		weight = 0.01,
	},
	['bob_ross_photo'] = {
		label = "Photo de Bob Ross",
		weight = 0.01,
	},
	['bodycam'] = {
		label = "Caméra de Corps",
		weight = 0.01,
	},
	['boeuf'] = {
		label = "Boeuf",
		weight = 0.01,
	},
	['boisson_cbd'] = {
		label = "Boisson CBD",
		weight = 0.01,
	},
	['boite'] = {
		label = "Boîte",
		weight = 0.01,
	},
	['bolcacahuetes'] = {
		label = "Bol de Cacahuètes",
		weight = 0.01,
	},
	['bolchips'] = {
		label = "Bol de Chips",
		weight = 0.01,
	},
	['bolnoixcajou'] = {
		label = "Bol de Noix de Cajou",
		weight = 0.01,
	},
	['bolognese'] = {
		label = "Bolognese",
		weight = 0.01,
	},
	['bolpistache'] = {
		label = "Bol de Pistaches",
		weight = 0.01,
	},
	['boltcutters'] = {
		label = "Ciseaux à Boutons",
		weight = 0.01,
	},
	['boltplate'] = {
		label = "Plaque de Boulon",
		weight = 0.01,
	},
	['bombola_nos'] = {
		label = "Bombe NOS",
		weight = 0.01,
	},
	['bondi_cut'] = {
		label = "Bondi Cut",
		weight = 0.01,
	},
	['bone_fragment'] = {
		label = "Fragment d'Os",
		weight = 0.01,
	},
	['bonsai_tree'] = {
		label = "Arbre Bonsai",
		weight = 0.01,
	},
	['boombox'] = {
		label = "Boombox",
		weight = 0.01,
	},
	['boosting_try'] = {
		label = "Essai de Boost",
		weight = 0.01,
	},
	['bottigliavuota'] = {
		label = "Bouteille Vide",
		weight = 0.01,
	},
	['boucle_diamant'] = {
		label = "Boucle en Diamant",
		weight = 0.01,
	},
	['boucle_diamant2'] = {
		label = "Boucle en Diamant 2",
		weight = 0.01,
	},
	['boullie'] = {
		label = "Bouilli",
		weight = 0.01,
	},
	['box'] = {
		label = "Boîte",
		weight = 0.01,
	},
	['boxing_glove'] = {
		label = "Gant de Boxe",
		weight = 0.01,
	},
	['boxing_glove_blue'] = {
		label = "Gant de Boxe Bleu",
		weight = 0.01,
	},
	['boxing_glove_vert'] = {
		label = "Gant de Boxe Vert",
		weight = 0.01,
	},
	['box_chocolate'] = {
		label = "Boîte de Chocolat",
		weight = 0.01,
	},
	['braab_tshirt'] = {
		label = "T-shirt Braab",
		weight = 0.01,
	},
	['bracelet'] = {
		label = "Bracelet",
		weight = 0.01,
	},
	['bracelets'] = {
		label = "Bracelets",
		weight = 0.01,
	},
	['bracelet_key'] = {
		label = "Bracelet Clé",
		weight = 0.01,
	},
	['bracelet_or_jaune'] = {
		label = "Bracelet Or Jaune",
		weight = 0.01,
	},
	['bracelet_police'] = {
		label = "Bracelet de Police",
		weight = 0.01,
	},
	['brain_mri'] = {
		label = "IRM Cérébrale",
		weight = 0.01,
	},
	['branca'] = {
		label = "Branca",
		weight = 0.01,
	},
	['brandybottle'] = {
		label = "Bouteille de Cognac",
		weight = 0.01,
	},
	['brandyglass'] = {
		label = "Verre à Cognac",
		weight = 0.01,
	},
	['brand_pack'] = {
		label = "Pack de Marque",
		weight = 0.01,
	},
	['bread'] = {
	    label = 'Pain',
		weight = 0.05,
		consumable = true,
		stack = true,
		close = false,
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'prop_sandwich_01', 
            pos = vec3(0.05, -0.02, -0.03), rot = vec3(150.0, 340.0, 170.0) },
            usetime = 2000,
        },
	},
	['boosterpack'] = {
		label = "Booster pack",
		weight = 0.01,
	},
	['breadboard'] = {
		label = "Planche à Pain",
		weight = 0.01,
	},
	['breakfast_sandwich'] = {
		label = "Sandwich du Petit Déjeuner",
		weight = 0.01,
	},
	['brembobigkit'] = {
		label = "Grand Kit Brembo",
		weight = 0.01,
	},
	['brembopads'] = {
		label = "Plaquettes Brembo",
		weight = 0.01,
	},
	['brembotrackbrakes'] = {
		label = "Freins de Piste Brembo",
		weight = 0.01,
	},
	['broche'] = {
		label = "Broche",
		weight = 0.01,
	},
	['brochure'] = {
		label = "Brochure",
		weight = 0.01,
	},
	['broken_metal'] = {
		label = "Métal Cassé",
		weight = 0.01,
	},
	['brownies'] = {
		label = "Brownies",
		weight = 0.01,
	},
	['bsfries'] = {
		label = "Frites BS",
		weight = 0.01,
	},
	['bubbashrimp'] = {
		label = "Crevettes Bubbah",
		weight = 0.01,
	},
	['bubblewafe'] = {
		label = "Gaufre Bulle",
		weight = 0.01,
	},
	['bubble_tea'] = {
		label = "Thé aux Bulles",
		weight = 0.01,
	},
	['bucket'] = {
		label = "Seau",
		weight = 0.01,
	},
	['bulgogi'] = {
		label = "Bulgogi",
		weight = 0.01,
	},
	['bulletproof'] = {
		label = "Résistant aux Balles",
		weight = 0.01,
	},
	['bungeoppang'] = {
		label = "Bungeoppang",
		weight = 0.01,
	},
	['buns'] = {
		label = "Petits Pains",
		weight = 0.01,
	},
	['burger'] = {
		label = "Burger",
		weight = 0.01,
	},
	['burger_love'] = {
		label = "Amour du Burger",
		weight = 0.01,
	},
	['burial_mask'] = {
		label = "Masque Funéraire",
		weight = 0.01,
	},
	['burrito'] = {
		label = "Burrito",
		weight = 0.01,
	},
	['butter'] = {
		label = "Beurre",
		weight = 0.01,
	},
	['b_belt_01'] = {
		label = "Ceinture B 01",
		weight = 0.01,
	},
	['b_belt_02'] = {
		label = "Ceinture B 02",
		weight = 0.01,
	},
	['b_cap'] = {
		label = "Casquette B",
		weight = 0.01,
	},
	['b_dress_01'] = {
		label = "Robe B 01",
		weight = 0.01,
	},
	['b_dress_02'] = {
		label = "Robe B 02",
		weight = 0.01,
	},
	['b_dress_03'] = {
		label = "Robe B 03",
		weight = 0.01,
	},
	['b_dress_04'] = {
		label = "Robe B 04",
		weight = 0.01,
	},
	['b_shirt_01'] = {
		label = "Chemise B 01",
		weight = 0.01,
	},
	['b_shirt_02'] = {
		label = "Chemise B 02",
		weight = 0.01,
	},
	['b_shirt_03'] = {
		label = "Chemise B 03",
		weight = 0.01,
	},
	['b_shirt_04'] = {
		label = "Chemise B 04",
		weight = 0.01,
	},
	['b_slipper_01'] = {
		label = "Chausson B 01",
		weight = 0.01,
	},
	['b_slipper_02'] = {
		label = "Chausson B 02",
		weight = 0.01,
	},
	['b_slipper_03'] = {
		label = "Chausson B 03",
		weight = 0.01,
	},
	['b_sock'] = {
		label = "Chaussette B",
		weight = 0.01,
	},
	['b_suit'] = {
		label = "Costume B",
		weight = 0.01,
	},
	['b_sweater_01'] = {
		label = "Pull B 01",
		weight = 0.01,
	},
	['b_sweater_02'] = {
		label = "Pull B 02",
		weight = 0.01,
	},
	['b_sweater_03'] = {
		label = "Pull B 03",
		weight = 0.01,
	},
	['b_sweater_04'] = {
		label = "Pull B 04",
		weight = 0.01,
	},
	['b_tracksuit_01'] = {
		label = "Survêtement B 01",
		weight = 0.01,
	},
	['b_tracksuit_02'] = {
		label = "Survêtement B 02",
		weight = 0.01,
	},
	['b_tracksuit_03'] = {
		label = "Survêtement B 03",
		weight = 0.01,
	},
	['b_tracksuit_04'] = {
		label = "Survêtement B 04",
		weight = 0.01,
	},
	['b_tracksuit_05'] = {
		label = "Survêtement B 05",
		weight = 0.01,
	},
	['b_tracksuit_06'] = {
		label = "Survêtement B 06",
		weight = 0.01,
	},
	['b_tshirt_01'] = {
		label = "T-shirt B 01",
		weight = 0.01,
	},
	['b_tshirt_02'] = {
		label = "T-shirt B 02",
		weight = 0.01,
	},
	['b_tshirt_03'] = {
		label = "T-shirt B 03",
		weight = 0.01,
	},
	['b_tshirt_04'] = {
		label = "T-shirt B 04",
		weight = 0.01,
	},
	['b_tshirt_05'] = {
		label = "T-shirt B 05",
		weight = 0.01,
	},
	['b_tshirt_06'] = {
		label = "T-shirt B 06",
		weight = 0.01,
	},
	['cabillaud_plate'] = {
		label = "Assiette de Cabillaud",
		weight = 0.01,
	},
	['cactus'] = {
		label = "Cactus",
		weight = 0.01,
	},
	['cadavre_femme'] = {
		label = "Cadavre Femme",
		weight = 0.01,
	},
	['cadavre_homme'] = {
		label = "Cadavre Homme",
		weight = 0.01,
	},
	['cafedeolla'] = {
		label = "Café de Olla",
		weight = 0.01,
	},
	['caffe'] = {
		label = "Café",
		weight = 0.01,
	},
	['cagedcrow'] = {
		label = "Corbeau En Cage",
		weight = 0.01,
	},
	['cagedrabbit'] = {
		label = "Lapin En Cage",
		weight = 0.01,
	},
	['cagehen'] = {
		label = "Poulette En Cage",
		weight = 0.01,
	},
	['cagoule'] = {
		label = "Cagoule",
		weight = 0.01,
	},
	['calice_rosso'] = {
		label = "Calice Rouge",
		weight = 0.01,
	},
	['californium_252'] = {
		label = "Californium 252",
		weight = 0.01,
	},
	['camera'] = {
		label = "Caméra",
		weight = 0.01,
	},
	['camille'] = {
		label = "Camille",
		weight = 0.01,
	},
	['candy'] = {
		label = "Bonbon",
		weight = 0.01,
	},
	['candycane'] = {
		label = "Canne en Sucre",
		weight = 0.01,
	},
	['canna'] = {
		label = "Canna",
		weight = 0.01,
	},
	['cannabis_absinthe'] = {
		label = "Cannabis Absinthe",
		weight = 0.01,
	},
	['cannabis_brownie'] = {
		label = "Brownie au Cannabis",
		weight = 0.01,
	},
	['cannabis_gummies'] = {
		label = "Gummies au Cannabis",
		weight = 0.01,
	},
	['cannabis_lotion'] = {
		label = "Lotion au Cannabis",
		weight = 0.01,
	},
	['cannadapesca'] = {
		label = "Cannada Pesca",
		weight = 0.01,
	},
	['canneles'] = {
		label = "Cannelés",
		weight = 0.01,
	},
	['canon'] = {
		label = "Canon",
		weight = 0.01,
	},
	['canon_ak47'] = {
		label = "Canon AK47",
		weight = 0.01,
	},
	['canon_aku'] = {
		label = "Canon AKU",
		weight = 0.01,
	},
	['canon_m4'] = {
		label = "Canon M4",
		weight = 0.01,
	},
	['canon_pompe'] = {
		label = "Canon à Pompe",
		weight = 0.01,
	},
	['cappuccino'] = {
		label = "Cappuccino",
		weight = 0.01,
	},
	['caprisun'] = {
		label = "Capri Sun",
		weight = 0.01,
	},
	['caramelle'] = {
		label = "Caramelle",
		weight = 0.01,
	},
	['carbon'] = {
		label = "Carbone",
		weight = 0.01,
	},
	['carbonara'] = {
		label = "Carbonara",
		weight = 0.01,
	},
	['carbone'] = {
		label = "Carbone",
		weight = 0.01,
	},
	['carcassa_1'] = {
		label = "Carcasse 1",
		weight = 0.01,
	},
	['carcassa_2'] = {
		label = "Carcasse 2",
		weight = 0.01,
	},
	['carcassa_3'] = {
		label = "Carcasse 3",
		weight = 0.01,
	},
	['carcassa_4'] = {
		label = "Carcasse 4",
		weight = 0.01,
	},
	['id_card'] = {
		label = "Carte d'identité",
		weight = 0.01,
		stack = false,
		close = true,
		server = {
			export = "kernel.fbcard"
		}
	},
		
	['id_sasp'] = {
		label = "Carte SASP",
		weight = 0.01,
	},
	['id_press'] = {
		label = "Carte PRESS",
		weight = 0.01,
	},
	['id_lsmc'] = {
		label = "Carte LSMC",
		weight = 0.01,
	},
	['id_avocat'] = {
		label = "Carte Avocat",
		weight = 0.01,
	},
	['id_ppa'] = {
		label = "Carte PPA",
		weight = 0.01,
	},
	['card_18fit'] = {
		label = "Carte 18 Fit",
		weight = 0.01,
	},
	['card_aerien'] = {
		label = "Carte Aérienne",
		weight = 0.01,
	},
	['card_avion'] = {
		label = "Carte Avion",
		weight = 0.01,
	},
	['card_avocat'] = {
		label = "Carte Avocat",
		weight = 0.01,
	},
	['card_bateau'] = {
		label = "Carte Bateau",
		weight = 0.01,
	},
	['card_bcso'] = {
		label = "Carte BCSO",
		weight = 0.01,
	},
	['card_bike'] = {
		label = "Carte Vélo",
		weight = 0.01,
	},
	['card_doj'] = {
		label = "Carte DOJ",
		weight = 0.01,
	},
	['card_driver_license'] = {
		label = "Permis de Conduire",
		weight = 0.01,
	},
	['card_enqueteur'] = {
		label = "Carte Enquêteur",
		weight = 0.01,
	},
	['card_fib'] = {
		label = "Carte FIB",
		weight = 0.01,
	},
	['card_firearm'] = {
		label = "Carte d'Arme à Feu",
		weight = 0.01,
	},
	['card_gouv'] = {
		label = "Carte Gouvernementale",
		weight = 0.01,
	},
	['card_gouv_cayo'] = {
		label = "Carte Gouvernementale Cayo",
		weight = 0.01,
	},
	['card_grise'] = {
		label = "Carte Grise",
		weight = 0.01,
	},
	['card_helico'] = {
		label = "Carte Hélicoptère",
		weight = 0.01,
	},
	['card_hunter'] = {
		label = "Carte Chasseur",
		weight = 0.01,
	},
	['card_iaa'] = {
		label = "Carte IAA",
		weight = 0.01,
	},
	['card_id'] = {
		label = "Carte d'Identité",
		weight = 0.01,
	},
	['card_idcard_cayo'] = {
		label = "Carte d'Identité Cayo",
		weight = 0.01,
	},
	['card_id_cayo'] = {
		label = "Carte ID Cayo",
		weight = 0.01,
	},
	['card_merryweather'] = {
		label = "Carte Merryweather",
		weight = 0.01,
	},
	['card_mutuelle'] = {
		label = "Carte Mutuelle",
		weight = 0.01,
	},
	['card_paramedic'] = {
		label = "Carte Paramedic",
		weight = 0.01,
	},
	['card_plongee'] = {
		label = "Carte Plongée",
		weight = 0.01,
	},
	['card_police'] = {
		label = "Carte Police",
		weight = 0.01,
	},
	['card_press'] = {
		label = "Carte Presse",
		weight = 0.01,
	},
	['card_school_cantine'] = {
		label = "Carte Cantine Scolaire",
		weight = 0.01,
	},
	['card_school_prof'] = {
		label = "Carte Professeur Scolaire",
		weight = 0.01,
	},
	['card_school_staff'] = {
		label = "Carte Personnel Scolaire",
		weight = 0.01,
	},
	['card_school_study'] = {
		label = "Carte Étude Scolaire",
		weight = 0.01,
	},
	['card_security'] = {
		label = "Carte Sécurité",
		weight = 0.01,
	},
	['card_security_gouv_cayo'] = {
		label = "Carte Sécurité Gouvernementale Cayo",
		weight = 0.01,
	},
	['card_sidaction'] = {
		label = "Carte Sidaction",
		weight = 0.01,
	},
	['card_truck'] = {
		label = "Carte Camion",
		weight = 0.01,
	},
	['card_visa_cayo'] = {
		label = "Carte Visa Cayo",
		weight = 0.01,
	},
	['card_visa_lc'] = {
		label = "Carte Visa LC",
		weight = 0.01,
	},
	['card_visa_lossantos'] = {
		label = "Carte Visa Los Santos",
		weight = 0.01,
	},
	['keys'] = {
		label = "Clé de voiture N°",
		weight = 15,
	},
	['carne'] = {
		label = "Viande",
		weight = 0.01,
	},
	['carokit'] = {
		label = "Kit de Caro",
		weight = 0.01,
	},
	['carott_juice'] = {
		label = "Jus de Carotte",
		weight = 0.01,
	},
	['carott_seed'] = {
		label = "Graine de Carotte",
		weight = 0.01,
	},
	['carpaccio'] = {
		label = "Carpaccio",
		weight = 0.01,
	},
	['carrot'] = {
		label = "Carotte",
		weight = 0.01,
	},
	['carry_bag'] = {
		label = "Sac à Porter",
		weight = 0.01,
	},
	['carte_membre'] = {
		label = "Carte Membre",
		weight = 0.01,
	},
	['carte_sport'] = {
		label = "Carte Sport",
		weight = 0.01,
	},
	['cartons'] = {
		label = "Cartons",
		weight = 0.01,
	},
	['carton_buvard'] = {
		label = "Carton Buvard",
		weight = 0.01,
	},
	['car_battery'] = {
		label = "Batterie de Voiture",
		weight = 0.01,
	},
	['car_hood'] = {
		label = "Capot de Voiture",
		weight = 0.01,
	},
	['car_key'] = {
		label = "Clé de Voiture",
		weight = 0.01,
	},
	['casein'] = {
		label = "Caséine",
		weight = 0.01,
	},
	['caseofbeer'] = {
		label = "Caisse de Bière",
		weight = 0.01,
	},
	['cash'] = {
		label = "Espèces",
		weight = 0.01,
	},
	['cash_roll'] = {
		label = "Rouleau de Cash",
		weight = 0.01,
	},
	['cash_stack'] = {
		label = "Pile de Cash",
		weight = 0.01,
	},
	['casino_ticket'] = {
		label = "Billet de Casino",
		weight = 0.01,
	},
	['casino_ticket_car'] = {
		label = "Billet de Casino (Voiture)",
		weight = 0.01,
	},
	['casino_ticket_clothing'] = {
		label = "Billet de Casino (Vêtements)",
		weight = 0.01,
	},
	['casino_ticket_coins'] = {
		label = "Billet de Casino (Pièces)",
		weight = 0.01,
	},
	['casino_ticket_discount'] = {
		label = "Billet de Casino (Remise)",
		weight = 0.01,
	},
	['casino_ticket_dollars'] = {
		label = "Billet de Casino (Dollars)",
		weight = 0.01,
	},
	['casino_ticket_rp'] = {
		label = "Billet de Casino (RP)",
		weight = 0.01,
	},
	['casio_watch'] = {
		label = "Montre Casio",
		weight = 0.01,
	},
	['casquette'] = {
		label = "Casquette",
		weight = 0.01,
	},
	['cbd'] = {
		label = "CBD",
		weight = 0.01,
	},
	['cbd_cookie'] = {
		label = "Cookie CBD",
		weight = 0.01,
	},
	['cbd_lotion'] = {
		label = "Lotion CBD",
		weight = 0.01,
	},
	['cbd_oil'] = {
		label = "Huile CBD",
		weight = 0.01,
	},
	['cbd_seed'] = {
		label = "Graine de CBD",
		weight = 0.01,
	},
	['cbd_shampoing'] = {
		label = "Shampoing CBD",
		weight = 0.01,
	},
	['cbd_sucette'] = {
		label = "Sucette CBD",
		weight = 0.01,
	},
	['cbd_untrimmed'] = {
		label = "CBD Non Taillé",
		weight = 0.01,
	},
	['cb_a_b'] = {
		label = "CB A B",
		weight = 0.01,
	},
	['cb_a_g'] = {
		label = "CB A G",
		weight = 0.01,
	},
	['cb_a_gold'] = {
		label = "CB A Or",
		weight = 0.01,
	},
	['cb_a_r'] = {
		label = "CB A R",
		weight = 0.01,
	},
	['cb_a_w'] = {
		label = "CB A W",
		weight = 0.01,
	},
	['cb_g_b'] = {
		label = "CB G B",
		weight = 0.01,
	},
	['cb_g_g'] = {
		label = "CB G G",
		weight = 0.01,
	},
	['cb_g_p'] = {
		label = "CB G P",
		weight = 0.01,
	},
	['cb_g_y'] = {
		label = "CB G Y",
		weight = 0.01,
	},
	['cchip'] = {
		label = "Cchip",
		weight = 0.01,
	},
	['certificate'] = {
		label = "Certificat",
		weight = 0.01,
	},
	['certificato_medico'] = {
		label = "Certificat Médical",
		weight = 0.01,
	},
	['cerveau'] = {
		label = "Cerveau",
		weight = 0.01,
	},
	['ceviche'] = {
		label = "Ceviche",
		weight = 0.01,
	},
	['chaine_corde'] = {
		label = "Chaîne en Corde",
		weight = 0.01,
	},
	['chaine_hugoboss'] = {
		label = "Chaîne Hugo Boss",
		weight = 0.01,
	},
	['champagne'] = {
		label = "Champagne",
		weight = 0.01,
	},
	['champagnebottle'] = {
		label = "Bouteille de Champagne",
		weight = 0.01,
	},
	['champagneglass'] = {
		label = "Verre à Champagne",
		weight = 0.01,
	},
	['champagne_glass'] = {
		label = "Verre en Champagne",
		weight = 0.01,
	},
	['champignon_ascomycete'] = {
		label = "Champignon Ascomycète",
		weight = 0.01,
	},
	['champion_belt'] = {
		label = "Ceinture de Champion",
		weight = 0.01,
	},
	['champurrado'] = {
		label = "Champurrado",
		weight = 0.01,
	},
	['chapeau'] = {
		label = "Chapeau",
		weight = 0.01,
	},
	['charbon'] = {
		label = "Charbon",
		weight = 0.01,
	},
	['charbon_bag'] = {
		label = "Sac de Charbon",
		weight = 0.01,
	},
	['charbon_mix'] = {
		label = "Mélange de Charbon",
		weight = 0.01,
	},
	['chargeur_skorpion'] = {
		label = "Chargeur Skorpion",
		weight = 0.01,
	},
	['char_siu'] = {
		label = "Char Siu",
		weight = 0.01,
	},
	['chassis_uzi'] = {
		label = "Châssis Uzi",
		weight = 0.01,
	},
	['chaussure'] = {
		label = "Chaussure",
		weight = 0.01,
	},
	['cheapwatch'] = {
		label = "Montre Bon Marché",
		weight = 0.01,
	},
	['cheese'] = {
		label = "Fromage",
		weight = 0.01,
	},
	['cheesebows'] = {
		label = "Cheesebows",
		weight = 0.01,
	},
	['cheeseburger'] = {
		label = "Cheeseburger",
		weight = 0.01,
	},
	['cheesecake'] = {
		label = "Cheesecake",
		weight = 0.01,
	},
	['cheesychips'] = {
		label = "Chips Fromagers",
		weight = 0.01,
	},
	['cheque'] = {
		label = "Chèque",
		weight = 0.01,
	},
	['cherenkovvodka'] = {
		label = "Vodka Tcherenkov",
		weight = 0.01,
	},
	['chest_xray'] = {
		label = "Radiographie du Torse",
		weight = 0.01,
	},
	['chevre'] = {
		label = "Chèvre",
		weight = 0.01,
	},
	['chewinggum'] = {
		label = "Chewing Gum",
		weight = 0.01,
	},
	['chicha_cbd'] = {
		label = "Chicha CBD",
		weight = 0.01,
	},
	['chickensandwich'] = {
		label = "Sandwich au Poulet",
		weight = 0.01,
	},
	['chickenwrap'] = {
		label = "Wrap au Poulet",
		weight = 0.01,
	},
	['chicken_bucket'] = {
		label = "Seau de Poulet",
		weight = 0.01,
	},
	['chickfries'] = {
		label = "Fries de Poulet",
		weight = 0.01,
	},
	['chicktex'] = {
		label = "Chick Tex",
		weight = 0.01,
	},
	['chicktoast'] = {
		label = "Toast au Poulet",
		weight = 0.01,
	},
	['childrens_book'] = {
		label = "Livre pour Enfants",
		weight = 0.01,
	},
	['chili'] = {
		label = "Chili",
		weight = 0.01,
	},
	['chilliwilly'] = {
		label = "Chili Willy",
		weight = 0.01,
	},
	['chips'] = {
		label = "Chips",
		weight = 0.01,
	},
	['chipscheese'] = {
		label = "Chips au Fromage",
		weight = 0.01,
	},
	['chipshabanero'] = {
		label = "Chips Habanero",
		weight = 0.01,
	},
	['chipsribs'] = {
		label = "Chips de Côtes",
		weight = 0.01,
	},
	['chipssalt'] = {
		label = "Chips Salés",
		weight = 0.01,
	},
	['chloroform'] = {
		label = "Chloroforme",
		weight = 0.01,
	},
	['chocolatebar'] = {
		label = "Barre Chocolatée",
		weight = 0.01,
	},
	['chocolatechipcookie'] = {
		label = "Cookie aux Pépites de Chocolat",
		weight = 0.01,
	},
	['chocolatefudge'] = {
		label = "Fudge au Chocolat",
		weight = 0.01,
	},
	['chocolate_bar'] = {
		label = "Barre de Chocolat",
		weight = 0.01,
	},
	['chop_suey'] = {
		label = "Chop Suey",
		weight = 0.01,
	},
	['churro'] = {
		label = "Churro",
		weight = 0.01,
	},
	['ciambella'] = {
		label = "Ciambella",
		weight = 0.01,
	},
	['cibo1'] = {
		label = "Cibo 1",
		weight = 0.01,
	},
	['cibo2'] = {
		label = "Cibo 2",
		weight = 0.01,
	},
	['cidre'] = {
		label = "Cidre",
		weight = 0.01,
	},
	['cidre_pression'] = {
		label = "Cidre Pression",
		weight = 0.01,
	},
	['cigar'] = {
		label = "Cigare",
		weight = 0.01,
	},
	['cigarett'] = {
		label = "Cigarette",
		weight = 0.01,
	},
	['cigarette2'] = {
		label = "Cigarette 2",
		weight = 0.01,
	},
	['cigar_box'] = {
		label = "Boîte de Cigares",
		weight = 0.01,
	},
	['cioccolata_calda'] = {
		label = "Chocolat Chaud",
		weight = 0.01,
	},
	['cipolla'] = {
		label = "Oignon",
		weight = 0.01,
	},
	['circuit_board'] = {
		label = "Carte de Circuit",
		weight = 0.01,
	},
	['citrate_monosodique'] = {
		label = "Citrate Monosodique",
		weight = 0.01,
	},
	['civ_trophy'] = {
		label = "Trophée Civ",
		weight = 0.01,
	},
	['clamp'] = {
		label = "Pince",
		weight = 0.01,
	},
	['cleaningkit'] = {
		label = "Kit de Nettoyage",
		weight = 0.01,
	},
	['cleaning_goods'] = {
		label = "Produits de Nettoyage",
		weight = 0.01,
	},
	['cle_ancienne'] = {
		label = "Clé Ancienne",
		weight = 0.01,
	},
	['cle_copper'] = {
		label = "Clé Cuivre",
		weight = 0.01,
	},
	['cle_menottes'] = {
		label = "Clé de Menottes",
		weight = 0.01,
	},
	['cle_or'] = {
		label = "Clé en Or",
		weight = 0.01,
	},
	['cle_silver'] = {
		label = "Clé en Argent",
		weight = 0.01,
	},
	['clover'] = {
		label = "Trèfle",
		weight = 0.01,
	},
	['clubsandwich'] = {
		label = "Sandwich Club",
		weight = 0.01,
	},
	['cluckin_balls'] = {
		label = "Cluckin' Balls",
		weight = 0.01,
	},
	['cluckin_drink'] = {
		label = "Boisson Cluckin'",
		weight = 0.01,
	},
	['cluckin_fries'] = {
		label = "Frites Cluckin'",
		weight = 0.01,
	},
	['cluckin_rings'] = {
		label = "Anneaux Cluckin'",
		weight = 0.01,
	},
	['clutch'] = {
		label = "Embrayage",
		weight = 0.01,
	},
	['clutchgear'] = {
		label = "Engrenage d'Embrayage",
		weight = 0.01,
	},
	['coagulant'] = {
		label = "Coagulant",
		weight = 0.01,
	},
	['cocacola'] = {
		label = "Coca-Cola",
		weight = 0.01,
	},
	['cocaina1'] = {
		label = "Cocaïne 1",
		weight = 0.01,
	},
	['cocaine'] = {
		label = "Cocaïne",
		weight = 0.01,
	},
	['cocaine_30'] = {
		label = "Cocaïne 30",
		weight = 0.01,
	},
	['cocaine_45'] = {
		label = "Cocaïne 45",
		weight = 0.01,
	},
	['cocaine_60'] = {
		label = "Cocaïne 60",
		weight = 0.01,
	},
	['cocaine_70'] = {
		label = "Cocaïne 70",
		weight = 0.01,
	},
	['cocaine_90'] = {
		label = "Cocaïne 90",
		weight = 0.01,
	},
	['cocaine_baggy'] = {
		label = "Sac de Cocaïne",
		weight = 0.01,
	},
	['cocaine_brick'] = {
		label = "Brique de Cocaïne",
		weight = 0.01,
	},
	['cocktail_rossini'] = {
		label = "Cocktail Rossini",
		weight = 0.01,
	},
	['cocoa_butter'] = {
		label = "Beurre de Cacao",
		weight = 0.01,
	},
	['coeur'] = {
		label = "Cœur",
		weight = 0.01,
	},
	['coffee'] = {
		label = "Café",
		weight = 0.01,
	},
	['coffeecake'] = {
		label = "Gâteau au Café",
		weight = 0.01,
	},
	['cognacbottle'] = {
		label = "Bouteille de Cognac",
		weight = 0.01,
	},
	['cognacglass'] = {
		label = "Verre à Cognac",
		weight = 0.01,
	},
	['coke'] = {
		label = "Coca",
		weight = 0.01,
	},
	['cokebrick'] = {
		label = "Brique de Coca",
		weight = 0.01,
	},
	['cokeounce'] = {
		label = "Ounce de Coca",
		weight = 0.01,
	},
	['coke_brick'] = {
		label = "Brique de Coca",
		weight = 0.01,
	},
	['coke_brick_30'] = {
		label = "Brique de Coca 30",
		weight = 0.01,
	},
	['coke_brick_45'] = {
		label = "Brique de Coca 45",
		weight = 0.01,
	},
	['coke_brick_60'] = {
		label = "Brique de Coca 60",
		weight = 0.01,
	},
	['coke_brick_70'] = {
		label = "Brique de Coca 70",
		weight = 0.01,
	},
	['coke_brick_90'] = {
		label = "Brique de Coca 90",
		weight = 0.01,
	},
	['coke_brick_simple'] = {
		label = "Brique de Coca Simple",
		weight = 0.01,
	},
	['coke_pooch'] = {
		label = "Coca Pooch",
		weight = 0.01,
	},
	['coke_seed'] = {
		label = "Graine de Coca",
		weight = 0.01,
	},
	['coke_small_brick'] = {
		label = "Petite Brique de Coca",
		weight = 0.01,
	},
	['cola'] = {
		label = "Cola",
		weight = 0.01,
	},
	['coladragon'] = {
		label = "Cola Dragon",
		weight = 0.01,
	},
	['collier_argent'] = {
		label = "Collier en Argent",
		weight = 0.01,
	},
	['collier_rubis'] = {
		label = "Collier en Rubis",
		weight = 0.01,
	},
	['composition'] = {
		label = "Composition",
		weight = 0.01,
	},
	['compresse'] = {
		label = "Compresse",
		weight = 0.01,
	},
	['computer_chip'] = {
		label = "Puce d'Ordinateur",
		weight = 0.01,
	},
	['contravention'] = {
		label = "Contravention",
		weight = 0.01,
	},
	['cookie'] = {
		label = "Cookie",
		weight = 0.01,
	},
	['cooking_trophy'] = {
		label = "Trophée de Cuisine",
		weight = 0.01,
	},
	['copper'] = {
		label = "Cuivre",
		weight = 0.01,
	},
	['copperore'] = {
		label = "Minerai de Cuivre",
		weight = 0.01,
	},
	['copper_ingot'] = {
		label = "Lingot de Cuivre",
		weight = 0.01,
	},
	['copper_wire'] = {
		label = "Fil de Cuivre",
		weight = 0.01,
	},
	['coquillette'] = {
		label = "Coquillette",
		weight = 0.01,
	},
	['corail'] = {
		label = "Corail",
		weight = 0.01,
	},
	['corn'] = {
		label = "Maïs",
		weight = 0.01,
	},
	['cornille'] = {
		label = "Cornille",
		weight = 0.01,
	},
	['corn_grilled'] = {
		label = "Maïs Grillé",
		weight = 0.01,
	},
	['corn_seed'] = {
		label = "Graine de Maïs",
		weight = 0.01,
	},
	['corona'] = {
		label = "Corona",
		weight = 0.01,
	},
	['corps_ak47'] = {
		label = "Corps AK47",
		weight = 0.01,
	},
	['corps_aku'] = {
		label = "Corps AKU",
		weight = 0.01,
	},
	['corps_canon_scie'] = {
		label = "Corps Canon Scié",
		weight = 0.01,
	},
	['corps_double_action'] = {
		label = "Corps Double Action",
		weight = 0.01,
	},
	['corps_g36'] = {
		label = "Corps G36",
		weight = 0.01,
	},
	['corps_m4'] = {
		label = "Corps M4",
		weight = 0.01,
	},
	['corps_skorpion'] = {
		label = "Corps Skorpion",
		weight = 0.01,
	},
	['corps_tec9'] = {
		label = "Corps Tec9",
		weight = 0.01,
	},
	['corps_uzi'] = {
		label = "Corps Uzi",
		weight = 0.01,
	},
	['corticoide'] = {
		label = "Corticoïde",
		weight = 0.01,
	},
	['coton'] = {
		label = "Coton",
		weight = 0.01,
	},
	['cottoncandy'] = {
		label = "Barbe à Papa",
		weight = 0.01,
	},
	['cougar_pelt'] = {
		label = "Peau de Cougar",
		weight = 0.01,
	},
	['cougar_tooth'] = {
		label = "Dent de Cougar",
		weight = 0.01,
	},
	['counterfeit_cash'] = {
		label = "Cash Falsifié",
		weight = 0.01,
	},
	['coupon_25'] = {
		label = "Coupon 25",
		weight = 0.01,
	},
	['coupon_fifteen'] = {
		label = "Coupon Quinze",
		weight = 0.01,
	},
	['coupon_ten'] = {
		label = "Coupon Dix",
		weight = 0.01,
	},
	['crab_cakes'] = {
		label = "Gâteaux de Crabe",
		weight = 0.01,
	},
	['crack'] = {
		label = "Crack",
		weight = 0.01,
	},
	['crackbrick'] = {
		label = "Brique de Crack",
		weight = 0.01,
	},
	['crackounce'] = {
		label = "Ounce de Crack",
		weight = 0.01,
	},
	['crack_cocaine'] = {
		label = "Cocaïne Crack",
		weight = 0.01,
	},
	['crack_cocaine_dried'] = {
		label = "Cocaïne Crack Séché",
		weight = 0.01,
	},
	['crack_cocaine_fine'] = {
		label = "Cocaïne Crack Fine",
		weight = 0.01,
	},
	['crack_cracked1'] = {
		label = "Crack Fissuré 1",
		weight = 0.01,
	},
	['crack_cracked2'] = {
		label = "Crack Fissuré 2",
		weight = 0.01,
	},
	['crack_farineux1'] = {
		label = "Crack Farineux 1",
		weight = 0.01,
	},
	['crack_farineux2'] = {
		label = "Crack Farineux 2",
		weight = 0.01,
	},
	['crack_pooch'] = {
		label = "Crack Pooch",
		weight = 0.01,
	},
	['crack_smooth1'] = {
		label = "Crack Lisse 1",
		weight = 0.01,
	},
	['crack_smooth2'] = {
		label = "Crack Lisse 2",
		weight = 0.01,
	},
	-- ['craftingtable'] = {
	-- 	label = "Table de Fabrication",
	-- 	weight = 0.01,
	-- },
	['creme_brulee'] = {
		label = "Crème Brûlée",
		weight = 0.01,
	},
	['croissant'] = {
		label = "Croissant",
		weight = 0.01,
	},
	['croquettes'] = {
		label = "Croquettes",
		weight = 0.01,
	},
	['crosse_ak47'] = {
		label = "Crosse AK47",
		weight = 0.01,
	},
	['crosse_double_canon'] = {
		label = "Crosse Double Canon",
		weight = 0.01,
	},
	['crosse_g36'] = {
		label = "Crosse G36",
		weight = 0.01,
	},
	['crosse_m4'] = {
		label = "Crosse M4",
		weight = 0.01,
	},
	['crosse_skorpion'] = {
		label = "Crosse Skorpion",
		weight = 0.01,
	},
	['crostata'] = {
		label = "Crostata",
		weight = 0.01,
	},
	['crunchytaco'] = {
		label = "Taco Croquant",
		weight = 0.01,
	},
	['cryptostick'] = {
		label = "Clé USB Cryptée",
		weight = 0.01,
	},
	['cult_necklace'] = {
		label = "Collier de Culte",
		weight = 0.01,
	},
	['cup'] = {
		label = "Tasse",
		weight = 0.01,
	},
	['cupcake'] = {
		label = "Cupcake",
		weight = 0.01,
	},
	['cursed_katana'] = {
		label = "Katana Maudit",
		weight = 0.01,
	},
	['cut_money'] = {
		label = "Argent Découpé",
		weight = 0.01,
	},
	['dakdoritang'] = {
		label = "Dakdoritang",
		weight = 0.01,
	},
	['dakgangjeong'] = {
		label = "Dakgangjeong",
		weight = 0.01,
	},
	['dalgona'] = {
		label = "Dalgona",
		weight = 0.01,
	},
	['damiskingcrab'] = {
		label = "Crabe King Dami",
		weight = 0.01,
	},
	['dango'] = {
		label = "Dango",
		weight = 0.01,
	},
	['decrypter_enzo'] = {
		label = "Décrypteur Enzo",
		weight = 0.01,
	},
	['decrypter_fv2'] = {
		label = "Décrypteur FV2",
		weight = 0.01,
	},
	['decrypter_sess'] = {
		label = "Décrypteur Sess",
		weight = 0.01,
	},
	['decryptor'] = {
		label = "Décrypteur",
		weight = 0.01,
	},
	['deer_hide'] = {
		label = "Peau de Cerf",
		weight = 0.01,
	},
	['defibrilateur'] = {
		label = "Défibrillateur",
		weight = 0.01,
	},
	['dendrogyra_coral'] = {
		label = "Corail Dendrogyra",
		weight = 0.01,
	},
	['dent'] = {
		label = "Dent",
		weight = 0.01,
	},
	['designerbracelet'] = {
		label = "Bracelet de Designer",
		weight = 0.01,
	},
	['designerearring'] = {
		label = "Boucles d'Oreilles de Designer",
		weight = 0.01,
	},
	['designernecklace'] = {
		label = "Collier de Designer",
		weight = 0.01,
	},
	['designerring'] = {
		label = "Bague de Designer",
		weight = 0.01,
	},
	['designerwatch'] = {
		label = "Montre de Designer",
		weight = 0.01,
	},
	['detendeur_aku'] = {
		label = "Détendeur AKU",
		weight = 0.01,
	},
	['diamante'] = {
		label = "Diamante",
		weight = 0.01,
	},
	['diamanti'] = {
		label = "Diamants",
		weight = 0.01,
	},
	['diamond'] = {
		label = "Diamant",
		weight = 0.01,
	},
	['diamondcavier'] = {
		label = "Caviar de Diamant",
		weight = 0.01,
	},
	['diamondicecream'] = {
		label = "Glace au Diamant",
		weight = 0.01,
	},
	['diamondlobster'] = {
		label = "Homard au Diamant",
		weight = 0.01,
	},
	['diamondring'] = {
		label = "Bague en Diamant",
		weight = 0.01,
	},
	['diamondwagyusteak'] = {
		label = "Steak Wagyu au Diamant",
		weight = 0.01,
	},
	['diamondwater'] = {
		label = "Eau au Diamant",
		weight = 0.01,
	},
	['diamond_chessboard'] = {
		label = "Échiquier en Diamant",
		weight = 0.01,
	},
	['diamond_necklace'] = {
		label = "Collier en Diamant",
		weight = 0.01,
	},
	['diamond_record'] = {
		label = "Disque en Diamant",
		weight = 0.01,
	},
	['diamond_ring'] = {
		label = "Bague en Diamant",
		weight = 0.01,
	},
	['diamond_skull'] = {
		label = "Crâne en Diamant",
		weight = 0.01,
	},
	['dice'] = {
		label = "Dés",
		weight = 0.01,
	},
	['dim_sum'] = {
		label = "Dim Sum",
		weight = 0.01,
	},
	['disque'] = {
		label = "Disque",
		weight = 0.01,
	},
	['diving_gear'] = {
		label = "Équipement de Plongée",
		weight = 0.01,
	},
	['document_holder'] = {
		label = "Porte-Documents",
		weight = 0.01,
	},
	['dodo_spit'] = {
		label = "Crachat de Dodo",
		weight = 0.01,
	},
	['dodo_statue'] = {
		label = "Statue de Dodo",
		weight = 0.01,
	},
	['dog_collar'] = {
		label = "Collier de Chien",
		weight = 0.01,
	},
	['dog_food'] = {
		label = "Nourriture pour Chien",
		weight = 0.01,
	},
	['dollars'] = {
		label = "Dollars",
		weight = 0.01,
	},
	['dollartaco'] = {
		label = "Taco Dollar",
		weight = 0.01,
	},
	['donkatsu'] = {
		label = "Donkatsu",
		weight = 0.01,
	},
	['donut'] = {
		label = "Donut",
		weight = 0.01,
	},
	['door_lockpick'] = {
		label = "Crochet de Serrure de Porte",
		weight = 0.01,
	},
	['dorayaki'] = {
		label = "Dorayaki",
		weight = 0.01,
	},
	['dora_maar_auchat'] = {
		label = "Dora Maar au Chat",
		weight = 0.01,
	},
	['doritos'] = {
		label = "Doritos",
		weight = 0.01,
	},
	['double_canon'] = {
		label = "Double Canon",
		weight = 0.01,
	},
	['double_pommes'] = {
		label = "Double Pommes",
		weight = 0.01,
	},
	['doudou'] = {
		label = "Doudou",
		weight = 0.01,
	},
	['dragon'] = {
		label = "Dragon",
		weight = 0.01,
	},
	['dreamcatcher'] = {
		label = "Attrape-Rêves",
		weight = 0.01,
	},
	['dreamyweenie'] = {
		label = "Dreamy Weenie",
		weight = 0.01,
	},
	['drifttires'] = {
		label = "Pneus de Drift",
		weight = 0.01,
	},
	['drift_lowgrip'] = {
		label = "Drift Low Grip",
		weight = 0.01,
	},
	['drill'] = {
		label = "Perceuse",
		weight = 0.01,
	},
	['drill_bit'] = {
		label = "Mèche de Perceuse",
		weight = 0.01,
	},
	['drill_underground'] = {
		label = "Perceuse Souterraine",
		weight = 0.01,
	},
	['driving_test'] = {
		label = "Test de Conduite",
		weight = 0.01,
	},
	['drone_flyer_1'] = {
		label = "Drone Flyer 1",
		weight = 0.01,
	},
	['drone_flyer_2'] = {
		label = "Drone Flyer 2",
		weight = 0.01,
	},
	['drone_flyer_3'] = {
		label = "Drone Flyer 3",
		weight = 0.01,
	},
	['drone_flyer_4'] = {
		label = "Drone Flyer 4",
		weight = 0.01,
	},
	['drone_flyer_5'] = {
		label = "Drone Flyer 5",
		weight = 0.01,
	},
	['drone_flyer_6'] = {
		label = "Drone Flyer 6",
		weight = 0.01,
	},
	['drone_flyer_7'] = {
		label = "Drone Flyer 7",
		weight = 0.01,
	},
	['drone_giovanni'] = {
		label = "Drone Giovanni",
		weight = 0.01,
	},
	['drone_rcbandito'] = {
		label = "Drone RC Bandito",
		weight = 0.01,
	},
	['drone_rcbull'] = {
		label = "Drone RC Bull",
		weight = 0.01,
	},
	['drone_rcmavic'] = {
		label = "Drone RC Mavic",
		weight = 0.01,
	},
	['drone_rcmonster'] = {
		label = "Drone RC Monster",
		weight = 0.01,
	},
	['drone_rcmoto'] = {
		label = "Drone RC Moto",
		weight = 0.01,
	},
	['drone_rctowmater'] = {
		label = "Drone RC Tow Mater",
		weight = 0.01,
	},
	['drone_rctoystory'] = {
		label = "Drone RC Toy Story",
		weight = 0.01,
	},
	['drone_rctruck'] = {
		label = "Drone RC Truck",
		weight = 0.01,
	},
	['drone_thruster'] = {
		label = "Propulseur de Drone",
		weight = 0.01,
	},
	['drpepper'] = {
		label = "Dr Pepper",
		weight = 0.01,
	},
	['drugscales'] = {
		label = "Balances de Drogues",
		weight = 0.01,
	},
	['drugtable'] = {
		label = "Table de Drogues",
		weight = 0.01,
	},
	['drug_blue'] = {
		label = "Drogue Bleue",
		weight = 0.01,
	},
	['drug_red'] = {
		label = "Drogue Rouge",
		weight = 0.01,
	},
	['drug_white'] = {
		label = "Drogue Blanche",
		weight = 0.01,
	},
	['drug_x'] = {
		label = "Drogue X",
		weight = 0.01,
	},
	['dudemon'] = {
		label = "Dudemon",
		weight = 0.01,
	},
	['duffel'] = {
		label = "Sac Duffel",
		weight = 0.01,
	},
	['dusche_gold'] = {
		label = "Douche en Or",
		weight = 0.01,
	},
	['dye'] = {
		label = "Teinture",
		weight = 0.01,
	},
	['d_certificate'] = {
		label = "Certificat D",
		weight = 0.01,
	},
	['ebayairfilter'] = {
		label = "Filtre à Air eBay",
		weight = 0.01,
	},
	['echarpe'] = {
		label = "Écharpe",
		weight = 0.01,
	},
	['ecstasy1'] = {
		label = "Ecstasy 1",
		weight = 0.01,
	},
	['ecstasy2'] = {
		label = "Ecstasy 2",
		weight = 0.01,
	},
	['ecstasy_pill_neutral'] = {
		label = "Pilule Ecstasy Neutre",
		weight = 0.01,
	},
	['eggs_and_bacon'] = {
		label = "Œufs et Bacon",
		weight = 0.01,
	},
	['electronics'] = {
		label = "Électronique",
		weight = 0.01,
	},
	['electronic_kit'] = {
		label = "Kit Électronique",
		weight = 0.01,
	},
	['elexir'] = {
		label = "Élexir",
		weight = 0.01,
	},
	['elixir'] = {
		label = "Élixir",
		weight = 0.01,
	},
	['elon_bag'] = {
		label = "Sac Elon",
		weight = 0.01,
	},
	['emerald'] = {
		label = "Émeraude",
		weight = 0.01,
	},
	['emerald_necklace'] = {
		label = "Collier en Émeraude",
		weight = 0.01,
	},
	['emerald_ring'] = {
		label = "Bague en Émeraude",
		weight = 0.01,
	},
	['empty_bag'] = {
		label = "Sachet vide",
		weight = 0.01,
	},
	['empty_jerrycan'] = {
		label = "Jerrycan Vide",
		weight = 0.01,
	},
	['empty_water_bottle'] = {
		label = "Bouteille d'Eau Vide",
		weight = 0.01,
	},
	['enchilada'] = {
		label = "Enchilada",
		weight = 0.01,
	},
	['enchiladas'] = {
		label = "Enchiladas",
		weight = 0.01,
	},
	['energy'] = {
		label = "Énergie",
		weight = 0.01,
	},
	['energydrink'] = {
		label = "Boisson Énergétique",
		weight = 0.01,
	},
	['energy_bar'] = {
		label = "Barre Énergétique",
		weight = 0.01,
	},
	['engagementring'] = {
		label = "Bague de Fiançailles",
		weight = 0.01,
	},
	['engagement_ring'] = {
		label = "Bague de Fiançailles",
		weight = 0.01,
	},
	['engine_2jz'] = {
		label = "Moteur 2JZ",
		weight = 0.01,
	},
	['english_coffee'] = {
		label = "Café Anglais",
		weight = 0.01,
	},
	['entrecote'] = {
		label = "Entrecôte",
		weight = 0.01,
	},
	['ephedrine'] = {
		label = "Éphédrine",
		weight = 0.01,
	},
	['ergot'] = {
		label = "Ergot",
		weight = 0.01,
	},
	['espresso'] = {
		label = "Expresso",
		weight = 0.01,
	},
	['ethylotest'] = {
		label = "Éthylotest",
		weight = 0.01,
	},
	['ethylotest_precision'] = {
		label = "Éthylotest de Précision",
		weight = 0.01,
	},
	['everythingbagel'] = {
		label = "Bagel Tout",
		weight = 0.01,
	},
	['evidence'] = {
		label = "Preuve",
		weight = 0.01,
	},
	['evidence_bag'] = {
		label = "Sac de Preuves",
		weight = 0.01,
	},
	['evidence_sticker'] = {
		label = "Autocollant de Preuve",
		weight = 0.01,
	},
	['experimental_pill'] = {
		label = "Pilule Expérimentale",
		weight = 0.01,
	},
	['extasy_machine'] = {
		label = "Machine à Ecstasy",
		weight = 0.01,
	},
	['eye'] = {
		label = "Œil",
		weight = 0.01,
	},
	['faberge_egg'] = {
		label = "Œuf Fabergé",
		weight = 0.01,
	},
	['fabric'] = {
		label = "Tissu",
		weight = 0.01,
	},
	['failed_test'] = {
		label = "Test Échoué",
		weight = 0.01,
	},
	['fakeplates'] = {
		label = "Plaques Falsifiées",
		weight = 0.01,
	},
	['fake_snow_vhs'] = {
		label = "VHS de Neige Fausse",
		weight = 0.01,
	},
	['fanta'] = {
		label = "Fanta",
		weight = 0.01,
	},
	['fanta_fraise'] = {
		label = "Fanta Fraise",
		weight = 0.01,
	},
	['farina'] = {
		label = "Farine",
		weight = 0.01,
	},
	['farinadimais'] = {
		label = "Farine de Maïs",
		weight = 0.01,
	},
	['farmers_surprise'] = {
		label = "Surprise du Fermier",
		weight = 0.01,
	},
	['fascette'] = {
		label = "Fascette",
		weight = 0.01,
	},
	['feathers'] = {
		label = "Plumes",
		weight = 0.01,
	},
	['fede'] = {
		label = "Fede",
		weight = 0.01,
	},
	['feet2'] = {
		label = "Pieds 2",
		weight = 0.01,
	},
	['fentanyl_brick'] = {
		label = "Brique de Fentanyl",
		weight = 0.01,
	},
	['fentanyl_comp'] = {
		label = "Composé de Fentanyl",
		weight = 0.01,
	},
	['fentanyl_paste'] = {
		label = "Pâte de Fentanyl",
		weight = 0.01,
	},
	['ferro'] = {
		label = "Ferro",
		weight = 0.01,
	},
	['fertilizer'] = {
		label = "Engrais",
		weight = 0.01,
	},
	['fertilizer_bag'] = {
		label = "Sac d'Engrais",
		weight = 0.01,
	},
	['fiamma'] = {
		label = "Flamme",
		weight = 0.01,
	},
	['fiammifero'] = {
		label = "Allumette",
		weight = 0.01,
	},
	['filet_de_boeuf'] = {
		label = "Filet de Boeuf",
		weight = 0.01,
	},
	['filet_mignon'] = {
		label = "Filet Mignon",
		weight = 0.01,
	},
	['filterall'] = {
		label = "Filtre Tout",
		weight = 0.01,
	},
	['filterkeys'] = {
		label = "Clés de Filtre",
		weight = 0.01,
	},
	['filtervetements'] = {
		label = "Vêtements de Filtre",
		weight = 0.01,
	},
	['fion'] = {
		label = "Fion",
		weight = 0.01,
	},
	['fiorentina'] = {
		label = "Fiorentina",
		weight = 0.01,
	},
	['firework1'] = {
		label = "Feu d'Artifice 1",
		weight = 0.01,
	},
	['firework2'] = {
		label = "Feu d'Artifice 2",
		weight = 0.01,
	},
	['firework3'] = {
		label = "Feu d'Artifice 3",
		weight = 0.01,
	},
	['firework4'] = {
		label = "Feu d'Artifice 4",
		weight = 0.01,
	},
	['firework5'] = {
		label = "Feu d'Artifice 5",
		weight = 0.01,
	},
	['firework6'] = {
		label = "Feu d'Artifice 6",
		weight = 0.01,
	},
	['firework7'] = {
		label = "Feu d'Artifice 7",
		weight = 0.01,
	},
	['firstaid'] = {
		label = "Premiers Secours",
		weight = 0.01,
	},
	['fish'] = {
		label = "Poisson",
		weight = 0.01,
	},
	['fishbait'] = {
		label = "Appât de Poisson",
		weight = 0.01,
	},
	['fishingrod'] = {
		label = "Canne à Pêche",
		weight = 0.01,
	},
	['fishtaco'] = {
		label = "Taco au Poisson",
		weight = 0.01,
	},
	['fish_and_chips'] = {
		label = "Poisson et Frites",
		weight = 0.01,
	},
	['fitbit'] = {
		label = "Fitbit",
		weight = 0.01,
	},
	['fixkit'] = {
		label = "Kit de Réparation",
		weight = 0.01,
	},
	['flan_mexicain'] = {
		label = "Flan Mexicain",
		weight = 0.01,
	},
	['florida'] = {
		label = "Floride",
		weight = 0.01,
	},
	['flowerpot'] = {
		label = "Pot de Fleurs",
		weight = 0.01,
	},
	['flowers'] = {
		label = "Fleurs",
		weight = 0.01,
	},
	['flyer'] = {
		label = "Flyer",
		weight = 0.01,
	},
	['foie'] = {
		label = "Foie",
		weight = 0.01,
	},
	['foin'] = {
		label = "Foin",
		weight = 0.01,
	},
	['food_goods'] = {
		label = "Produits Alimentaires",
		weight = 0.01,
	},
	['football'] = {
		label = "Football",
		weight = 0.01,
	},
	['fowl_burger'] = {
		label = "Burger de Volaille",
		weight = 0.01,
	},
	['foyer_kaloud'] = {
		label = "Foyer Kaloud",
		weight = 0.01,
	},
	['fraise'] = {
		label = "Fraise",
		weight = 0.01,
	},
	['fraise_chocolate'] = {
		label = "Fraise au Chocolat",
		weight = 0.01,
	},
	['frappe'] = {
		label = "Frappe",
		weight = 0.01,
	},
	['frappuccino'] = {
		label = "Frappuccino",
		weight = 0.01,
	},
	['frein_de_bouche'] = {
		label = "Frein de Bouche",
		weight = 0.01,
	},
	['frenchfries'] = {
		label = "Frites",
		weight = 0.01,
	},
	['french_toast'] = {
		label = "Pain Perdu",
		weight = 0.01,
	},
	['fresh_coco'] = {
		label = "Noix de Coco Fraîche",
		weight = 0.01,
	},
	['friedicecream'] = {
		label = "Glace Frite",
		weight = 0.01,
	},
	['friedrice'] = {
		label = "Riz Frit",
		weight = 0.01,
	},
	['fries'] = {
		label = "Frites",
		weight = 0.01,
	},
	['frisbee'] = {
		label = "Frisbee",
		weight = 0.01,
	},
	['fritespatatedouce'] = {
		label = "Frites de Patate Douce",
		weight = 0.01,
	},
	['friteswaffle'] = {
		label = "Gaufre Frites",
		weight = 0.01,
	},
	['frites_chickfila'] = {
		label = "Frites Chick-fil-A",
		weight = 0.01,
	},
	['frittura'] = {
		label = "Frittura",
		weight = 0.01,
	},
	['fruitcake'] = {
		label = "Gâteau aux Fruits",
		weight = 0.01,
	},
	['fruityjuicy'] = {
		label = "Fruit Juteux",
		weight = 0.01,
	},
	['fruit_tartlet'] = {
		label = "Tartelette aux Fruits",
		weight = 0.01,
	},
	['fruttim'] = {
		label = "Fruttim",
		weight = 0.01,
	},
	['fukang_meteorite'] = {
		label = "Météorite Fukang",
		weight = 0.01,
	},
	['full_jerrycan'] = {
		label = "Jerrycan Plein",
		weight = 0.01,
	},
	['gadget_nightvision'] = {
		label = "Gadget Vision Nocturne",
		weight = 0.01,
	},
	['gadget_parachute'] = {
		label = "Gadget Parachute",
		weight = 0.01,
	},
	['gainer1'] = {
		label = "Gainer 1",
		weight = 0.01,
	},
	['gainer2'] = {
		label = "Gainer 2",
		weight = 0.01,
	},
	['gameboy'] = {
		label = "Gameboy",
		weight = 0.01,
	},
	['garbage'] = {
		label = "Déchets",
		weight = 0.01,
	},
	['gatorade'] = {
		label = "Gatorade",
		weight = 0.01,
	},
	['gaze'] = {
		label = "Regard",
		weight = 0.01,
	},
	['gender_reveal_f'] = {
		label = "Révélation de Genre (Fille)",
		weight = 0.01,
	},
	['gender_reveal_h'] = {
		label = "Révélation de Genre (Garçon)",
		weight = 0.01,
	},
	['general_spray_paint'] = {
		label = "Peinture en Spray Générale",
		weight = 0.01,
	},
	['gettone_carwash'] = {
		label = "Jeton de Lmodulesge Auto",
		weight = 0.01,
	},
	['ghisa'] = {
		label = "Fonte",
		weight = 0.01,
	},
	['gift'] = {
		label = "Cadeau",
		weight = 0.01,
	},
	['gin'] = {
		label = "Gin",
		weight = 0.01,
	},
	['gin2'] = {
		label = "Gin 2",
		weight = 0.01,
	},
	['ginbottle'] = {
		label = "Bouteille de Gin",
		weight = 0.01,
	},
	['gingerbreadcookie'] = {
		label = "Cookie en Pain d'Épices",
		weight = 0.01,
	},
	['ginger_ale'] = {
		label = "Ginger Ale",
		weight = 0.01,
	},
	['ginshot'] = {
		label = "Shot de Gin",
		weight = 0.01,
	},
	['gioielli'] = {
		label = "Bijoux",
		weight = 0.01,
	},
	['gland'] = {
		label = "Gland",
		weight = 0.01,
	},
	['glass'] = {
		label = "Verre",
		weight = 0.01,
	},
	['glasses'] = {
		label = "Lunettes",
		weight = 0.01,
	},
	['glassplate'] = {
		label = "Assiette en Verre",
		weight = 0.01,
	},
	['glass_bottle'] = {
		label = "Bouteille en Verre",
		weight = 0.01,
	},
	['glass_of_beer'] = {
		label = "Verre de Bière",
		weight = 0.01,
	},
	['glass_of_whiskey'] = {
		label = "Verre de Whisky",
		weight = 0.01,
	},
	['glass_wine'] = {
		label = "Verre à Vin",
		weight = 0.01,
	},
	['glazeddonut'] = {
		label = "Donut Glacé",
		weight = 0.01,
	},
	['glowing_substance'] = {
		label = "Substance Lumineuse",
		weight = 0.01,
	},
	['glucose'] = {
		label = "Glucose",
		weight = 0.01,
	},
	['gold'] = {
		label = "Or",
		weight = 0.01,
	},
	['goldbar'] = {
		label = "Lingot d'Or",
		weight = 0.01,
	},
	['goldchain'] = {
		label = "Chaîne en Or",
		weight = 0.01,
	},
	['golden_egg'] = {
		label = "Œuf d'Or",
		weight = 0.01,
	},
	['golden_ticket'] = {
		label = "Billet d'Or",
		weight = 0.01,
	},
	['goldgift'] = {
		label = "Cadeau en Or",
		weight = 0.01,
	},
	['goldore'] = {
		label = "Minerai d'Or",
		weight = 0.01,
	},
	['goldring'] = {
		label = "Bague en Or",
		weight = 0.01,
	},
	['gold_chain_10ct'] = {
		label = "Chaîne en Or 10ct",
		weight = 0.01,
	},
	['gold_chain_2ct'] = {
		label = "Chaîne en Or 2ct",
		weight = 0.01,
	},
	['gold_chain_5ct'] = {
		label = "Chaîne en Or 5ct",
		weight = 0.01,
	},
	['gold_chain_8ct'] = {
		label = "Chaîne en Or 8ct",
		weight = 0.01,
	},
	['gold_chip'] = {
		label = "Puce en Or",
		weight = 0.01,
	},
	['gold_coin'] = {
		label = "Pièce d'Or",
		weight = 0.01,
	},
	['gold_keys'] = {
		label = "Clés en Or",
		weight = 0.01,
	},
	['gold_record'] = {
		label = "Disque d'Or",
		weight = 0.01,
	},
	['gold_ring'] = {
		label = "Bague en Or",
		weight = 0.01,
	},
	['gopro'] = {
		label = "GoPro",
		weight = 0.01,
	},
	['graine'] = {
		label = "Graine",
		weight = 0.01,
	},
	['grains'] = {
		label = "Grains",
		weight = 0.01,
	},
	['grain_caffe'] = {
		label = "Grain de Café",
		weight = 0.01,
	},
	['graisin'] = {
		label = "Raisin",
		weight = 0.01,
	},
	['grand_cru'] = {
		label = "Grand Cru",
		weight = 0.01,
	},
	['grand_tete_mince'] = {
		label = "Grande Tête Mince",
		weight = 0.01,
	},
	['granita'] = {
		label = "Granita",
		weight = 0.01,
	},
	['grapperaisin'] = {
		label = "Grape Raisin",
		weight = 0.01,
	},
	['greek_bust'] = {
		label = "Buste Grec",
		weight = 0.01,
	},
	['green_bandana'] = {
		label = "Bandana Verte",
		weight = 0.01,
	},
	['green_belt'] = {
		label = "Ceinture Verte",
		weight = 0.01,
	},
	['green_chip'] = {
		label = "Puce Verte",
		weight = 0.01,
	},
	['green_cow'] = {
		label = "Vache Verte",
		weight = 0.01,
	},
	['grinder'] = {
		label = "Moulin",
		weight = 0.01,
	},
	['guacamole'] = {
		label = "Guacamole",
		weight = 0.01,
	},
	['guarico'] = {
		label = "Guarico",
		weight = 0.01,
	},
	['gumodules_raspberry'] = {
		label = "Goyave Framboise",
		weight = 0.01,
	},
	['guitare'] = {
		label = "Guitare",
		weight = 0.01,
	},
	['gum'] = {
		label = "Gomme",
		weight = 0.01,
	},
	['gummies'] = {
		label = "Gummies",
		weight = 0.01,
	},
	['gunpowder'] = {
		label = "Poudre à Canon",
		weight = 0.01,
	},
	['hackerlaptop'] = {
		label = "Ordinateur Portable de Hacker",
		weight = 0.01,
	},
	['hackertablet'] = {
		label = "Tablette de Hacker",
		weight = 0.01,
	},
	['haggis'] = {
		label = "Haggis",
		weight = 0.01,
	},
	['hair_tonic'] = {
		label = "Tonique pour Cheveux",
		weight = 0.01,
	},
	['hamachibox'] = {
		label = "Boîte Hamachi",
		weight = 0.01,
	},
	['hamburger'] = {
		label = "Hamburger",
		weight = 0.01,
	},
	['hands'] = {
		label = "Mains",
		weight = 0.01,
	},
	['hand_cuffs'] = {
		label = "Menottes",
		weight = 0.01,
	},
	['hand_lotion'] = {
		label = "Lotion pour Mains",
		weight = 0.01,
	},
	['harness'] = {
		label = "Harnais",
		weight = 0.01,
	},
	['headlights'] = {
		label = "Phares",
		weight = 0.01,
	},
	['headphones'] = {
		label = "Casque Audio",
		weight = 0.01,
	},
	['health_panel'] = {
		label = "Panneau de Santé",
		weight = 0.01,
	},
	['heartstopper'] = {
		label = "Arrête-Cœur",
		weight = 0.01,
	},
	['heartstopperburger'] = {
		label = "Burger Arrête-Cœur",
		weight = 0.01,
	},
	['heavy_cutters'] = {
		label = "Coupe-Lourds",
		weight = 0.01,
	},
	['heavy_duty_drill'] = {
		label = "Perceuse Lourde",
		weight = 0.01,
	},
	['hellokitty_bandage'] = {
		label = "Bandage Hello Kitty",
		weight = 0.01,
	},
	['hellschickenwings'] = {
		label = "Ailes de Poulet Hell",
		weight = 0.01,
	},
	['herisson'] = {
		label = "Hérisson",
		weight = 0.01,
	},
	['heroin'] = {
		label = "Héroïne",
		weight = 0.01,
	},
	['heroine'] = {
		label = "Héroïne",
		weight = 0.01,
	},
	['herse'] = {
		label = "Herse",
		weight = 0.01,
	},
	['highgradefert'] = {
		label = "Engrais de Haute Qualité",
		weight = 0.01,
	},
	['high_quality_scales'] = {
		label = "Balances de Haute Qualité",
		weight = 0.01,
	},
	['holidaypunch'] = {
		label = "Punch de Vacances",
		weight = 0.01,
	},
	['holy_book'] = {
		label = "Livre Saint",
		weight = 0.01,
	},
	['holy_hummus'] = {
		label = "Houmous Saint",
		weight = 0.01,
	},
	['hookiescatch'] = {
		label = "Hookies Catch",
		weight = 0.01,
	},
	['horchata'] = {
		label = "Horchata",
		weight = 0.01,
	},
	['hotchocolate'] = {
		label = "Chocolat Chaud",
		weight = 0.01,
	},
	['hotdog'] = {
		label = "Hot Dog",
		weight = 0.01,
	},
	['hotwire_try'] = {
		label = "Essai de Démarrage à Chaud",
		weight = 0.01,
	},
	['hptracker'] = {
		label = "HP Tracker",
		weight = 0.01,
	},
	['huile_tournesol'] = {
		label = "Huile de Tournesol",
		weight = 0.01,
	},
	['hwayo'] = {
		label = "Hwayo",
		weight = 0.01,
	},
	['hydrochloric_acid'] = {
		label = "Acide Chlorhydrique",
		weight = 0.01,
	},
	['hydrocodone'] = {
		label = "Hydrocodone",
		weight = 0.01,
	},
	['ibuprofen'] = {
		label = "Ibuprofène",
		weight = 0.01,
	},
	['ice'] = {
		label = "Glace",
		weight = 0.01,
	},
	['icebag'] = {
		label = "Sac de Glace",
		weight = 0.01,
	},
	['icecream'] = {
		label = "Glace",
		weight = 0.01,
	},
	['icecreambar'] = {
		label = "Barre de Glace",
		weight = 0.01,
	},
	['icedcoffee'] = {
		label = "Café Glacé",
		weight = 0.01,
	},
	['iceskating'] = {
		label = "Patin à Glace",
		weight = 0.01,
	},
	['icetea'] = {
		label = "Thé Glacé",
		weight = 0.01,
	},
	['ichnusa'] = {
		label = "Ichnusa",
		weight = 0.01,
	},
	['ifak'] = {
		label = "IFAK",
		weight = 0.01,
	},
	['ingredients'] = {
		label = "Ingrédients",
		weight = 0.01,
	},
	['inked_money_bag'] = {
		label = "Sac d'Argent Encrée",
		weight = 0.01,
	},
	['intercontinental_belt'] = {
		label = "Ceinture Intercontinentale",
		weight = 0.01,
	},
	['intraveineuse'] = {
		label = "Intraveineuse",
		weight = 0.01,
	},
	['invicible_tyres'] = {
		label = "Pneus Invincibles",
		weight = 0.01,
	},
	['iodine'] = {
		label = "Iode",
		weight = 0.01,
	},
	['ipa'] = {
		label = "IPA",
		weight = 0.01,
	},
	['ipanema'] = {
		label = "Ipanema",
		weight = 0.01,
	},
	['iphone'] = {
		label = "iPhone",
		weight = 0.01,
	},
	['iphone_rooted'] = {
		label = "iPhone Rooté",
		weight = 0.01,
	},
	['iron'] = {
		label = "Fer",
		weight = 0.01,
	},
	['ironore'] = {
		label = "Minerai de Fer",
		weight = 0.01,
	},
	['ironplate'] = {
		label = "Plaque de Fer",
		weight = 0.01,
	},
	['iron_bar'] = {
		label = "Barre de Fer",
		weight = 0.01,
	},
	['iron_oxide'] = {
		label = "Oxyde de Fer",
		weight = 0.01,
	},
	['isopropanol'] = {
		label = "Isopropanol",
		weight = 0.01,
	},
	['jack'] = {
		label = "Crick",
		weight = 0.01,
	},
	['jackets'] = {
		label = "Vestes",
		weight = 0.01,
	},
	['jadeite_stone'] = {
		label = "Pierre de Jadeite",
		weight = 0.01,
	},
	['jailfood'] = {
		label = "Nourriture de Prison",
		weight = 0.01,
	},
	['jalapenopoppers'] = {
		label = "Poppers Jalapeño",
		weight = 0.01,
	},
	['jar_of_moonshine'] = {
		label = "Bocal de Lune",
		weight = 0.01,
	},
	['jellydonut'] = {
		label = "Donut à la Confiture",
		weight = 0.01,
	},
	['jelly_belly'] = {
		label = "Jelly Belly",
		weight = 0.01,
	},
	['jerry_can'] = {
		label = "Jerrycan",
		weight = 0.01,
	},
	['jeton_sidaction'] = {
		label = "Jeton Sidaction",
		weight = 0.01,
	},
	['jewels'] = {
		label = "Bijoux",
		weight = 0.01,
	},
	['jjaseon'] = {
		label = "Jjaseon",
		weight = 0.01,
	},
	['jjimdak'] = {
		label = "Jjim Dak",
		weight = 0.01,
	},
	['joint'] = {
		label = "Joint",
		weight = 0.01,
	},
	['joint2'] = {
		label = "Joint 2",
		weight = 0.01,
	},
	['joint_cbd'] = {
		label = "Joint CBD",
		weight = 0.01,
	},
	['joker'] = {
		label = "Joker",
		weight = 0.01,
	},
	['jusfruit'] = {
		label = "Jus de Fruits",
		weight = 0.01,
	},
	['jus_ananas'] = {
		label = "Jus d'Ananas",
		weight = 0.01,
	},
	['jus_raisin'] = {
		label = "Jus de Raisin",
		weight = 0.01,
	},
	['kandnfilter'] = {
		label = "Filtre K&N",
		weight = 0.01,
	},
	['kennelcat'] = {
		label = "Chenil pour Chat",
		weight = 0.01,
	},
	['kennelchop'] = {
		label = "Chenil pour Chien",
		weight = 0.01,
	},
	['kennelhusky'] = {
		label = "Chenil pour Husky",
		weight = 0.01,
	},
	['kennelpig'] = {
		label = "Chenil pour Cochon",
		weight = 0.01,
	},
	['kennelpoodle'] = {
		label = "Chenil pour Caniche",
		weight = 0.01,
	},
	['kennelpug'] = {
		label = "Chenil pour Carlin",
		weight = 0.01,
	},
	['kennelretriever'] = {
		label = "Chenil pour Retriever",
		weight = 0.01,
	},
	['kennelrottweiler'] = {
		label = "Chenil pour Rottweiler",
		weight = 0.01,
	},
	['kennelshepherd'] = {
		label = "Chenil pour Berger",
		weight = 0.01,
	},
	['kennelwesty'] = {
		label = "Chenil pour Westie",
		weight = 0.01,
	},
	['ketalar'] = {
		label = "Kétalar",
		weight = 0.01,
	},
	['ketalar_machine'] = {
		label = "Machine Kétalar",
		weight = 0.01,
	},
	['ketamine'] = {
		label = "Kétamine",
		weight = 0.01,
	},
	['ketamine_brick'] = {
		label = "Brique de Kétamine",
		weight = 0.01,
	},
	['ketamine_machine'] = {
		label = "Machine de Kétamine",
		weight = 0.01,
	},
	['ketamine_raw'] = {
		label = "Kétamine Brute",
		weight = 0.01,
	},
	['ketchup'] = {
		label = "Ketchup",
		weight = 0.01,
	},
	['key1'] = {
		label = "Clé 1",
		weight = 0.01,
	},
	['key2'] = {
		label = "Clé 2",
		weight = 0.01,
	},
	['key3'] = {
		label = "Clé 3",
		weight = 0.01,
	},
	['keya'] = {
		label = "Clé A",
		weight = 0.01,
	},
	['keyb'] = {
		label = "Clé B",
		weight = 0.01,
	},
	['keyc'] = {
		label = "Clé C",
		weight = 0.01,
	},
	['keycard'] = {
		label = "Carte Clé",
		weight = 0.01,
	},
	['keycard_blue'] = {
		label = "Carte Clé Bleue",
		weight = 0.01,
	},
	['keycard_cyan'] = {
		label = "Carte Clé Cyan",
		weight = 0.01,
	},
	['keycard_green'] = {
		label = "Carte Clé Verte",
		weight = 0.01,
	},
	['keycard_purple'] = {
		label = "Carte Clé Violette",
		weight = 0.01,
	},
	['keycard_red'] = {
		label = "Carte Clé Rouge",
		weight = 0.01,
	},
	['keycard_yellow'] = {
		label = "Carte Clé Jaune",
		weight = 0.01,
	},
	['keyclamp'] = {
		label = "Pince de Clé",
		weight = 0.01,
	},
	['key_chain'] = {
		label = "Porte-Clés",
		weight = 0.01,
	},
	['kfcburger'] = {
		label = "Burger KFC",
		weight = 0.01,
	},
	['kimbap'] = {
		label = "Kimbap",
		weight = 0.01,
	},
	['koleslaw'] = {
		label = "Coleslaw",
		weight = 0.01,
	},
	['labkey'] = {
		label = "Clé de Lab",
		weight = 0.01,
	},
	['laitchevre'] = {
		label = "Lait de Chèvre",
		weight = 0.01,
	},
	['lait_fraise'] = {
		label = "Lait Fraise",
		weight = 0.01,
	},
	['lana'] = {
		label = "Laine",
		weight = 0.01,
	},
	['langue'] = {
		label = "Langue",
		weight = 0.01,
	},
	['laptop'] = {
		label = "Ordinateur Portable",
		weight = 0.01,
	},
	['lasagne'] = {
		label = "Lasagne",
		weight = 0.01,
	},
	['laser_drill'] = {
		label = "Perceuse Laser",
		weight = 0.01,
	},
	['latte'] = {
		label = "Latte",
		weight = 0.01,
	},
	['lean'] = {
		label = "Lean",
		weight = 0.01,
	},
	['legreenlove'] = {
		label = "Amour de Le Green",
		weight = 0.01,
	},
	['leg_xray'] = {
		label = "Radiographie de Jambe",
		weight = 0.01,
	},
	['lemon'] = {
		label = "Citron",
		weight = 0.01,
	},
	['les_femmes_dalger'] = {
		label = "Les Femmes d'Alger",
		weight = 0.01,
	},
	['lettuce'] = {
		label = "Laitue",
		weight = 0.01,
	},
	['le_cannolo'] = {
		label = "Cannolo",
		weight = 0.01,
	},
	['lg_card_abominablesectaire'] = {
		label = "Carte Abominable Sectaire",
		weight = 0.01,
	},
	['lg_card_ancien'] = {
		label = "Carte Ancienne",
		weight = 0.01,
	},
	['lg_card_ange'] = {
		label = "Carte Ange",
		weight = 0.01,
	},
	['lg_card_boucemissaire'] = {
		label = "Carte Boucémissaire",
		weight = 0.01,
	},
	['lg_card_chasseur'] = {
		label = "Carte Chasseur",
		weight = 0.01,
	},
	['lg_card_chienloup'] = {
		label = "Carte Chien-Loup",
		weight = 0.01,
	},
	['lg_card_comedien'] = {
		label = "Carte Comédien",
		weight = 0.01,
	},
	['lg_card_corbeau'] = {
		label = "Carte Corbeau",
		weight = 0.01,
	},
	['lg_card_cupidon'] = {
		label = "Carte Cupidon",
		weight = 0.01,
	},
	['lg_card_deuxsoeurs'] = {
		label = "Carte Deux Soeurs",
		weight = 0.01,
	},
	['lg_card_enfantsauvage'] = {
		label = "Carte Enfant Sauvage",
		weight = 0.01,
	},
	['lg_card_flutiste'] = {
		label = "Carte Flutiste",
		weight = 0.01,
	},
	['lg_card_gitane'] = {
		label = "Carte Gitane",
		weight = 0.01,
	},
	['lg_card_grandmechantloup'] = {
		label = "Carte Grand Méchant Loup",
		weight = 0.01,
	},
	['lg_card_idiotvillage'] = {
		label = "Carte Idéal Villageois",
		weight = 0.01,
	},
	['lg_card_jugebegue'] = {
		label = "Carte Juge Begue",
		weight = 0.01,
	},
	['lg_card_loup'] = {
		label = "Carte Loup",
		weight = 0.01,
	},
	['lg_card_loupblanc'] = {
		label = "Carte Loup Blanc",
		weight = 0.01,
	},
	['lg_card_montreurours'] = {
		label = "Carte Montreur d'Ours",
		weight = 0.01,
	},
	['lg_card_peredesloups'] = {
		label = "Carte Père des Loups",
		weight = 0.01,
	},
	['lg_card_petitefille'] = {
		label = "Carte Petite Fille",
		weight = 0.01,
	},
	['lg_card_renard'] = {
		label = "Carte Renard",
		weight = 0.01,
	},
	['lg_card_salvateur'] = {
		label = "Carte Salvateur",
		weight = 0.01,
	},
	['lg_card_servante'] = {
		label = "Carte Servante",
		weight = 0.01,
	},
	['lg_card_slu_chasseur'] = {
		label = "Carte Slu Chasseur",
		weight = 0.01,
	},
	['lg_card_slu_cupidon'] = {
		label = "Carte Slu Cupidon",
		weight = 0.01,
	},
	['lg_card_slu_loup'] = {
		label = "Carte Slu Loup",
		weight = 0.01,
	},
	['lg_card_slu_petitefille'] = {
		label = "Carte Slu Petite Fille",
		weight = 0.01,
	},
	['lg_card_slu_sorciere'] = {
		label = "Carte Slu Sorcière",
		weight = 0.01,
	},
	['lg_card_slu_villageois'] = {
		label = "Carte Slu Villageois",
		weight = 0.01,
	},
	['lg_card_slu_voyante'] = {
		label = "Carte Slu Voyante",
		weight = 0.01,
	},
	['lg_card_sorciere'] = {
		label = "Carte Sorcière",
		weight = 0.01,
	},
	['lg_card_villageois'] = {
		label = "Carte Villageois",
		weight = 0.01,
	},
	['lg_card_voleur'] = {
		label = "Carte Voleur",
		weight = 0.01,
	},
	['lg_card_voyante'] = {
		label = "Carte Voyante",
		weight = 0.01,
	},
	['lg_misc_cagoule'] = {
		label = "Cagoule Divers",
		weight = 0.01,
	},
	['lg_misc_faussecagoule'] = {
		label = "Fausse Cagoule",
		weight = 0.01,
	},
	['lg_misc_jour'] = {
		label = "Jour Divers",
		weight = 0.01,
	},
	['lg_misc_nuit'] = {
		label = "Nuit Divers",
		weight = 0.01,
	},
	['lg_misc_one'] = {
		label = "Un Divers",
		weight = 0.01,
	},
	['lhomme_qui_marche'] = {
		label = "L'Homme qui Marche",
		weight = 0.01,
	},
	['libretto'] = {
		label = "Libretto",
		weight = 0.01,
	},
	['lievitodibirra'] = {
		label = "Levure de Bière",
		weight = 0.01,
	},
	['lighter'] = {
		label = "Briquet",
		weight = 0.01,
	},
	['lime'] = {
		label = "Citron Vert",
		weight = 0.01,
	},
	['limonade'] = {
		label = "Limonade",
		weight = 0.01,
	},
	['lipstick'] = {
		label = "Rouge à Lèvres",
		weight = 0.01,
	},
	['lithium'] = {
		label = "Lithium",
		weight = 0.01,
	},
	['little_clucker'] = {
		label = "Petit Poulet",
		weight = 0.01,
	},
	['little_goldbar'] = {
		label = "Petit Lingot d'Or",
		weight = 0.01,
	},
	['little_keys'] = {
		label = "Petites Clés",
		weight = 0.01,
	},
	['lockpick'] = {
		label = "Crochet de Serrure",
		weight = 0.01,
	},
	['lockpick_set'] = {
		label = "Set de Crochets",
		weight = 0.01,
	},
	['lockpick_try'] = {
		label = "Essai de Crochet de Serrure",
		weight = 0.01,
	},
	['lockpick_v2'] = {
		label = "Crochet de Serrure V2",
		weight = 0.01,
	},
	['locksystem'] = {
		label = "Système de Serrure",
		weight = 0.01,
	},
	['logger_beer'] = {
		label = "Bière Logger",
		weight = 0.01,
	},
	['lost_cut'] = {
		label = "Coupe Perdue",
		weight = 0.01,
	},
	['lotteryticket'] = {
		label = "Billet de Loterie",
		weight = 0.01,
	},
	['lowgradefert'] = {
		label = "Engrais de Bas Niveau",
		weight = 0.01,
	},
	['lsdtab'] = {
		label = "Tab LSD",
		weight = 0.01,
	},
	['lsd_machine'] = {
		label = "Machine LSD",
		weight = 0.01,
	},
	['lumpia'] = {
		label = "Lumpia",
		weight = 0.01,
	},
	['lychee_blue'] = {
		label = "Litchi Bleu",
		weight = 0.01,
	},
	['macallan'] = {
		label = "Macallan",
		weight = 0.01,
	},
	['macaron'] = {
		label = "Macaron",
		weight = 0.01,
	},
	['macka'] = {
		label = "Macka",
		weight = 0.01,
	},
	['macn_cheese'] = {
		label = "Macaroni au Fromage",
		weight = 0.01,
	},
	['madame_lr'] = {
		label = "Madame LR",
		weight = 0.01,
	},
	['makeup'] = {
		label = "Maquillage",
		weight = 0.01,
	},
	['maltese_falcon'] = {
		label = "Faucon Maltais",
		weight = 0.01,
	},
	['malto'] = {
		label = "Malto",
		weight = 0.01,
	},
	['maneki_neko'] = {
		label = "Maneki Neko",
		weight = 0.01,
	},
	['marabou'] = {
		label = "Marabout",
		weight = 0.01,
	},
	['marmellata'] = {
		label = "Marmelade",
		weight = 0.01,
	},
	['martini'] = {
		label = "Martini",
		weight = 0.01,
	},
	['masque'] = {
		label = "Masque",
		weight = 0.01,
	},
	['masque_ghostface'] = {
		label = "Masque Ghostface",
		weight = 0.01,
	},
	['matelat'] = {
		label = "Matelas",
		weight = 0.01,
	},
	['matryoshka_doll'] = {
		label = "Poupée Matryoshka",
		weight = 0.01,
	},
	['mdma'] = {
		label = "MDMA",
		weight = 0.01,
	},
	['mdma_machine'] = {
		label = "Machine MDMA",
		weight = 0.01,
	},
	['meatlessburger'] = {
		label = "Burger Sans Viande",
		weight = 0.01,
	},
	['meatshake'] = {
		label = "Milkshake de Viande",
		weight = 0.01,
	},
	['meat_free'] = {
		label = "Sans Viande",
		weight = 0.01,
	},
	['medal_bravery'] = {
		label = "Médaille de Bravoure",
		weight = 0.01,
	},
	['medal_honor'] = {
		label = "Médaille d'Honneur",
		weight = 0.01,
	},
	['medicinepremeth'] = {
		label = "Médecine Premeth",
		weight = 0.01,
	},
	['medikit'] = {
		label = "Medikit",
		weight = 0.01,
	},
	['medkit'] = {
		label = "Kit Médical",
		weight = 0.01,
	},
	['megasundae'] = {
		label = "Mega Sundae",
		weight = 0.01,
	},
	['melange_sportif'] = {
		label = "Mélange Sportif",
		weight = 0.01,
	},
	['menottes_rose'] = {
		label = "Menottes Roses",
		weight = 0.01,
	},
	['mensboxers'] = {
		label = "Boxers Masculins",
		weight = 0.01,
	},
	['menu_resto'] = {
		label = "Menu de Restaurant",
		weight = 0.01,
	},
	['metalscrap'] = {
		label = "Déchets Métalliques",
		weight = 0.01,
	},
	['metal_detector'] = {
		label = "Détecteur de Métaux",
		weight = 0.01,
	},
	['meth'] = {
		label = "Meth",
		weight = 0.01,
	},
	['meth1'] = {
		label = "Meth 1",
		weight = 0.01,
	},
	['meth2'] = {
		label = "Meth 2",
		weight = 0.01,
	},
	['methylamine'] = {
		label = "Méthylamine",
		weight = 0.01,
	},
	['meth_baggy'] = {
		label = "Sac de Meth",
		weight = 0.01,
	},
	['meth_bluesky'] = {
		label = "Meth Ciel Bleu",
		weight = 0.01,
	},
	['meth_crank'] = {
		label = "Meth Crank",
		weight = 0.01,
	},
	['meth_cristal'] = {
		label = "Meth Cristal",
		weight = 0.01,
	},
	['meth_machine'] = {
		label = "Machine à Meth",
		weight = 0.01,
	},
	['meth_packaged'] = {
		label = "Meth Emballée",
		weight = 0.01,
	},
	['meth_packaged_bluesky'] = {
		label = "Meth Emballée Ciel Bleu",
		weight = 0.01,
	},
	['meth_packaged_crank'] = {
		label = "Meth Emballée Crank",
		weight = 0.01,
	},
	['meth_packaged_cristal'] = {
		label = "Meth Emballée Cristal",
		weight = 0.01,
	},
	['meth_packaged_peach'] = {
		label = "Meth Emballée Pêche",
		weight = 0.01,
	},
	['meth_packaged_simple'] = {
		label = "Meth Emballée Simple",
		weight = 0.01,
	},
	['meth_packaged_speed'] = {
		label = "Meth Emballée Speed",
		weight = 0.01,
	},
	['meth_peach'] = {
		label = "Meth Pêche",
		weight = 0.01,
	},
	['meth_pooch'] = {
		label = "Meth Pooch",
		weight = 0.01,
	},
	['meth_raw'] = {
		label = "Meth Brute",
		weight = 0.01,
	},
	['meth_speed'] = {
		label = "Meth Speed",
		weight = 0.01,
	},
	['michelada'] = {
		label = "Michelada",
		weight = 0.01,
	},
	['micro'] = {
		label = "Micro",
		weight = 0.01,
	},
	['micro_processor'] = {
		label = "Microprocesseur",
		weight = 0.01,
	},
	['micro_scene'] = {
		label = "Scène Micro",
		weight = 0.01,
	},
	['mic_trophy'] = {
		label = "Trophée MIC",
		weight = 0.01,
	},
	['milk'] = {
		label = "Lait",
		weight = 0.01,
	},
	['milkshake'] = {
		label = "Milkshake",
		weight = 0.01,
	},
	['milkshake_proteine'] = {
		label = "Milkshake Protéiné",
		weight = 0.01,
	},
	['mire'] = {
		label = "Mire",
		weight = 0.01,
	},
	['mirtilli'] = {
		label = "Myrtilles",
		weight = 0.01,
	},
	['mixednuts'] = {
		label = "Mélange de Noix",
		weight = 0.01,
	},
	['mixtape'] = {
		label = "MixTape",
		weight = 0.01,
	},
	['mkii_usb_device'] = {
		label = "Dispositif USB MkII",
		weight = 0.01,
	},
	['mobile_phone'] = {
		label = "Téléphone Mobile",
		weight = 0.01,
	},
	['mochi'] = {
		label = "Mochi",
		weight = 0.01,
	},
	['mochi_bleu'] = {
		label = "Mochi Bleu",
		weight = 0.01,
	},
	['mochi_marron'] = {
		label = "Mochi Marron",
		weight = 0.01,
	},
	['mochi_rose'] = {
		label = "Mochi Rose",
		weight = 0.01,
	},
	['mochi_vert'] = {
		label = "Mochi Vert",
		weight = 0.01,
	},
	['mojito'] = {
		label = "Mojito",
		weight = 0.01,
	},
	['mojito_fraise'] = {
		label = "Mojito Fraise",
		weight = 0.01,
	},
	['mojito_myrtille'] = {
		label = "Mojito Myrtille",
		weight = 0.01,
	},
	['mojito_orange'] = {
		label = "Mojito Orange",
		weight = 0.01,
	},
	['mona_lisa'] = {
		label = "Mona Lisa",
		weight = 0.01,
	},
	['moneybag'] = {
		label = "Sac d'Argent",
		weight = 0.01,
	},
	['money_ink_crate'] = {
		label = "Caisse d'Encre d'Argent",
		weight = 0.01,
	},
	['money_ink_set'] = {
		label = "Set d'Encre d'Argent",
		weight = 0.01,
	},
	['money_shot'] = {
		label = "Tir d'Argent",
		weight = 0.01,
	},
	['monster'] = {
		label = "Monstre",
		weight = 0.01,
	},
	['moonshine_jug'] = {
		label = "Bocal de Lune",
		weight = 0.01,
	},
	['morphine'] = {
		label = "Morphine",
		weight = 0.01,
	},
	['moule_pistolet'] = {
		label = "Moule Pistolet",
		weight = 0.01,
	},
	['mozarella'] = {
		label = "Mozzarella",
		weight = 0.01,
	},
	['mozzarellasticks'] = {
		label = "Bâtonnets de Mozzarella",
		weight = 0.01,
	},
	['muffin'] = {
		label = "Muffin",
		weight = 0.01,
	},
	['muffin_special'] = {
		label = "Muffin Spécial",
		weight = 0.01,
	},
	['mug_of_beer'] = {
		label = "Mug de Bière",
		weight = 0.01,
	},
	['mushroom'] = {
		label = "Champignon",
		weight = 0.01,
	},
	['mustard'] = {
		label = "Moutarde",
		weight = 0.01,
	},
	['mustard_seed'] = {
		label = "Graine de Moutarde",
		weight = 0.01,
	},
	['mysterious_vial'] = {
		label = "Vial Mystérieux",
		weight = 0.01,
	},
	['nachos'] = {
		label = "Nachos",
		weight = 0.01,
	},
	['nandrolone'] = {
		label = "Nandrolone",
		weight = 0.01,
	},
	['napoleonic_egg'] = {
		label = "Œuf Napoléonien",
		weight = 0.01,
	},
	['necklace'] = {
		label = "Collier",
		weight = 0.01,
	},
	['newspaper'] = {
		label = "Journal",
		weight = 0.01,
	},
	['nitrate'] = {
		label = "Nitrate",
		weight = 0.01,
	},
	['nitrate_argent'] = {
		label = "Nitrate Argent",
		weight = 0.01,
	},
	['nitrate_bag'] = {
		label = "Sac de Nitrate",
		weight = 0.01,
	},
	['nitrous'] = {
		label = "Nitreux",
		weight = 0.01,
	},
	['nitrous_oxide'] = {
		label = "Oxyde Nitreux",
		weight = 0.01,
	},
	['nitro_tank'] = {
		label = "Réservoir de Nitro",
		weight = 0.01,
	},
	['no10'] = {
		label = "No 10",
		weight = 0.01,
	},
	['no5'] = {
		label = "No 5",
		weight = 0.01,
	},
	['noix_coco'] = {
		label = "Noix de Coco",
		weight = 0.01,
	},
	['nokia_phone'] = {
		label = "Téléphone Nokia",
		weight = 0.01,
	},
	['nos'] = {
		label = "NOS",
		weight = 0.01,
	},
	['nouille'] = {
		label = "Nouille",
		weight = 0.01,
	},
	['nouille_sautee'] = {
		label = "Nouille Sautée",
		weight = 0.01,
	},
	['npaper'] = {
		label = "Papier",
		weight = 0.01,
	},
	['nuts_and_bolts'] = {
		label = "Boulons et Écrous",
		weight = 0.01,
	},
	['oakley_sunglasses'] = {
		label = "Lunettes de Soleil Oakley",
		weight = 0.01,
	},
	['objet_ancien_1'] = {
		label = "Objet Ancien 1",
		weight = 0.01,
	},
	['objet_ancien_2'] = {
		label = "Objet Ancien 2",
		weight = 0.01,
	},
	['objet_ancien_3'] = {
		label = "Objet Ancien 3",
		weight = 0.01,
	},
	['objet_ancien_4'] = {
		label = "Objet Ancien 4",
		weight = 0.01,
	},
	['oil'] = {
		label = "Huile",
		weight = 0.01,
	},
	['oil_hallu'] = {
		label = "Huile Hallucinogène",
		weight = 0.01,
	},
	['oil_olive'] = {
		label = "Huile d'Olive",
		weight = 0.01,
	},
	['olio'] = {
		label = "Huile",
		weight = 0.01,
	},
	['olive'] = {
		label = "Olive",
		weight = 0.01,
	},
	['olive2'] = {
		label = "Olive 2",
		weight = 0.01,
	},
	['onigiri'] = {
		label = "Onigiri",
		weight = 0.01,
	},
	['onion'] = {
		label = "Oignon",
		weight = 0.01,
	},
	['onionrings'] = {
		label = "Rondelles d'Oignon",
		weight = 0.01,
	},
	['onion_pie'] = {
		label = "Tarte à l'Oignon",
		weight = 0.01,
	},
	['onion_seed'] = {
		label = "Graine d'Oignon",
		weight = 0.01,
	},
	['opium'] = {
		label = "Opium",
		weight = 0.01,
	},
	['opiumbrick'] = {
		label = "Brique d'Opium",
		weight = 0.01,
	},
	['opium_pooch'] = {
		label = "Pooch d'Opium",
		weight = 0.01,
	},
	['opium_seed'] = {
		label = "Graine d'Opium",
		weight = 0.01,
	},
	['orange'] = {
		label = "Orange",
		weight = 0.01,
	},
	['orangejuice'] = {
		label = "Jus d'Orange",
		weight = 0.01,
	},
	['oreille'] = {
		label = "Oreille",
		weight = 0.01,
	},
	['origami_crane'] = {
		label = "Grue Origami",
		weight = 0.01,
	},
	['orzo'] = {
		label = "Orzo",
		weight = 0.01,
	},
	['ottone'] = {
		label = "Ottone",
		weight = 0.01,
	},
	['ouija_table'] = {
		label = "Table Ouija",
		weight = 0.01,
	},
	['oxy'] = {
		label = "Oxy",
		weight = 0.01,
	},
	['oxyde_cuivre'] = {
		label = "Oxyde de Cuivre",
		weight = 0.01,
	},
	['oxygen_tank'] = {
		label = "Réservoir d'Oxygène",
		weight = 0.01,
	},
	['packaged_chicken'] = {
		label = "Poulet Emballé",
		weight = 0.01,
	},
	['pack_of_empty_baggies'] = {
		label = "Paquet de Sacs Vides",
		weight = 0.01,
	},
	['painkillers'] = {
		label = "Analgésiques",
		weight = 0.01,
	},
	['paintball_token'] = {
		label = "Jeton de Paintball",
		weight = 0.01,
	},
	['paintingf'] = {
		label = "Peinture F",
		weight = 0.01,
	},
	['paintingg'] = {
		label = "Peinture G",
		weight = 0.01,
	},
	['paintingh'] = {
		label = "Peinture H",
		weight = 0.01,
	},
	['paintingj'] = {
		label = "Peinture J",
		weight = 0.01,
	},
	['painting_1'] = {
		label = "Peinture 1",
		weight = 0.01,
	},
	['painting_2'] = {
		label = "Peinture 2",
		weight = 0.01,
	},
	['painting_3'] = {
		label = "Peinture 3",
		weight = 0.01,
	},
	['pak_choi'] = {
		label = "Pak Choi",
		weight = 0.01,
	},
	['pallet_of_boxes'] = {
		label = "Palette de Caisses",
		weight = 0.01,
	},
	['pancakes'] = {
		label = "Pancakes",
		weight = 0.01,
	},
	['pancakes_proteines'] = {
		label = "Pancakes Protéinés",
		weight = 0.01,
	},
	['pancreas'] = {
		label = "Pancréas",
		weight = 0.01,
	},
	['pane'] = {
		label = "Pain",
		weight = 0.01,
	},
	['panini_sandwich'] = {
		label = "Sandwich Panini",
		weight = 0.01,
	},
	['panna_cotta'] = {
		label = "Panna Cotta",
		weight = 0.01,
	},
	['panties'] = {
		label = "Culottes",
		weight = 0.01,
	},
	['paperbag'] = {
		label = "Sac en Papier",
		weight = 0.01,
	},
	['parkingticket'] = {
		label = "Billet de Stationnement",
		weight = 0.01,
	},
	['parkingviolation'] = {
		label = "Violation de Stationnement",
		weight = 0.01,
	},
	['park_beens'] = {
		label = "Haricots de Parc",
		weight = 0.01,
	},
	['passed_test'] = {
		label = "Test Réussi",
		weight = 0.01,
	},
	['pasta'] = {
		label = "Pâtes",
		weight = 0.01,
	},
	['pasteque'] = {
		label = "Pastèque",
		weight = 0.01,
	},
	['patata'] = {
		label = "Pomme de Terre",
		weight = 0.01,
	},
	['patatine'] = {
		label = "Patatine",
		weight = 0.01,
	},
	['pates_sardine'] = {
		label = "Pâtes aux Sardines",
		weight = 0.01,
	},
	['payne_portrait'] = {
		label = "Portrait de Payne",
		weight = 0.01,
	},
	['pcmicro'] = {
		label = "Micro PC",
		weight = 0.01,
	},
	['pc_cams'] = {
		label = "Caméras PC",
		weight = 0.01,
	},
	['pc_cams_cayo'] = {
		label = "Caméras PC Cayo",
		weight = 0.01,
	},
	['pc_cams_gouv'] = {
		label = "Caméras PC Gouvernementales",
		weight = 0.01,
	},
	['pc_cams_rocks'] = {
		label = "Caméras PC Rocks",
		weight = 0.01,
	},
	['pearl_necklace'] = {
		label = "Collier de Perles",
		weight = 0.01,
	},
	['pecanpie'] = {
		label = "Tarte aux Pacanes",
		weight = 0.01,
	},
	['pepper'] = {
		label = "Poivre",
		weight = 0.01,
	},
	['peppermintmocha'] = {
		label = "Mocha à la Menthe",
		weight = 0.01,
	},
	['pepperoni'] = {
		label = "Pepperoni",
		weight = 0.01,
	},
	['perfsang'] = {
		label = "Perf Sang",
		weight = 0.01,
	},
	['perfusion'] = {
		label = "Perfusion",
		weight = 0.01,
	},
	['pescecrudo'] = {
		label = "Poisson Cru",
		weight = 0.01,
	},
	['pesce_1'] = {
		label = "Poisson 1",
		weight = 0.01,
	},
	['pesce_2'] = {
		label = "Poisson 2",
		weight = 0.01,
	},
	['pesce_3'] = {
		label = "Poisson 3",
		weight = 0.01,
	},
	['pesce_4'] = {
		label = "Poisson 4",
		weight = 0.01,
	},
	['pesce_5'] = {
		label = "Poisson 5",
		weight = 0.01,
	},
	['pesce_6'] = {
		label = "Poisson 6",
		weight = 0.01,
	},
	['pesce_7'] = {
		label = "Poisson 7",
		weight = 0.01,
	},
	['pesos'] = {
		label = "Pesos",
		weight = 0.01,
	},
	['petit_pot_peinture'] = {
		label = "Petit Pot de Peinture",
		weight = 0.01,
	},
	['pet_chicken'] = {
		label = "Poulet de Compagnie",
		weight = 0.01,
	},
	['pet_fish'] = {
		label = "Poisson de Compagnie",
		weight = 0.01,
	},
	['pet_rock'] = {
		label = "Pierre de Compagnie",
		weight = 0.01,
	},
	['pet_turtle'] = {
		label = "Tortue de Compagnie",
		weight = 0.01,
	},
	['phone'] = {
		label = "Téléphone",
		weight = 0.01,
	},
	['phosphorus'] = {
		label = "Phosphore",
		weight = 0.01,
	},
	['photo'] = {
		label = "Photo",
		weight = 0.01,
	},
	['pietra'] = {
		label = "Pierre",
		weight = 0.01,
	},
	['pietra2'] = {
		label = "Pierre 2",
		weight = 0.01,
	},
	['pills'] = {
		label = "Pilules",
		weight = 0.01,
	},
	['piment'] = {
		label = "Piment",
		weight = 0.01,
	},
	['pimp_chalice'] = {
		label = "Calice Pimp",
		weight = 0.01,
	},
	['pina_colada'] = {
		label = "Piña Colada",
		weight = 0.01,
	},
	['pinklady'] = {
		label = "Dame Rose",
		weight = 0.01,
	},
	['pink_faberge_egg'] = {
		label = "Œuf Fabergé Rose",
		weight = 0.01,
	},
	['pins_sidaction'] = {
		label = "Épingles Sidaction",
		weight = 0.01,
	},
	['pixel_2_phone'] = {
		label = "Téléphone Pixel 2",
		weight = 0.01,
	},
	['pizza'] = {
		label = "Pizza",
		weight = 0.01,
	},
	['pizza_fruit_mer'] = {
		label = "Pizza Fruits de Mer",
		weight = 0.01,
	},
	['pizza_slice'] = {
		label = "Part de Pizza",
		weight = 0.01,
	},
	['plaster'] = {
		label = "Plâtre",
		weight = 0.01,
	},
	['plaster_cutter'] = {
		label = "Coupe-Plâtre",
		weight = 0.01,
	},
	['plaster_leftfoot'] = {
		label = "Plâtre Pied Gauche",
		weight = 0.01,
	},
	['plaster_rightfoot'] = {
		label = "Plâtre Pied Droit",
		weight = 0.01,
	},
	['plastic'] = {
		label = "Plastique",
		weight = 0.01,
	},
	['plastica'] = {
		label = "Plastique A",
		weight = 0.01,
	},
	['plate'] = {
		label = "Assiette",
		weight = 0.01,
	},
	['platinum_record'] = {
		label = "Disque de Platine",
		weight = 0.01,
	},
	['platre'] = {
		label = "Plâtre",
		weight = 0.01,
	},
	['poids_muscu'] = {
		label = "Poids Musculation",
		weight = 0.01,
	},
	['poignee_pistolet'] = {
		label = "Poignée de Pistolet",
		weight = 0.01,
	},
	['poignee_pompe'] = {
		label = "Poignée de Pompe",
		weight = 0.01,
	},
	['poire_menthe'] = {
		label = "Poire à la Menthe",
		weight = 0.01,
	},
	['poison'] = {
		label = "Poison",
		weight = 0.01,
	},
	['police_stormram'] = {
		label = "Bélier de Police",
		weight = 0.01,
	},
	['pommade'] = {
		label = "Pommade",
		weight = 0.01,
	},
	['pomme'] = {
		label = "Pomme",
		weight = 0.01,
	},
	['pomme_amour'] = {
		label = "Pomme d'Amour",
		weight = 0.01,
	},
	['pomodori'] = {
		label = "Tomates",
		weight = 0.01,
	},
	['poophone'] = {
		label = "Poophone",
		weight = 0.01,
	},
	['popcorn'] = {
		label = "Popcorn",
		weight = 0.01,
	},
	['popsicle'] = {
		label = "Sucette Glacée",
		weight = 0.01,
	},
	['porc_cru'] = {
		label = "Porc Cru",
		weight = 0.01,
	},
	['portal'] = {
		label = "Portail",
		weight = 0.01,
	},
	['portecle_liberty'] = {
		label = "Porte-Clé Liberty",
		weight = 0.01,
	},
	['portrait_of_drgachet'] = {
		label = "Portrait de Drgachet",
		weight = 0.01,
	},
	['potato'] = {
		label = "Pomme de Terre",
		weight = 0.01,
	},
	['potatochips'] = {
		label = "Chips de Pommes de Terre",
		weight = 0.01,
	},
	['potato_seed'] = {
		label = "Graine de Pomme de Terre",
		weight = 0.01,
	},
	['poulet_roti'] = {
		label = "Poulet Rôti",
		weight = 0.01,
	},
	['poumon'] = {
		label = "Poumon",
		weight = 0.01,
	},
	['powdertest'] = {
		label = "Test de Poudre",
		weight = 0.01,
	},
	['preservatif_blanc'] = {
		label = "Préservatif Blanc",
		weight = 0.01,
	},
	['preservatif_bleu'] = {
		label = "Préservatif Bleu",
		weight = 0.01,
	},
	['preservatif_jaune'] = {
		label = "Préservatif Jaune",
		weight = 0.01,
	},
	['preservatif_noir'] = {
		label = "Préservatif Noir",
		weight = 0.01,
	},
	['preservatif_or'] = {
		label = "Préservatif Or",
		weight = 0.01,
	},
	['preservatif_orange'] = {
		label = "Préservatif Orange",
		weight = 0.01,
	},
	['preservatif_rose'] = {
		label = "Préservatif Rose",
		weight = 0.01,
	},
	['preservatif_rouge'] = {
		label = "Préservatif Rouge",
		weight = 0.01,
	},
	['preservatif_sidaction'] = {
		label = "Préservatif Sidaction",
		weight = 0.01,
	},
	['preservatif_standard'] = {
		label = "Préservatif Standard",
		weight = 0.01,
	},
	['preservatif_turquoise'] = {
		label = "Préservatif Turquoise",
		weight = 0.01,
	},
	['preservatif_vert'] = {
		label = "Préservatif Vert",
		weight = 0.01,
	},
	['preservatif_violet'] = {
		label = "Préservatif Violet",
		weight = 0.01,
	},
	['preservatif_xl'] = {
		label = "Préservatif XL",
		weight = 0.01,
	},
	['pretzel'] = {
		label = "Bretzel",
		weight = 0.01,
	},
	['printeddocument'] = {
		label = "Document Imprimé",
		weight = 0.01,
	},
	['printerdocument'] = {
		label = "Document d'Imprimante",
		weight = 0.01,
	},
	['proof_bullet'] = {
		label = "Balle à Épreuve",
		weight = 0.01,
	},
	['proof_shell'] = {
		label = "Coquille à Épreuve",
		weight = 0.01,
	},
	['propylene_glycol'] = {
		label = "Glycol de Propylène",
		weight = 0.01,
	},
	['prosciutto'] = {
		label = "Prosciutto",
		weight = 0.01,
	},
	['prosecco'] = {
		label = "Prosecco",
		weight = 0.01,
	},
	['proteine_energy'] = {
		label = "Protéine Énergétique",
		weight = 0.01,
	},
	['proteine_muscle2000'] = {
		label = "Protéine Muscle 2000",
		weight = 0.01,
	},
	['proteine_vegan'] = {
		label = "Protéine Végane",
		weight = 0.01,
	},
	['psp'] = {
		label = "PSP",
		weight = 0.01,
	},
	['puff_pastry'] = {
		label = "Pâte Feuilletée",
		weight = 0.01,
	},
	['pumpkin'] = {
		label = "Citrouille",
		weight = 0.01,
	},
	['pumpkinpie'] = {
		label = "Tarte à la Citrouille",
		weight = 0.01,
	},
	['pumpkinspicelatte'] = {
		label = "Latte aux Épices de Citrouille",
		weight = 0.01,
	},
	['pumpkin_seed'] = {
		label = "Graine de Citrouille",
		weight = 0.01,
	},
	['pure'] = {
		label = "Pur",
		weight = 0.01,
	},
	['pure_whey'] = {
		label = "Whey Pure",
		weight = 0.01,
	},
	['purifiedwater'] = {
		label = "Eau Purifiée",
		weight = 0.01,
	},
	['purplelight'] = {
		label = "Lumière Violet",
		weight = 0.01,
	},
	['purple_bandana'] = {
		label = "Bandana Violet",
		weight = 0.01,
	},
	['queen_of_hearts'] = {
		label = "Reine de Cœur",
		weight = 0.01,
	},
	['quesadilla'] = {
		label = "Quesadilla",
		weight = 0.01,
	},
	['rabbit_pelt'] = {
		label = "Peau de Lapin",
		weight = 0.01,
	},
	['race_brakes'] = {
		label = "Freins de Course",
		weight = 0.01,
	},
	['race_suspension'] = {
		label = "Suspension de Course",
		weight = 0.01,
	},
	['race_transmition'] = {
		label = "Transmission de Course",
		weight = 0.01,
	},
	['racing_rims'] = {
		label = "Jantes de Course",
		weight = 0.01,
	},
	['racing_trophy'] = {
		label = "Trophée de Course",
		weight = 0.01,
	},
	['radio'] = {
		label = "Radio",
		weight = 0.01,
	},
	['radio2'] = {
		label = "Radio 2",
		weight = 0.01,
	},
	['radio_scanner'] = {
		label = "Scanner Radio",
		weight = 0.01,
	},
	['ragout_de_boeuf'] = {
		label = "Ragoût de Boeuf",
		weight = 0.01,
	},
	['raisin'] = {
		label = "Raisin",
		weight = 0.01,
	},
	['ramen'] = {
		label = "Ramen",
		weight = 0.01,
	},
	['ramen_boeuf'] = {
		label = "Ramen au Boeuf",
		weight = 0.01,
	},
	['ramen_cup'] = {
		label = "Ramen en Tasse",
		weight = 0.01,
	},
	['ramen_nature'] = {
		label = "Ramen Nature",
		weight = 0.01,
	},
	['ramen_porc'] = {
		label = "Ramen au Porc",
		weight = 0.01,
	},
	['ramen_poulet'] = {
		label = "Ramen au Poulet",
		weight = 0.01,
	},
	['ramune'] = {
		label = "Ramune",
		weight = 0.01,
	},
	['rarebook'] = {
		label = "Livre Rare",
		weight = 0.01,
	},
	['rarecoin'] = {
		label = "Pièce Rare",
		weight = 0.01,
	},
	['rawbeef'] = {
		label = "Boeuf Cru",
		weight = 0.01,
	},
	['rawchicken'] = {
		label = "Poulet Cru",
		weight = 0.01,
	},
	['rawfish'] = {
		label = "Poisson Cru",
		weight = 0.01,
	},
	['rawgold'] = {
		label = "Or Brut",
		weight = 0.01,
	},
	['rawpork'] = {
		label = "Porc Cru",
		weight = 0.01,
	},
	['rawsteak'] = {
		label = "Steak Cru",
		weight = 0.01,
	},
	['rawturkey'] = {
		label = "Dinde Crue",
		weight = 0.01,
	},
	['raw_petrol'] = {
		label = "Pétrole Brut",
		weight = 0.01,
	},
	['rear_bumper'] = {
		label = "Pare-Chocs Arrière",
		weight = 0.01,
	},
	['recoupon10'] = {
		label = "Coupon 10",
		weight = 0.01,
	},
	['recoupon15'] = {
		label = "Coupon 15",
		weight = 0.01,
	},
	['recoupon20'] = {
		label = "Coupon 20",
		weight = 0.01,
	},
	['recoupon5'] = {
		label = "Coupon 5",
		weight = 0.01,
	},
	['recyclable_material'] = {
		label = "Matériaux Recyclables",
		weight = 0.01,
	},
	['redbull'] = {
		label = "Red Bull",
		weight = 0.01,
	},
	['redking'] = {
		label = "Roi Rouge",
		weight = 0.01,
	},
	['redwood_pack'] = {
		label = "Pack Redwood",
		weight = 0.01,
	},
	['red_bandana'] = {
		label = "Bandana Rouge",
		weight = 0.01,
	},
	['red_belt'] = {
		label = "Ceinture Rouge",
		weight = 0.01,
	},
	['red_chip'] = {
		label = "Puce Rouge",
		weight = 0.01,
	},
	['red_wine_bottle'] = {
		label = "Bouteille de Vin Rouge",
		weight = 0.01,
	},
	['refined_petrol'] = {
		label = "Pétrole Raffiné",
		weight = 0.01,
	},
	['regular_watch'] = {
		label = "Montre Classique",
		weight = 0.01,
	},
	['rein'] = {
		label = "Renfort",
		weight = 0.01,
	},
	['repairkit'] = {
		label = "Kit de Réparation",
		weight = 0.01,
	},
	['repair_toolkit'] = {
		label = "Boîte à Outils de Réparation",
		weight = 0.01,
	},
	['ressort'] = {
		label = "Ressort",
		weight = 0.01,
	},
	['rhum'] = {
		label = "Rhum",
		weight = 0.01,
	},
	['rhumcoca'] = {
		label = "Rhum Coca",
		weight = 0.01,
	},
	['ribs'] = {
		label = "Côtes",
		weight = 0.01,
	},
	['rice_noodles'] = {
		label = "Nouilles de Riz",
		weight = 0.01,
	},
	['riz'] = {
		label = "Riz",
		weight = 0.01,
	},
	['rolex'] = {
		label = "Rolex",
		weight = 0.01,
	},
	['rolex2_watch'] = {
		label = "Montre Rolex 2",
		weight = 0.01,
	},
	['rolexwatch'] = {
		label = "Montre Rolex",
		weight = 0.01,
	},
	['rolex_watch'] = {
		label = "Montre Rolex",
		weight = 0.01,
	},
	['rolling_paper'] = {
		label = "Papier à Rouler",
		weight = 0.01,
	},
	['romance_novel'] = {
		label = "Roman d'Amour",
		weight = 0.01,
	},
	['rooosters'] = {
		label = "Coqs",
		weight = 0.01,
	},
	['rooster_pin'] = {
		label = "Épinglette de Coq",
		weight = 0.01,
	},
	['rose'] = {
		label = "Rose",
		weight = 0.01,
	},
	['router'] = {
		label = "Routeur",
		weight = 0.01,
	},
	['rubber'] = {
		label = "Caoutchouc",
		weight = 0.01,
	},
	['ruby'] = {
		label = "Rubis",
		weight = 0.01,
	},
	['ruby_necklace'] = {
		label = "Collier en Rubis",
		weight = 0.01,
	},
	['ruby_ring'] = {
		label = "Bague en Rubis",
		weight = 0.01,
	},
	['rum'] = {
		label = "Rhum",
		weight = 0.01,
	},
	['rumbottle'] = {
		label = "Bouteille de Rhum",
		weight = 0.01,
	},
	['rumshot'] = {
		label = "Shot de Rhum",
		weight = 0.01,
	},
	['sac'] = {
		label = "Sac",
		weight = 0.01,
	},
	['sacco'] = {
		label = "Sac",
		weight = 0.01,
	},
	['sac_mortuaire'] = {
		label = "Sac Mortuaire",
		weight = 0.01,
	},
	['sadao'] = {
		label = "Sadao",
		weight = 0.01,
	},
	['safe'] = {
		label = "Coffre-Fort",
		weight = 0.01,
	},
	['safelock_try'] = {
		label = "Essai de Coffre-Fort",
		weight = 0.01,
	},
	['sake'] = {
		label = "Saké",
		weight = 0.01,
	},
	['saksi'] = {
		label = "Saksi",
		weight = 0.01,
	},
	['salad'] = {
		label = "Salade",
		weight = 0.01,
	},
	['salad_seed'] = {
		label = "Graine de Salade",
		weight = 0.01,
	},
	['salatini'] = {
		label = "Salatini",
		weight = 0.01,
	},
	['sale'] = {
		label = "Sale",
		weight = 0.01,
	},
	['salumi'] = {
		label = "Salumi",
		weight = 0.01,
	},
	['salvator_mundi'] = {
		label = "Salvator Mundi",
		weight = 0.01,
	},
	['samsungphone'] = {
		label = "Téléphone Samsung",
		weight = 0.01,
	},
	['samsung_s8'] = {
		label = "Samsung S8",
		weight = 0.01,
	},
	['sandisland'] = {
		label = "Île de Sable",
		weight = 0.01,
	},
	['sandwich'] = {
		label = "Sandwich",
		weight = 0.01,
	},
	['sandwichcocorico'] = {
		label = "Sandwich Cocorico",
		weight = 0.01,
	},
	['sapphire'] = {
		label = "Saphir",
		weight = 0.01,
	},
	['sapphire_necklace'] = {
		label = "Collier en Saphir",
		weight = 0.01,
	},
	['sapphire_ring'] = {
		label = "Bague en Saphir",
		weight = 0.01,
	},
	['sauce_tomate'] = {
		label = "Sauce Tomate",
		weight = 0.01,
	},
	['saucisson'] = {
		label = "Saucisson",
		weight = 0.01,
	},
	['sausage'] = {
		label = "Saucisse",
		weight = 0.01,
	},
	['saute_tofu'] = {
		label = "Tofu Sauté",
		weight = 0.01,
	},
	['saying_grace'] = {
		label = "Dire Grâce",
		weight = 0.01,
	},
	['sbs_xray'] = {
		label = "Radiographie SBS",
		weight = 0.01,
	},
	['schema'] = {
		label = "Schéma",
		weight = 0.01,
	},
	['schneck'] = {
		label = "Schneck",
		weight = 0.01,
	},
	['scie'] = {
		label = "Scie",
		weight = 0.01,
	},
	['scissors'] = {
		label = "Ciseaux",
		weight = 0.01,
	},
	['scotch_eggs'] = {
		label = "Oeufs de Scotch",
		weight = 0.01,
	},
	['scrap_aluminum'] = {
		label = "Aluminium de Récupération",
		weight = 0.01,
	},
	['scrap_iron'] = {
		label = "Fer de Récupération",
		weight = 0.01,
	},
	['scrap_metal'] = {
		label = "Métal de Récupération",
		weight = 0.01,
	},
	['scrap_steel'] = {
		label = "Acier de Récupération",
		weight = 0.01,
	},
	['scrap_tool'] = {
		label = "Outil de Récupération",
		weight = 0.01,
	},
	['scratch_ticket'] = {
		label = "Billet à Gratter",
		weight = 0.01,
	},
	['screen'] = {
		label = "Écran",
		weight = 0.01,
	},
	['screwdriverset'] = {
		label = "Jeu de Tournevis",
		weight = 0.01,
	},
	['script'] = {
		label = "Script",
		weight = 0.01,
	},
	['sdcard'] = {
		label = "Carte SD",
		weight = 0.01,
	},
	['sealed_bucket'] = {
		label = "Seau Scellé",
		weight = 0.01,
	},
	['sealed_coke'] = {
		label = "Coca Scellé",
		weight = 0.01,
	},
	['sealed_evidence_bag'] = {
		label = "Sac de Preuves Scellé",
		weight = 0.01,
	},
	['seat'] = {
		label = "Siège",
		weight = 0.01,
	},
	['secret_coin'] = {
		label = "Monnaie Secrète",
		weight = 0.01,
	},
	['secret_file'] = {
		label = "Fichier Secret",
		weight = 0.01,
	},
	['securitycase'] = {
		label = "Coffre de Sécurité",
		weight = 0.01,
	},
	['seed'] = {
		label = "Graine",
		weight = 0.01,
	},
	['seringue'] = {
		label = "Seringue",
		weight = 0.01,
	},
	['seringuehemoragie'] = {
		label = "Seringue Hémorragie",
		weight = 0.01,
	},
	['seringue_sang'] = {
		label = "Seringue de Sang",
		weight = 0.01,
	},
	['severed_finger'] = {
		label = "Doigt Sectionné",
		weight = 0.01,
	},
	['sexandhotbeaches'] = {
		label = "Sexe et Plages Chaudes",
		weight = 0.01,
	},
	['sexonthebeach'] = {
		label = "Sex on the Beach",
		weight = 0.01,
	},
	['shampoo'] = {
		label = "Shampoing",
		weight = 0.01,
	},
	['shark'] = {
		label = "Requin",
		weight = 0.01,
	},
	['shark_tooth'] = {
		label = "Dent de Requin",
		weight = 0.01,
	},
	['shears_of_justice'] = {
		label = "Cisailles de la Justice",
		weight = 0.01,
	},
	['shell_oil'] = {
		label = "Huile Shell",
		weight = 0.01,
	},
	['shield'] = {
		label = "Bouclier",
		weight = 0.01,
	},
	['shipping_box'] = {
		label = "Boîte d'Expédition",
		weight = 0.01,
	},
	['shipping_crate'] = {
		label = "Caisse d'Expédition",
		weight = 0.01,
	},
	['shitlockpick'] = {
		label = "Crochet de Serrure Null",
		weight = 0.01,
	},
	['shoshrimp'] = {
		label = "South Shrimp",
		weight = 0.01,
	},
	['shot'] = {
		label = "Tir",
		weight = 0.01,
	},
	['shrimpysandwich'] = {
		label = "Sandwich aux Crevettes",
		weight = 0.01,
	},
	['side_mirror'] = {
		label = "Miroir Latéral",
		weight = 0.01,
	},
	['side_skirts'] = {
		label = "Bas de Caisses",
		weight = 0.01,
	},
	['silver'] = {
		label = "Argent",
		weight = 0.01,
	},
	['silver_coin'] = {
		label = "Pièce d'Argent",
		weight = 0.01,
	},
	['sim'] = {
		label = "SIM",
		weight = 0.01,
	},
	['sim_card'] = {
		label = "Carte SIM",
		weight = 0.01,
	},
	['singleshotburger'] = {
		label = "Burger à Tir Unique",
		weight = 0.01,
	},
	['siren'] = {
		label = "Sireine",
		weight = 0.01,
	},
	['skateboard'] = {
		label = "Skateboard",
		weight = 0.01,
	},
	['slushy'] = {
		label = "Slushy",
		weight = 0.01,
	},
	['smallboat'] = {
		label = "Petit Bateau",
		weight = 0.01,
	},
	['small_scale'] = {
		label = "Petite Balance",
		weight = 0.01,
	},
	['smoketrailred'] = {
		label = "Trace de Fumée Rouge",
		weight = 0.01,
	},
	['snakeskin'] = {
		label = "Peau de Serpent",
		weight = 0.01,
	},
	['snikkel_candy'] = {
		label = "Bonbon Snikkel",
		weight = 0.01,
	},
	['snowchains'] = {
		label = "Chaînes à Neige",
		weight = 0.01,
	},
	['snow_photo'] = {
		label = "Photo de Neige",
		weight = 0.01,
	},
	['snow_vhs'] = {
		label = "VHS de Neige",
		weight = 0.01,
	},
	['soda'] = {
		label = "Soda",
		weight = 0.01,
	},
	['sodamilkis'] = {
		label = "Soda au Lait",
		weight = 0.01,
	},
	['sodapasteque'] = {
		label = "Soda à la Pastèque",
		weight = 0.01,
	},
	['sodaramune'] = {
		label = "Soda Ramune",
		weight = 0.01,
	},
	['soda_chickfila'] = {
		label = "Soda Chick-fil-A",
		weight = 0.01,
	},
	['sodium_benzoate'] = {
		label = "Benzoate de Sodium",
		weight = 0.01,
	},
	['solvente'] = {
		label = "Solvant",
		weight = 0.01,
	},
	['sorted_money'] = {
		label = "Argent Trié",
		weight = 0.01,
	},
	['souffre'] = {
		label = "Soufre",
		weight = 0.01,
	},
	['sound_system'] = {
		label = "Système Audio",
		weight = 0.01,
	},
	['soupe_campbell'] = {
		label = "Soupe Campbell",
		weight = 0.01,
	},
	['soupe_hivernale'] = {
		label = "Soupe Hivernale",
		weight = 0.01,
	},
	['sourcream'] = {
		label = "Crème Aigre",
		weight = 0.01,
	},
	['sour_cream'] = {
		label = "Crème Aigre",
		weight = 0.01,
	},
	['soze_photo'] = {
		label = "Photo Soze",
		weight = 0.01,
	},
	['spaghetti'] = {
		label = "Spaghetti",
		weight = 0.01,
	},
	['spaghettiscoglio'] = {
		label = "Spaghetti Scoglio",
		weight = 0.01,
	},
	['spaghetti_can'] = {
		label = "Spaghetti en Boîte",
		weight = 0.01,
	},
	['spaghetti_maquereau'] = {
		label = "Spaghetti au Maquereau",
		weight = 0.01,
	},
	['sparklinggrapejuice'] = {
		label = "Jus de Raisin Pétillant",
		weight = 0.01,
	},
	['spezie'] = {
		label = "Épices",
		weight = 0.01,
	},
	['splitshake'] = {
		label = "Shake Séparé",
		weight = 0.01,
	},
	['spoiledfood'] = {
		label = "Nourriture Gâtée",
		weight = 0.01,
	},
	['spoiler'] = {
		label = "Spoiler",
		weight = 0.01,
	},
	['sponge'] = {
		label = "Éponge",
		weight = 0.01,
	},
	['spray'] = {
		label = "Spray",
		weight = 0.01,
	},
	['sprite'] = {
		label = "Sprite",
		weight = 0.01,
	},
	['spritz'] = {
		label = "Spritz",
		weight = 0.01,
	},
	['sprunk'] = {
		label = "Sprunk",
		weight = 0.01,
	},
	['stage1remap'] = {
		label = "Remappage de Stage 1",
		weight = 0.01,
	},
	['stage2remap'] = {
		label = "Remappage de Stage 2",
		weight = 0.01,
	},
	['stage3remap'] = {
		label = "Remappage de Stage 3",
		weight = 0.01,
	},
	['starry_night'] = {
		label = "Nuit Étoilée",
		weight = 0.01,
	},
	['steak_frites'] = {
		label = "Steak Frites",
		weight = 0.01,
	},
	['steak_requin'] = {
		label = "Steak de Requin",
		weight = 0.01,
	},
	['steel'] = {
		label = "Acier",
		weight = 0.01,
	},
	['stethoscope'] = {
		label = "Stéthoscope",
		weight = 0.01,
	},
	['stickynote'] = {
		label = "Note Autocollante",
		weight = 0.01,
	},
	['stock_brakes'] = {
		label = "Freins de Stock",
		weight = 0.01,
	},
	['stock_engine'] = {
		label = "Moteur de Stock",
		weight = 0.01,
	},
	['stock_oil'] = {
		label = "Huile de Stock",
		weight = 0.01,
	},
	['stock_suspension'] = {
		label = "Suspension de Stock",
		weight = 0.01,
	},
	['stock_tires'] = {
		label = "Pneus de Stock",
		weight = 0.01,
	},
	['stock_transmition'] = {
		label = "Transmission de Stock",
		weight = 0.01,
	},
	['stoffa'] = {
		label = "Stoffa",
		weight = 0.01,
	},
	['stone'] = {
		label = "Pierre",
		weight = 0.01,
	},
	['stretcher1'] = {
		label = "Brancard 1",
		weight = 0.01,
	},
	['stretcher2'] = {
		label = "Brancard 2",
		weight = 0.01,
	},
	['stretcher3'] = {
		label = "Brancard 3",
		weight = 0.01,
	},
	['stretcher4'] = {
		label = "Brancard 4",
		weight = 0.01,
	},
	['stretcher5'] = {
		label = "Brancard 5",
		weight = 0.01,
	},
	['stuzzichini'] = {
		label = "Stuzzichini",
		weight = 0.01,
	},
	['sugar'] = {
		label = "Sucre",
		weight = 0.01,
	},
	['sugarcane'] = {
		label = "Canne à Sucre",
		weight = 0.01,
	},
	['suitcase'] = {
		label = "Valise",
		weight = 0.01,
	},
	['sulfur'] = {
		label = "Soufre",
		weight = 0.01,
	},
	['sulfur_bag'] = {
		label = "Sac de Soufre",
		weight = 0.01,
	},
	['sunflower'] = {
		label = "Tournesol",
		weight = 0.01,
	},
	['surfboard'] = {
		label = "Planche de Surf",
		weight = 0.01,
	},
	['sushi'] = {
		label = "Sushi",
		weight = 0.01,
	},
	['sushi_plate'] = {
		label = "Assiette de Sushi",
		weight = 0.01,
	},
	['sushi_rolls'] = {
		label = "Rouleaux de Sushi",
		weight = 0.01,
	},
	['sweetpotatopie'] = {
		label = "Tarte aux Patates Douces",
		weight = 0.01,
	},
	['sweetpotato_seed'] = {
		label = "Graine de Patate Douce",
		weight = 0.01,
	},
	['sweet_potato'] = {
		label = "Patate Douce",
		weight = 0.01,
	},
	['swimmingpool'] = {
		label = "Piscine",
		weight = 0.01,
	},
	['tabacco1'] = {
		label = "Tabac 1",
		weight = 0.01,
	},
	['tabacco2'] = {
		label = "Tabac",
		weight = 0.01,
	},
	['tabasco'] = {
		label = "Tabasco",
		weight = 0.01,
	},
	['tableau_1'] = {
		label = "Tableau 1",
		weight = 0.01,
	},
	['tableau_2'] = {
		label = "Tableau 2",
		weight = 0.01,
	},
	['tableau_3'] = {
		label = "Tableau 3",
		weight = 0.01,
	},
	['tableau_4'] = {
		label = "Tableau 4",
		weight = 0.01,
	},
	['tablet'] = {
		label = "Tablette",
		weight = 0.01,
	},
	['tabletpgp'] = {
		label = "Tablette PGP",
		weight = 0.01,
	},
	['taco'] = {
		label = "Taco",
		weight = 0.01,
	},
	['tacos'] = {
		label = "Tacos",
		weight = 0.01,
	},
	['tacoshell'] = {
		label = "Coque de Taco",
		weight = 0.01,
	},
	['tacos_de_asada'] = {
		label = "Tacos de Asada",
		weight = 0.01,
	},
	['tacos_piment'] = {
		label = "Tacos au Piment",
		weight = 0.01,
	},
	['tag_team_belt'] = {
		label = "Ceinture de Tag Team",
		weight = 0.01,
	},
	['tanghook'] = {
		label = "Tanghook",
		weight = 0.01,
	},
	['taserbatterypack'] = {
		label = "Pack de Batterie Taser",
		weight = 0.01,
	},
	['tassametro'] = {
		label = "Tassametro",
		weight = 0.01,
	},
	['tattoo_machine'] = {
		label = "Machine à Tatouer",
		weight = 0.01,
	},
	['teal_bandana'] = {
		label = "Bandana Turquoise",
		weight = 0.01,
	},
	['teddy_bear'] = {
		label = "Ours en Peluche",
		weight = 0.01,
	},
	['tequila'] = {
		label = "Tequila",
		weight = 0.01,
	},
	['tequila2'] = {
		label = "Tequila 2",
		weight = 0.01,
	},
	['tequila3'] = {
		label = "Tequila 3",
		weight = 0.01,
	},
	['tequilabottle'] = {
		label = "Bouteille de Tequila",
		weight = 0.01,
	},
	['tequilashot'] = {
		label = "Shot de Tequila",
		weight = 0.01,
	},
	['tequila_shot'] = {
		label = "Shot de Tequila",
		weight = 0.01,
	},
	['terre'] = {
		label = "Terre",
		weight = 0.01,
	},
	['testo'] = {
		label = "Testo",
		weight = 0.01,
	},
	['tete_plate'] = {
		label = "Tête Plate",
		weight = 0.01,
	},
	['textbook_a'] = {
		label = "Manuel A",
		weight = 0.01,
	},
	['thebleederburger'] = {
		label = "Burger The Bleeder",
		weight = 0.01,
	},
	['thermite_powder'] = {
		label = "Poudre de Thermite",
		weight = 0.01,
	},
	['the_bleeder'] = {
		label = "The Bleeder",
		weight = 0.01,
	},
	['the_heart_stopper'] = {
		label = "Le Stoppeur de Cœur",
		weight = 0.01,
	},
	['the_scream'] = {
		label = "Le Cri",
		weight = 0.01,
	},
	['three_kings'] = {
		label = "Trois Rois",
		weight = 0.01,
	},
	['ticket'] = {
		label = "Billet",
		weight = 0.01,
	},
	['tiramisu'] = {
		label = "Tiramisu",
		weight = 0.01,
	},
	['tire'] = {
		label = "Pneu",
		weight = 0.01,
	},
	['tissue_box'] = {
		label = "Boîte de Mouchoirs",
		weight = 0.01,
	},
	['titanio'] = {
		label = "Titane",
		weight = 0.01,
	},
	['toluene'] = {
		label = "Toluène",
		weight = 0.01,
	},
	['tomate_farcie_crabe'] = {
		label = "Tomate Farcie au Crabe",
		weight = 0.01,
	},
	['tomato'] = {
		label = "Tomate",
		weight = 0.01,
	},
	['tomato_seed'] = {
		label = "Graine de Tomate",
		weight = 0.01,
	},
	['tomy_bag'] = {
		label = "Sac Tomy",
		weight = 0.01,
	},
	['toolbox'] = {
		label = "Boîte à Outils",
		weight = 0.01,
	},
	['tooth_necklace'] = {
		label = "Collier de Dent",
		weight = 0.01,
	},
	['torpedo'] = {
		label = "Torpille",
		weight = 0.01,
	},
	['torsos'] = {
		label = "Torso",
		weight = 0.01,
	},
	['torta'] = {
		label = "Tarte",
		weight = 0.01,
	},
	['tortas'] = {
		label = "Tartes",
		weight = 0.01,
	},
	['tortilla'] = {
		label = "Tortilla",
		weight = 0.01,
	},
	['tostada'] = {
		label = "Tostada",
		weight = 0.01,
	},
	['totem_paintball'] = {
		label = "Totem de Paintball",
		weight = 0.01,
	},
	['tracker'] = {
		label = "Traceur",
		weight = 0.01,
	},
	['tracker_see'] = {
		label = "Traceur Voir",
		weight = 0.01,
	},
	['tramezzino'] = {
		label = "Tramezzino",
		weight = 0.01,
	},
	['tranche_jambon'] = {
		label = "Tranche de Jambon",
		weight = 0.01,
	},
	['transport_bag'] = {
		label = "Sac de Transport",
		weight = 0.01,
	},
	['trash_bread'] = {
		label = "Pain à la Décharge",
		weight = 0.01,
	},
	['trash_burgershot'] = {
		label = "Burger à la Décharge",
		weight = 0.01,
	},
	['trash_can'] = {
		label = "Poubelle",
		weight = 0.01,
	},
	['trash_chips'] = {
		label = "Chips à la Décharge",
		weight = 0.01,
	},
	['trash_coffee'] = {
		label = "Café à la Décharge",
		weight = 0.01,
	},
	['trash_fags'] = {
		label = "Fags à la Décharge",
		weight = 0.01,
	},
	['trash_paper'] = {
		label = "Papier à la Décharge",
		weight = 0.01,
	},
	['treat'] = {
		label = "Friandise",
		weight = 0.01,
	},
	['trimmedweed'] = {
		label = "Weed découpée",
		weight = 0.01,
	},
	['triple_elvis'] = {
		label = "Triple Elvis",
		weight = 0.01,
	},
	['trompette'] = {
		label = "Trompette",
		weight = 0.01,
	},
	['tronchese'] = {
		label = "Outil",
		weight = 0.01,
	},
	['trophy'] = {
		label = "Trophée",
		weight = 0.01,
	},
	['trophy_topchef'] = {
		label = "Trophée Top Chef",
		weight = 0.01,
	},
	['truite_plancha'] = {
		label = "Truite à la Plancha",
		weight = 0.01,
	},
	['tshirt'] = {
		label = "T-shirt",
		weight = 0.01,
	},
	['tteokbokki'] = {
		label = "Tteokbokki",
		weight = 0.01,
	},
	['tubeaspiration'] = {
		label = "Tube d'Aspiration",
		weight = 0.01,
	},
	['tunamayopasta'] = {
		label = "Pâtes au Thon et Mayonnaise",
		weight = 0.01,
	},
	['tuner'] = {
		label = "Tuner",
		weight = 0.01,
	},
	['tunerlaptop'] = {
		label = "Ordinateur Portable Tuner",
		weight = 0.01,
	},
	['tungsteno'] = {
		label = "Tungstène",
		weight = 0.01,
	},
	['tuning_laptop'] = {
		label = "Ordinateur Portable de Tuning",
		weight = 0.01,
	},
	['turboandremap'] = {
		label = "Turbo et Remap",
		weight = 0.01,
	},
	['turbo_lvl_1'] = {
		label = "Turbo Niveau 1",
		weight = 0.01,
	},
	['turkey'] = {
		label = "Dinde",
		weight = 0.01,
	},
	['turtle'] = {
		label = "Tortue",
		weight = 0.01,
	},
	['turtlebait'] = {
		label = "Appât de Tortue",
		weight = 0.01,
	},
	['twerks_candy'] = {
		label = "Bonbons Twerk",
		weight = 0.01,
	},
	['umbrella'] = {
		label = "Parapluie",
		weight = 0.01,
	},
	['uncut_diamond'] = {
		label = "Diamant Non Taillé",
		weight = 0.01,
	},
	['uncut_emerald'] = {
		label = "Émeraude Non Taillée",
		weight = 0.01,
	},
	['uncut_ruby'] = {
		label = "Rubis Non Taillé",
		weight = 0.01,
	},
	['uncut_sapphire'] = {
		label = "Saphir Non Taillé",
		weight = 0.01,
	},
	['unicorncocktail'] = {
		label = "Cocktail Licorne",
		weight = 0.01,
	},
	['unknown'] = {
		label = "Inconnu",
		weight = 0.01,
	},
	['unknown_metal'] = {
		label = "Métal Inconnu",
		weight = 0.01,
	},
	['unknown_usb_device'] = {
		label = "Dispositif USB Inconnu",
		weight = 0.01,
	},
	['uova'] = {
		label = "Œufs",
		weight = 0.01,
	},
	['usb_device'] = {
		label = "Dispositif USB",
		weight = 0.01,
	},
	['uva'] = {
		label = "Raisin",
		weight = 0.01,
	},
	['uzum'] = {
		label = "Uzum",
		weight = 0.01,
	},
	['v8engine'] = {
		label = "Moteur V8",
		weight = 0.01,
	},
	['valuable_goods'] = {
		label = "Biens Précieux",
		weight = 0.01,
	},
	['valuable_watch'] = {
		label = "Montre Précieuse",
		weight = 0.01,
	},
	['van_bottle'] = {
		label = "Bouteille de Van",
		weight = 0.01,
	},
	['van_diamond'] = {
		label = "Van avec Diamant",
		weight = 0.01,
	},
	['van_necklace'] = {
		label = "Collier de Van",
		weight = 0.01,
	},
	['van_panther'] = {
		label = "Van Panther",
		weight = 0.01,
	},
	['vegetarianburrito'] = {
		label = "Burrito Végétarien",
		weight = 0.01,
	},
	['veggy_salad'] = {
		label = "Salade Végétale",
		weight = 0.01,
	},
	['veharmor_-1'] = {
		label = "Armure de Véhicule -1",
		weight = 0.01,
	},
	['veharmor_0'] = {
		label = "Armure de Véhicule 0",
		weight = 0.01,
	},
	['veharmor_1'] = {
		label = "Armure de Véhicule 1",
		weight = 0.01,
	},
	['veharmor_2'] = {
		label = "Armure de Véhicule 2",
		weight = 0.01,
	},
	['veharmor_3'] = {
		label = "Armure de Véhicule 3",
		weight = 0.01,
	},
	['veharmor_4'] = {
		label = "Armure de Véhicule 4",
		weight = 0.01,
	},
	['vehicle_metal'] = {
		label = "Métal de Véhicule",
		weight = 0.01,
	},
	['vehicle_sponge'] = {
		label = "Éponge de Véhicule",
		weight = 0.01,
	},
	['vehupgrade_driftchip'] = {
		label = "Puces de Drift de Véhicule",
		weight = 0.01,
	},
	['vehupgrade_racechip'] = {
		label = "Puces de Course de Véhicule",
		weight = 0.01,
	},
	['veh_piece'] = {
		label = "Pièce de Véhicule",
		weight = 0.01,
	},
	['ventilateur'] = {
		label = "Ventilateur",
		weight = 0.01,
	},
	['ventoline'] = {
		label = "Ventoline",
		weight = 0.01,
	},
	['vernice'] = {
		label = "Peinture",
		weight = 0.01,
	},
	['vetement_propre'] = {
		label = "Vêtement Propre",
		weight = 0.01,
	},
	['vetement_sale'] = {
		label = "Vêtement Sale",
		weight = 0.01,
	},
	['viagra'] = {
		label = "Viagra",
		weight = 0.01,
	},
	['viande_1'] = {
		label = "Viande 1",
		weight = 0.01,
	},
	['viande_2'] = {
		label = "Viande 2",
		weight = 0.01,
	},
	['viande_3'] = {
		label = "Viande 3",
		weight = 0.01,
	},
	['viande_4'] = {
		label = "Viande 4",
		weight = 0.01,
	},
	['viande_boeuf_cru'] = {
		label = "Boeuf Cru",
		weight = 0.01,
	},
	['viande_porc_cru'] = {
		label = "Porc Cru",
		weight = 0.01,
	},
	['viande_poulet_cru'] = {
		label = "Poulet Cru",
		weight = 0.01,
	},
	['vicodin'] = {
		label = "Vicodin",
		weight = 0.01,
	},
	['vinaigre'] = {
		label = "Vinaigre",
		weight = 0.01,
	},
	['vine'] = {
		label = "Vigne",
		weight = 0.01,
	},
	['vinoa'] = {
		label = "Vinoa",
		weight = 0.01,
	},
	['vinorosso'] = {
		label = "Vin Rouge",
		weight = 0.01,
	},
	['virginpinacolada'] = {
		label = "Piña Colada Vierge",
		weight = 0.01,
	},
	['virgin_mojito'] = {
		label = "Mojito Vierge",
		weight = 0.01,
	},
	['visitcard'] = {
		label = "Carte de Visite",
		weight = 0.01,
	},
	['vitaminwater'] = {
		label = "Eau Vitamine",
		weight = 0.01,
	},
	['vodka'] = {
		label = "Vodka",
		weight = 0.01,
	},
	['vodka2'] = {
		label = "Vodka 2",
		weight = 0.01,
	},
	['vodkabottle'] = {
		label = "Bouteille de Vodka",
		weight = 0.01,
	},
	['vodkashot'] = {
		label = "Shot de Vodka",
		weight = 0.01,
	},
	['volatile_plate'] = {
		label = "Plaque Volatile",
		weight = 0.01,
	},
	['voltlab_try'] = {
		label = "Essai Volt Lab",
		weight = 0.01,
	},
	['voodoo_doll'] = {
		label = "Poupée Vaudou",
		weight = 0.01,
	},
	['vpn_xj'] = {
		label = "VPN XJ",
		weight = 0.01,
	},
	['vulture_statue'] = {
		label = "Statue de Vautour",
		weight = 0.01,
	},
	['walkstick'] = {
		label = "Canne",
		weight = 0.01,
	},
	['wallet'] = {
		label = 'Portefeuille',
		weight = 0.5,
		stack = false,
		consume = 0,
		client = {
			export = 'fb_wallet.openWallet'
		}
	},	
	['washed_stone'] = {
		label = "Pierre Laver",
		weight = 0.01,
	},
	['watch'] = {
		label = "Montre",
		weight = 0.01,
	},
	['water'] = { -- Carbonized syrup is good for the soul
	label = "Bouteille d'Eau",
	weight = 1.00,
	stack = true,
	close = false,
	client = {
		status = { thirst = 300000 },
		anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
		prop = { model = 'prop_ld_flow_bottle', 
		pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
		usetime = 2000,
	},
},
	['wateringcan'] = {
		label = "Arrosoir",
		weight = 0.01,
	},
	['water_lilies'] = {
		label = "Nénuphars",
		weight = 0.01,
	},
	['wct_barr2'] = {
		label = "WCT Barr 2",
		weight = 0.01,
	},
	['wct_camo_1'] = {
		label = "WCT Camouflage 1",
		weight = 0.01,
	},
	['wct_camo_10'] = {
		label = "WCT Camouflage 10",
		weight = 0.01,
	},
	['wct_camo_2'] = {
		label = "WCT Camouflage 2",
		weight = 0.01,
	},
	['wct_camo_3'] = {
		label = "WCT Camouflage 3",
		weight = 0.01,
	},
	['wct_camo_4'] = {
		label = "WCT Camouflage 4",
		weight = 0.01,
	},
	['wct_camo_5'] = {
		label = "WCT Camouflage 5",
		weight = 0.01,
	},
	['wct_camo_6'] = {
		label = "WCT Camouflage 6",
		weight = 0.01,
	},
	['wct_camo_7'] = {
		label = "WCT Camouflage 7",
		weight = 0.01,
	},
	['wct_camo_8'] = {
		label = "WCT Camouflage 8",
		weight = 0.01,
	},
	['wct_camo_9'] = {
		label = "WCT Camouflage 9",
		weight = 0.01,
	},
	['wct_camo_ind'] = {
		label = "WCT Camouflage Ind",
		weight = 0.01,
	},
	['wct_clip2'] = {
		label = "Clip WCT 2",
		weight = 0.01,
	},
	['wct_clip_ap'] = {
		label = "Clip WCT AP",
		weight = 0.01,
	},
	['wct_clip_box'] = {
		label = "Boîte de Clip WCT",
		weight = 0.01,
	},
	['wct_clip_drm'] = {
		label = "Clip WCT DRM",
		weight = 0.01,
	},
	['wct_clip_ex'] = {
		label = "Clip WCT EX",
		weight = 0.01,
	},
	['wct_clip_fmj'] = {
		label = "Clip WCT FMJ",
		weight = 0.01,
	},
	['wct_clip_hp'] = {
		label = "Clip WCT HP",
		weight = 0.01,
	},
	['wct_clip_inc'] = {
		label = "Clip WCT INC",
		weight = 0.01,
	},
	['wct_clip_tr'] = {
		label = "Clip WCT TR",
		weight = 0.01,
	},
	['wct_comp'] = {
		label = "WCT Comp",
		weight = 0.01,
	},
	['wct_c_tint_0'] = {
		label = "Teinte WCT 0",
		weight = 0.01,
	},
	['wct_c_tint_1'] = {
		label = "Teinte WCT 1",
		weight = 0.01,
	},
	['wct_c_tint_10'] = {
		label = "Teinte WCT 10",
		weight = 0.01,
	},
	['wct_c_tint_11'] = {
		label = "Teinte WCT 11",
		weight = 0.01,
	},
	['wct_c_tint_12'] = {
		label = "Teinte WCT 12",
		weight = 0.01,
	},
	['wct_c_tint_13'] = {
		label = "Teinte WCT 13",
		weight = 0.01,
	},
	['wct_c_tint_14'] = {
		label = "Teinte WCT 14",
		weight = 0.01,
	},
	['wct_c_tint_15'] = {
		label = "Teinte WCT 15",
		weight = 0.01,
	},
	['wct_c_tint_16'] = {
		label = "Teinte WCT 16",
		weight = 0.01,
	},
	['wct_c_tint_17'] = {
		label = "Teinte WCT 17",
		weight = 0.01,
	},
	['wct_c_tint_18'] = {
		label = "Teinte WCT 18",
		weight = 0.01,
	},
	['wct_c_tint_19'] = {
		label = "Teinte WCT 19",
		weight = 0.01,
	},
	['wct_c_tint_2'] = {
		label = "Teinte WCT 2",
		weight = 0.01,
	},
	['wct_c_tint_20'] = {
		label = "Teinte WCT 20",
		weight = 0.01,
	},
	['wct_c_tint_21'] = {
		label = "Teinte WCT 21",
		weight = 0.01,
	},
	['wct_c_tint_22'] = {
		label = "Teinte WCT 22",
		weight = 0.01,
	},
	['wct_c_tint_23'] = {
		label = "Teinte WCT 23",
		weight = 0.01,
	},
	['wct_c_tint_24'] = {
		label = "Teinte WCT 24",
		weight = 0.01,
	},
	['wct_c_tint_25'] = {
		label = "Teinte WCT 25",
		weight = 0.01,
	},
	['wct_c_tint_26'] = {
		label = "Teinte WCT 26",
		weight = 0.01,
	},
	['wct_c_tint_27'] = {
		label = "Teinte WCT 27",
		weight = 0.01,
	},
	['wct_c_tint_28'] = {
		label = "Teinte WCT 28",
		weight = 0.01,
	},
	['wct_c_tint_29'] = {
		label = "Teinte WCT 29",
		weight = 0.01,
	},
	['wct_c_tint_3'] = {
		label = "Teinte WCT 3",
		weight = 0.01,
	},
	['wct_c_tint_30'] = {
		label = "Teinte WCT 30",
		weight = 0.01,
	},
	['wct_c_tint_31'] = {
		label = "Teinte WCT 31",
		weight = 0.01,
	},
	['wct_c_tint_4'] = {
		label = "Teinte WCT 4",
		weight = 0.01,
	},
	['wct_c_tint_5'] = {
		label = "Teinte WCT 5",
		weight = 0.01,
	},
	['wct_c_tint_6'] = {
		label = "Teinte WCT 6",
		weight = 0.01,
	},
	['wct_c_tint_7'] = {
		label = "Teinte WCT 7",
		weight = 0.01,
	},
	['wct_c_tint_8'] = {
		label = "Teinte WCT 8",
		weight = 0.01,
	},
	['wct_c_tint_9'] = {
		label = "Teinte WCT 9",
		weight = 0.01,
	},
	['wct_flash'] = {
		label = "Flash WCT",
		weight = 0.01,
	},
	['wct_grip'] = {
		label = "Grip WCT",
		weight = 0.01,
	},
	['wct_holo'] = {
		label = "Holo WCT",
		weight = 0.01,
	},
	['wct_knuck_01'] = {
		label = "Knuck WCT 01",
		weight = 0.01,
	},
	['wct_knuck_02'] = {
		label = "Knuck WCT 02",
		weight = 0.01,
	},
	['wct_knuck_bg'] = {
		label = "Knuck WCT BG",
		weight = 0.01,
	},
	['wct_knuck_dlr'] = {
		label = "Knuck WCT DLR",
		weight = 0.01,
	},
	['wct_knuck_dmd'] = {
		label = "Knuck WCT DMD",
		weight = 0.01,
	},
	['wct_knuck_ht'] = {
		label = "Knuck WCT HT",
		weight = 0.01,
	},
	['wct_knuck_lv'] = {
		label = "Knuck WCT LV",
		weight = 0.01,
	},
	['wct_knuck_pc'] = {
		label = "Knuck WCT PC",
		weight = 0.01,
	},
	['wct_knuck_slg'] = {
		label = "Knuck WCT SLG",
		weight = 0.01,
	},
	['wct_knuck_vg'] = {
		label = "Knuck WCT VG",
		weight = 0.01,
	},
	['wct_muzz'] = {
		label = "Muzz WCT",
		weight = 0.01,
	},
	['wct_muzz1'] = {
		label = "Muzz WCT 1",
		weight = 0.01,
	},
	['wct_muzz10'] = {
		label = "Muzz WCT 10",
		weight = 0.01,
	},
	['wct_muzz2'] = {
		label = "Muzz WCT 2",
		weight = 0.01,
	},
	['wct_muzz3'] = {
		label = "Muzz WCT 3",
		weight = 0.01,
	},
	['wct_muzz4'] = {
		label = "Muzz WCT 4",
		weight = 0.01,
	},
	['wct_muzz5'] = {
		label = "Muzz WCT 5",
		weight = 0.01,
	},
	['wct_muzz6'] = {
		label = "Muzz WCT 6",
		weight = 0.01,
	},
	['wct_muzz7'] = {
		label = "Muzz WCT 7",
		weight = 0.01,
	},
	['wct_muzz8'] = {
		label = "Muzz WCT 8",
		weight = 0.01,
	},
	['wct_muzz9'] = {
		label = "Muzz WCT 9",
		weight = 0.01,
	},
	['wct_rail'] = {
		label = "Rail WCT",
		weight = 0.01,
	},
	['wct_rev_varb'] = {
		label = "WCT Rev Varb",
		weight = 0.01,
	},
	['wct_rev_varg'] = {
		label = "WCT Rev Varg",
		weight = 0.01,
	},
	['wct_sb_base'] = {
		label = "WCT SB Base",
		weight = 0.01,
	},
	['wct_sb_var1'] = {
		label = "WCT SB Var 1",
		weight = 0.01,
	},
	['wct_sb_var2'] = {
		label = "WCT SB Var 2",
		weight = 0.01,
	},
	['wct_scope_lrg'] = {
		label = "Lunette WCT LRG",
		weight = 0.01,
	},
	['wct_scope_lrg2'] = {
		label = "Lunette WCT LRG 2",
		weight = 0.01,
	},
	['wct_scope_mac'] = {
		label = "Lunette WCT MAC",
		weight = 0.01,
	},
	['wct_scope_mac2'] = {
		label = "Lunette WCT MAC 2",
		weight = 0.01,
	},
	['wct_scope_max'] = {
		label = "Lunette WCT MAX",
		weight = 0.01,
	},
	['wct_scope_med'] = {
		label = "Lunette WCT MED",
		weight = 0.01,
	},
	['wct_scope_med2'] = {
		label = "Lunette WCT MED 2",
		weight = 0.01,
	},
	['wct_scope_nv'] = {
		label = "Lunette WCT NV",
		weight = 0.01,
	},
	['wct_scope_pi'] = {
		label = "Lunette WCT PI",
		weight = 0.01,
	},
	['wct_scope_sml'] = {
		label = "Lunette WCT SML",
		weight = 0.01,
	},
	['wct_scope_sml2'] = {
		label = "Lunette WCT SML 2",
		weight = 0.01,
	},
	['wct_scope_th'] = {
		label = "Lunette WCT TH",
		weight = 0.01,
	},
	['wct_shell_ap'] = {
		label = "Coquille WCT AP",
		weight = 0.01,
	},
	['wct_shell_ex'] = {
		label = "Coquille WCT EX",
		weight = 0.01,
	},
	['wct_shell_hp'] = {
		label = "Coquille WCT HP",
		weight = 0.01,
	},
	['wct_shell_inc'] = {
		label = "Coquille WCT INC",
		weight = 0.01,
	},
	['wct_supp'] = {
		label = "Supp WCT",
		weight = 0.01,
	},
	['wct_var_etchm'] = {
		label = "WCT Var Etchm",
		weight = 0.01,
	},
	['wct_var_gold'] = {
		label = "WCT Var Or",
		weight = 0.01,
	},
	['wct_var_metal'] = {
		label = "WCT Var Métal",
		weight = 0.01,
	},
	['wct_var_ray18'] = {
		label = "WCT Var Ray 18",
		weight = 0.01,
	},
	['wct_var_sil'] = {
		label = "WCT Var Sil",
		weight = 0.01,
	},
	['wct_var_wood'] = {
		label = "WCT Var Bois",
		weight = 0.01,
	},
	['weapon_3j7kq84d'] = {
		label = "Arme 3J7KQ84D",
		weight = 0.01,
	},
	['weapon_advancedrifle'] = {
		label = "Fusil modulesncé",
		weight = 0.01,
	},
	['weapon_ak'] = {
		label = "AK",
		weight = 0.01,
	},
	['weapon_antidote'] = {
		label = "Antidote",
		weight = 0.01,
	},
	['weapon_appistol'] = {
		label = "Pistolet Automatique",
		weight = 0.01,
	},
	['weapon_armagodsword'] = {
		label = "Épée Armageddon",
		weight = 0.01,
	},
	['weapon_assaultrifle'] = {
		label = "Fusil d'Assaut",
		weight = 0.01,
	},
	['weapon_assaultrifle_mk2'] = {
		label = "Fusil d'Assaut Mk2",
		weight = 0.01,
	},
	['weapon_assaultshotgun'] = {
		label = "Fusil à Pompe d'Assaut",
		weight = 0.01,
	},
	['weapon_assaultsmg'] = {
		label = "Pistolet Mitrailleur d'Assaut",
		weight = 0.01,
	},
	['weapon_autoshotgun'] = {
		label = "Fusil à Pompe Automatique",
		weight = 0.01,
	},
	['weapon_ball'] = {
		label = "Balle",
		weight = 0.01,
	},
	['weapon_bat'] = {
		label = "Batte",
		weight = 0.01,
	},
	['weapon_battleaxe'] = {
		label = "Hache de Bataille",
		weight = 0.01,
	},
	['weapon_battlerifle'] = {
		label = "Fusil de Bataille",
		weight = 0.01,
	},
	['weapon_beanbag'] = {
		label = "Sac de Haricots",
		weight = 0.01,
	},
	['weapon_bighammer'] = {
		label = "Grosse Marteau",
		weight = 0.01,
	},
	['weapon_birdbomb'] = {
		label = "Bombe Oiseau",
		weight = 0.01,
	},
	['weapon_bird_crap'] = {
		label = "Crap d'Oiseau",
		weight = 0.01,
	},
	['weapon_book'] = {
		label = "Livre",
		weight = 0.01,
	},
	['weapon_bottle'] = {
		label = "Bouteille",
		weight = 0.01,
	},
	['weapon_bouteille'] = {
		label = "Bouteille",
		weight = 0.01,
	},
	['weapon_brick'] = {
		label = "Brique",
		weight = 0.01,
	},
	['weapon_bullpuprifle'] = {
		label = "Fusil Bullpup",
		weight = 0.01,
	},
	['weapon_bullpuprifle_mk2'] = {
		label = "Fusil Bullpup Mk2",
		weight = 0.01,
	},
	['weapon_bullpupshotgun'] = {
		label = "Fusil à Pompe Bullpup",
		weight = 0.01,
	},
	['weapon_bzgas'] = {
		label = "Gaz BZ",
		weight = 0.01,
	},
	['weapon_canette'] = {
		label = "Canette",
		weight = 0.01,
	},
	['weapon_carbinerifle'] = {
		label = "Carabine",
		weight = 0.01,
	},
	['weapon_carbinerifle_mk2'] = {
		label = "Carabine Mk2",
		weight = 0.01,
	},
	['weapon_cash'] = {
		label = "Argent",
		weight = 0.01,
	},
	['weapon_ceramicpistol'] = {
		label = "Pistolet en Céramique",
		weight = 0.01,
	},
	['weapon_chainsaw'] = {
		label = "Scie Électrique",
		weight = 0.01,
	},
	['weapon_combatmg'] = {
		label = "Mitrailleuse de Combat",
		weight = 0.01,
	},
	['weapon_combatmg_mk2'] = {
		label = "Mitrailleuse de Combat Mk2",
		weight = 0.01,
	},
	['weapon_combatpdw'] = {
		label = "Pistolet Mitrailleur de Combat",
		weight = 0.01,
	},
	['weapon_combatpistol'] = {
		label = "Pistolet de Combat",
		weight = 0.01,
	},
	['weapon_combatshotgun'] = {
		label = "Fusil à Pompe de Combat",
		weight = 0.01,
	},
	['weapon_compactlauncher'] = {
		label = "Lanceur Compact",
		weight = 0.01,
	},
	['weapon_compactrifle'] = {
		label = "Fusil Compact",
		weight = 0.01,
	},
	['weapon_crowbar'] = {
		label = "Barre à Mine",
		weight = 0.01,
	},
	['weapon_dagger'] = {
		label = "Dague",
		weight = 0.01,
	},
	['weapon_dbshotgun'] = {
		label = "Fusil à Pompe Double",
		weight = 0.01,
	},
	['weapon_digiscanner'] = {
		label = "Numériseur",
		weight = 0.01,
	},
	['weapon_doubleaction'] = {
		label = "Pistolet Double Action",
		weight = 0.01,
	},
	['weapon_electric_fence'] = {
		label = "Clôture Électrique",
		weight = 0.01,
	},
	['weapon_emplauncher'] = {
		label = "Lanceur EMP",
		weight = 0.01,
	},
	['weapon_fakeak'] = {
		label = "AK Factice",
		weight = 0.01,
	},
	['weapon_fakeaku'] = {
		label = "AKU Factice",
		weight = 0.01,
	},
	['weapon_fakecombatpistol'] = {
		label = "Pistolet de Combat Factice",
		weight = 0.01,
	},
	['weapon_fakem4'] = {
		label = "M4 Factice",
		weight = 0.01,
	},
	['weapon_fakemicrosmg'] = {
		label = "Micro SMG Factice",
		weight = 0.01,
	},
	['weapon_fakeshotgun'] = {
		label = "Fusil à Pompe Factice",
		weight = 0.01,
	},
	['weapon_fakesmg'] = {
		label = "SMG Factice",
		weight = 0.01,
	},
	['weapon_fertilizercan'] = {
		label = "Canette de Fertilisant",
		weight = 0.01,
	},
	['weapon_fireextinguisher'] = {
		label = "Extincteur",
		weight = 0.01,
	},
	['weapon_firework'] = {
		label = "Feu d'Artifice",
		weight = 0.01,
	},
	['weapon_flamethrower'] = {
		label = "Lance-Flammes",
		weight = 0.01,
	},
	['weapon_flamethrower2'] = {
		label = "Lance-Flammes 2",
		weight = 0.01,
	},
	['weapon_flare'] = {
		label = "Fusée de Signalisation",
		weight = 0.01,
	},
	['weapon_flaregun'] = {
		label = "Pistolet Flare",
		weight = 0.01,
	},
	['weapon_flashlight'] = {
		label = "Lampe Torche",
		weight = 0.01,
	},
	['weapon_gadgetpistol'] = {
		label = "Pistolet Gadget",
		weight = 0.01,
	},
	['weapon_garbagebag'] = {
		label = "Sac à Ordure",
		weight = 0.01,
	},
	['glock20'] = {
		label = "Glock",
		weight = 0.01,
		ammoname = 'ammo-9',
	},
	['w_pi_glock'] = {
		label = 'Glock',
		weight = 1500,
		durability = 0.075,
		ammoname = 'ammo-9',
	},
	['w_pi_combatpistol'] = {
		label = 'Glock',
		weight = 1500,
		durability = 0.075,
		ammoname = 'ammo-9',
	},
	['weapon_glock20'] = {
		label = "Glock 20",
		weight = 0.01,
	},
	['weapon_golfclub'] = {
		label = "Club de Golf",
		weight = 0.01,
	},
	['weapon_gravhammer'] = {
		label = "Marteau Gravitationnel",
		weight = 0.01,
	},
	['weapon_grenade'] = {
		label = "Grenade",
		weight = 0.01,
	},
	['weapon_grenadelauncher'] = {
		label = "Lance-Grenades",
		weight = 0.01,
	},
	['weapon_grenadelauncher_smoke'] = {
		label = "Lance-Grenades Fumigènes",
		weight = 0.01,
	},
	['weapon_gtx1080'] = {
		label = "GTX 1080",
		weight = 0.01,
	},
	['weapon_guitar'] = {
		label = "Guitare",
		weight = 0.01,
	},
	['weapon_gusenberg'] = {
		label = "Gusenberg",
		weight = 0.01,
	},
	['weapon_hackingdevice'] = {
		label = "Dispositif de Piratage",
		weight = 0.01,
	},
	['weapon_hammer'] = {
		label = "Marteau",
		weight = 0.01,
	},
	['weapon_handcuffs'] = {
		label = "Menottes",
		weight = 0.01,
	},
	['weapon_hatchet'] = {
		label = "Hachette",
		weight = 0.01,
	},
	['weapon_hazardcan'] = {
		label = "Bidon de Déchets",
		weight = 0.01,
	},
	['weapon_heavypistol'] = {
		label = "Pistolet Lourd",
		weight = 0.01,
	},
	['weapon_heavyrifle'] = {
		label = "Fusil Lourd",
		weight = 0.01,
	},
	['weapon_heavyshotgun'] = {
		label = "Fusil à Pompe Lourd",
		weight = 0.01,
	},
	['weapon_heavysniper'] = {
		label = "Fusil de Sniper Lourd",
		weight = 0.01,
	},
	['weapon_heavysniper_mk2'] = {
		label = "Fusil de Sniper Lourd Mk2",
		weight = 0.01,
	},
	['weapon_hk417'] = {
		label = "HK417",
		weight = 0.01,
	},
	['weapon_hominglauncher'] = {
		label = "Lanceur Autoguidé",
		weight = 0.01,
	},
	['weapon_hunt'] = {
		label = "Fusil de Chasse",
		weight = 0.01,
	},
	['weapon_infinitygauntlet'] = {
		label = "Gant de l'Infini",
		weight = 0.01,
	},
	['weapon_jrevolver'] = {
		label = "Revolver J",
		weight = 0.01,
	},
	['weapon_katana'] = {
		label = "Katana",
		weight = 0.01,
	},
	['weapon_katana2'] = {
		label = "Katana 2",
		weight = 0.01,
	},
	['weapon_katana3'] = {
		label = "Katana 3",
		weight = 0.01,
	},
	['weapon_katana4'] = {
		label = "Katana 4",
		weight = 0.01,
	},
	['weapon_katana5'] = {
		label = "Katana 5",
		weight = 0.01,
	},
	['weapon_katana6'] = {
		label = "Katana 6",
		weight = 0.01,
	},
	['weapon_knife'] = {
		label = "Couteau",
		weight = 0.01,
	},
	['weapon_knuckle'] = {
		label = "Coup-de-Poing Américain",
		weight = 0.01,
	},
	['weapon_liberty_statue'] = {
		label = "Statue de la Liberté",
		weight = 0.01,
	},
	['weapon_m9'] = {
		label = "M9",
		weight = 0.01,
	},
	['weapon_machete'] = {
		label = "Machette",
		weight = 0.01,
	},
	['weapon_machinepistol'] = {
		label = "Pistolet-Mitrailleur",
		weight = 0.01,
	},
	['weapon_marksmanpistol'] = {
		label = "Pistolet Marksman",
		weight = 0.01,
	},
	['weapon_marksmanrifle'] = {
		label = "Fusil Marksman",
		weight = 0.01,
	},
	['weapon_marksmanrifle_mk2'] = {
		label = "Fusil Marksman Mk2",
		weight = 0.01,
	},
	['weapon_medbag'] = {
		label = "Sac Médical",
		weight = 0.01,
	},
	['weapon_metaldetector'] = {
		label = "Détecteur de Métaux",
		weight = 0.01,
	},
	['weapon_mg'] = {
		label = "Mitrailleuse",
		weight = 0.01,
	},
	['weapon_mga7000'] = {
		label = "MGA7000",
		weight = 0.01,
	},
	['weapon_microsmg'] = {
		label = "Micro SMG",
		weight = 0.01,
	},
	['weapon_militaryrifle'] = {
		label = "Fusil Militaire",
		weight = 0.01,
	},
	['weapon_minigun'] = {
		label = "Minigun",
		weight = 0.01,
	},
	['weapon_minismg'] = {
		label = "Mini SMG",
		weight = 0.01,
	},
	['weapon_molette'] = {
		label = "Molette",
		weight = 0.01,
	},
	['weapon_molotov'] = {
		label = "Molotov",
		weight = 0.01,
	},
	['weapon_musket'] = {
		label = "Mousquet",
		weight = 0.01,
	},
	['weapon_nailgun'] = {
		label = "Cloueuse",
		weight = 0.01,
	},
	['weapon_navyrevolver'] = {
		label = "Revolver de Marine",
		weight = 0.01,
	},
	['weapon_needlerrifle'] = {
		label = "Fusil à Aiguilles",
		weight = 0.01,
	},
	['weapon_nightstick'] = {
		label = "Matraque",
		weight = 0.01,
	},
	['weapon_notes7'] = {
		label = "Notes 7",
		weight = 0.01,
	},
	['weapon_old_shotgun'] = {
		label = "Vieux Fusil à Pompe",
		weight = 0.01,
	},
	['weapon_paintball'] = {
		label = "Lanceur de Paintball",
		weight = 0.01,
	},
	['weapon_pelle'] = {
		label = "Pelle",
		weight = 0.01,
	},
	['weapon_penetrator'] = {
		label = "Pénétrateur",
		weight = 0.01,
	},
	['weapon_pepperspray'] = {
		label = "Spray au Poivre",
		weight = 0.01,
	},
	['weapon_pericopistol'] = {
		label = "Pistolet Périscope",
		weight = 0.01,
	},
	['weapon_petrolcan'] = {
		label = "Jerrican",
		weight = 0.01,
	},
	['weapon_phone'] = {
		label = "Téléphone",
		weight = 0.01,
	},
	['weapon_pickaxe'] = {
		label = "Pioche",
		weight = 0.01,
	},
	['weapon_pipebomb'] = {
		label = "Bombe Artisanale",
		weight = 0.01,
	},
	['weapon_pistol'] = {
		label = "Pistolet",
		weight = 0.01,
	},
	['weapon_pistol50'] = {
		label = "Pistolet .50",
		weight = 0.01,
	},
	['weapon_pistol_mk2'] = {
		label = "Pistolet Mk2",
		weight = 0.01,
	},
	['weapon_plasmap'] = {
		label = "Plasmap",
		weight = 0.01,
	},
	['weapon_poolcue'] = {
		label = "Queue de Billard",
		weight = 0.01,
	},
	['weapon_precisionrifle'] = {
		label = "Fusil de Précision",
		weight = 0.01,
	},
	['weapon_proxmine'] = {
		label = "Mine de Proximité",
		weight = 0.01,
	},
	['weapon_pumpshotgun'] = {
		label = "Fusil à Pompe",
		weight = 0.01,
	},
	['weapon_pumpshotgun_mk2'] = {
		label = "Fusil à Pompe Mk2",
		weight = 0.01,
	},
	['weapon_radarpistol'] = {
		label = "Pistolet Radar",
		weight = 0.01,
	},
	['weapon_railgun'] = {
		label = "Fusil à Rail",
		weight = 0.01,
	},
	['weapon_raycarbine'] = {
		label = "Carabine à Rayons",
		weight = 0.01,
	},
	['weapon_rayminigun'] = {
		label = "Minigun à Rayons",
		weight = 0.01,
	},
	['weapon_raypistol'] = {
		label = "Pistolet à Rayons",
		weight = 0.01,
	},
	['weapon_remotesniper'] = {
		label = "Fusil de Sniper Télécommandé",
		weight = 0.01,
	},
	['weapon_revolver'] = {
		label = "Revolver",
		weight = 0.01,
	},
	['weapon_revolver_mk2'] = {
		label = "Revolver Mk2",
		weight = 0.01,
	},
	['weapon_rpg'] = {
		label = "RPG",
		weight = 0.01,
	},
	['weapon_sawnoffshotgun'] = {
		label = "Fusil à Pompe Scié",
		weight = 0.01,
	},
	['weapon_shotgun'] = {
		label = "Fusil à Pompe",
		weight = 0.01,
	},
	['weapon_sledgehammer'] = {
		label = "Masse",
		weight = 0.01,
	},
	['weapon_smg'] = {
		label = "SMG",
		weight = 0.01,
	},
	['weapon_smg_mk2'] = {
		label = "SMG Mk2",
		weight = 0.01,
	},
	['weapon_smokegrenade'] = {
		label = "Grenade Fumigène",
		weight = 0.01,
	},
	['weapon_smokelspd'] = {
		label = "Fumigène LSPD",
		weight = 0.01,
	},
	['weapon_sniperrifle'] = {
		label = "Fusil de Sniper",
		weight = 0.01,
	},
	['weapon_snowball'] = {
		label = "Boule de Neige",
		weight = 0.01,
	},
	['weapon_snowlauncher'] = {
		label = "Lance-Neige",
		weight = 0.01,
	},
	['weapon_snspistol'] = {
		label = "Pistolet SNS",
		weight = 0.01,
	},
	['weapon_snspistol_mk2'] = {
		label = "Pistolet SNS Mk2",
		weight = 0.01,
	},
	['weapon_snub'] = {
		label = "Pistolet Snub",
		weight = 0.01,
	},
	['weapon_specialcarbine'] = {
		label = "Carabine Spéciale",
		weight = 0.01,
	},
	['weapon_specialcarbine_mk2'] = {
		label = "Carabine Spéciale Mk2",
		weight = 0.01,
	},
	['weapon_spikedclub'] = {
		label = "Massue à Pointes",
		weight = 0.01,
	},
	['weapon_splaser'] = {
		label = "Pistolet Laser",
		weight = 0.01,
	},
	['weapon_stickybomb'] = {
		label = "Bombe Collante",
		weight = 0.01,
	},
	['weapon_stinger'] = {
		label = "Stinger",
		weight = 0.01,
	},
	['weapon_stone_hatchet'] = {
		label = "Hachette en Pierre",
		weight = 0.01,
	},
	['weapon_stungun'] = {
		label = "Taser",
		weight = 0.01,
	},
	['weapon_stungun_02'] = {
		label = "Taser 02",
		weight = 0.01,
	},
	['weapon_stungun_mp'] = {
		label = "Taser MP",
		weight = 0.01,
	},
	['weapon_stunrod'] = {
		label = "Matraque Électrique",
		weight = 0.01,
	},
	['weapon_sweepershotgun'] = {
		label = "Fusil à Pompe Balayeur",
		weight = 0.01,
	},
	['weapon_switchblade'] = {
		label = "Couteau à Cran d'Arrêt",
		weight = 0.01,
	},
	['weapon_tacticalrifle'] = {
		label = "Fusil Tactique",
		weight = 0.01,
	},
	['weapon_tecpistol'] = {
		label = "Pistolet TEC",
		weight = 0.01,
	},
	['weapon_throwingaxe'] = {
		label = "Hachette de Lancer",
		weight = 0.01,
	},
	['weapon_toz'] = {
		label = "Fusil TOZ",
		weight = 0.01,
	},
	['weapon_tranquilizer'] = {
		label = "Pistolet Tranquillisant",
		weight = 0.01,
	},
	['weapon_unarmed'] = {
		label = "Non Armé",
		weight = 0.01,
	},
	['weapon_uvlight'] = {
		label = "Lumière UV",
		weight = 0.01,
	},
	['weapon_uzi'] = {
		label = "Uzi",
		weight = 0.01,
	},
	['weapon_vintagepistol'] = {
		label = "Pistolet Vintage",
		weight = 0.01,
	},
	['weapon_waffe'] = {
		label = "Waffe",
		weight = 0.01,
	},
	['weapon_waterpistol'] = {
		label = "Pistolet à Eau",
		weight = 0.01,
	},
	['weapon_wrench'] = {
		label = "Clé à Molette",
		weight = 0.01,
	},
	['weddingcakeslice'] = {
		label = "Morceau de Gâteau de Mariage",
		weight = 0.01,
	},
	['wedding_ring'] = {
		label = "Alliance",
		weight = 0.01,
	},
	['weedburn'] = {
		label = "Herbe Brûlée",
		weight = 0.01,
	},
	['weedounce'] = {
		label = "Weed pure",
		weight = 0.01,
	},
	['weedqtr'] = {
		label = "Weed en sachet",
		weight = 0.01,
	},
	['weed_4_oz'] = {
		label = "Weed",
		weight = 0.01,
	},
	['weed_brick'] = {
		label = "Brique de Weed",
		weight = 0.01,
	},
	['weed_brick_40_oz'] = {
		label = "Brique de Weed 40 Oz",
		weight = 0.01,
	},
	['weed_brick_hybride1'] = {
		label = "Brique de Weed Hybride 1",
		weight = 0.01,
	},
	['weed_brick_hybride2'] = {
		label = "Brique de Weed Hybride 2",
		weight = 0.01,
	},
	['weed_brick_indica1'] = {
		label = "Brique de Weed Indica 1",
		weight = 0.01,
	},
	['weed_brick_indica2'] = {
		label = "Brique de Weed Indica 2",
		weight = 0.01,
	},
	['weed_brick_sativa1'] = {
		label = "Brique de Weed Sativa 1",
		weight = 0.01,
	},
	['weed_brick_sativa2'] = {
		label = "Brique de Weed Sativa 2",
		weight = 0.01,
	},
	['weed_brick_simple'] = {
		label = "Brique de Weed Simple",
		weight = 0.01,
	},
	['weed_empty_bag'] = {
		label = "Sac Vide de Weed",
		weight = 0.01,
	},
	['weed_hybride1'] = {
		label = "Weed Hybride 1",
		weight = 0.01,
	},
	['weed_hybride2'] = {
		label = "Weed Hybride 2",
		weight = 0.01,
	},
	['weed_indica1'] = {
		label = "Weed Indica 1",
		weight = 0.01,
	},
	['weed_indica2'] = {
		label = "Weed Indica 2",
		weight = 0.01,
	},
	['weed_nutrition'] = {
		label = "Nutrition pour Weed",
		weight = 0.01,
	},
	['weed_oz'] = {
		label = "Weed",
		weight = 0.01,
	},
	['weed_sativa1'] = {
		label = "Weed Sativa 1",
		weight = 0.01,
	},
	['weed_sativa2'] = {
		label = "Weed Sativa 2",
		weight = 0.01,
	},
	['weed_seed'] = {
		label = "Graine de Weed",
		weight = 0.01,
	},
	['weed_untrimmed'] = {
		label = "Weed",
		weight = 0.01,
	},
	['weeping_woman'] = {
		label = "La Femme qui Pleure",
		weight = 0.01,
	},
	['wheat_seed'] = {
		label = "Graine de Blé",
		weight = 0.01,
	},
	['wheelchair'] = {
		label = "Fauteuil Roulant",
		weight = 0.01,
	},
	['whey_fraise'] = {
		label = "Whey Fraise",
		weight = 0.01,
	},
	['whey_gold'] = {
		label = "Whey Or",
		weight = 0.01,
	},
	['whey_zero'] = {
		label = "Whey Zéro",
		weight = 0.01,
	},
	['whip'] = {
		label = "Fouet",
		weight = 0.01,
	},
	['whiskey'] = {
		label = "Whiskey",
		weight = 0.01,
	},
	['whiskeybottle'] = {
		label = "Bouteille de Whiskey",
		weight = 0.01,
	},
	['whiskeyglass'] = {
		label = "Verre de Whiskey",
		weight = 0.01,
	},
	['whiskycoca'] = {
		label = "Whisky Coca",
		weight = 0.01,
	},
	['whitechocolatemocha'] = {
		label = "Mocha au Chocolat Blanc",
		weight = 0.01,
	},
	['white_belt'] = {
		label = "Ceinture Blanche",
		weight = 0.01,
	},
	['white_chip'] = {
		label = "Puce Blanche",
		weight = 0.01,
	},
	['white_pearl'] = {
		label = "Perle Blanche",
		weight = 0.01,
	},
	['white_wine_bottle'] = {
		label = "Bouteille de Vin Blanc",
		weight = 0.01,
	},
	['wig_glue'] = {
		label = "Colle pour Perruque",
		weight = 0.01,
	},
	['winch'] = {
		label = "Treuil",
		weight = 0.01,
	},
	['wine'] = {
		label = "Vin",
		weight = 0.01,
	},
	['winebottle'] = {
		label = "Bouteille de Vin",
		weight = 0.01,
	},
	['wineglass'] = {
		label = "Verre de Vin",
		weight = 0.01,
	},
	['wings'] = {
		label = "Ailes",
		weight = 0.01,
	},
	['wingsepice'] = {
		label = "Ailes Épicées",
		weight = 0.01,
	},
	['womenpants'] = {
		label = "Pantalon Femme",
		weight = 0.01,
	},
	['wood'] = {
		label = "Bois",
		weight = 0.01,
	},
	['wool'] = {
		label = "Laine",
		weight = 0.01,
	},
	['wrench'] = {
		label = "Clé",
		weight = 0.01,
	},
	['wtc_clip_fmj'] = {
		label = "Clip WTC FMJ",
		weight = 0.01,
	},
	['xanax'] = {
		label = "Xanax",
		weight = 0.01,
	},
	['xs_condom'] = {
		label = "Préservatif XS",
		weight = 0.01,
	},
	['xtc_baggy'] = {
		label = "Sac de XTC",
		weight = 0.01,
	},
	['xylazine'] = {
		label = "Xylazine",
		weight = 0.01,
	},
	['yangnyeom'] = {
		label = "Yangnyeom",
		weight = 0.01,
	},
	['yellow_bandana'] = {
		label = "Bandana Jaune",
		weight = 0.01,
	},
	['yellow_diamond'] = {
		label = "Diamant Jaune",
		weight = 0.01,
	},
	['yoga_mat'] = {
		label = "Tapis de Yoga",
		weight = 0.01,
	},
	['yokohamastreet'] = {
		label = "Yokohama Street",
		weight = 0.01,
	},
	['zancudolager'] = {
		label = "Zancudo Lager",
		weight = 0.01,
	},
	['zebra'] = {
		label = "Zèbre",
		weight = 0.01,
	},
	['zipties'] = {
		label = "Serre-Câbles",
		weight = 0.01,
	},	
	['money'] = {
		label = "Argent",
		weight = 0.01,
	},
	
	["mushroom"] = {
		label = "Champignon alucinogène",
		weight = 0.05,
		consume = 0,
		stack = true,
		close = true,
	},
	["mushroom-basket"] = {
		label = "Panier de champignons alucinogène",
		weight = 0.05,
		consume = 0,
		stack = true,
		close = true,
	},
	["visite_empty_card"] = {
		label = "Carte de visite non remplie",
		weight = 0.05,
		consume = 0,
		stack = false,
		close = true,
		client = {
			event = 'gw:item:open.visite_empty_card',
		},
	},

	["visite_card"] = {
		label = "Carte de visite",
		weight = 0.0,
		consume = 0,
		stack = true,
		close = true,
		client = {
			event = 'gw:item:open.visite_car:show',
		},
		metadata = { 
			imageurl = '',
			url = '',
			uniqueId = 0,
			imageformat = 0,
            imagesize = 0
		}
	},
	["fuel"] = {
		label = "Essence",
		weight = 1000,
		stack = true,
		close = true,
		description = "Essence pour véhicule",
	},
	['keys'] = {
		label = "Clé de voiture",
		weight = 0.01,
	},
	['cb_a_w'] = {
		label = "Carte Bancaire",
		weight = 0.015,
	},
	["weap_bench"] = {
	    label = "Weapons Bench",
	    weight = 4000,
	    stack = true,
	    close = true,
	    description = "A bench to craft weapons",
	    client = {
	        image = "pure_bench.png",
	    }
	},
	["misc_bench"] = {
	    label = "Misc Bench",
	    weight = 4000,
	    stack = true,
	    close = true,
	    description = "A bench to craft miscellaneous items",
	    client = {
	        image = "pure_bench.png",
	    }
	},
	['fish_cooked'] = {
		label = 'Poisson cuit',
		description = "",
		weight = 200,
		allowArmed = false,
		close = false,
		stack = false,
		degrade = 48*60,
		client = {
			status = { hunger = 200000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = {
				model = 'prop_cs_steak',
				pos = { x = 0.02, y = 0.02, y = -0.02},
				rot = { x = 0.0, y = 0.0, y = 0.0}
			},
			usetime = 2500,
		}
	},
	['tuna'] = {
		label = 'Thon',
		description = "",
		weight = 400,
		allowArmed = false,
		close = false,
		stack = false,
		degrade = 24*60,
	},
	['salmon'] = {
		label = 'Saumon',
		description = "",
		weight = 400,
		allowArmed = false,
		close = false,
		stack = false,
		degrade = 24*60,
	},
	['trout'] = {
		label = 'Truite',
		description = "",
		weight = 400,
		allowArmed = false,
		close = false,
		stack = false,
		degrade = 24*60,
	},
	['anchovy'] = {
		label = 'Anchois',
		description = "",
		weight = 400,
		allowArmed = false,
		close = false,
		stack = false,
		degrade = 24*60,
	},
	['rock'] = {
		label = 'Pierre',
		description = "",
		weight = 500,
		allowArmed = false,
		close = false,
		stack = true,
	},
	['piece_of_wood'] = {
		label = 'Petit bout de bois',
		description = "un petit bout de bois",
		weight = 100,
		allowArmed = false,
		close = false,
		stack = true,
	},
	['liane'] = {
		label = 'Liane',
		description = "une liane",
		weight = 200,
		allowArmed = false,
		close = false,
		stack = true,
	},
	['fishing_rod'] = {
		label = 'Canne à pêche',
		description = "",
		weight = 300,
		allowArmed = false,
		close = true,
		stack = false,
		client = {
			usetime = 1500,
			event = 'owx:startFishing',
		},
	},
	['plastic'] = {
		label = 'Plastique',
		description = "morceaux de plastique divers et variés",
		weight = 300,
		allowArmed = false,
		close = false,
		stack = true,
	},
	['screw'] = {
	        label = 'Vis',
	        description = "peuvent être utile pour construire certaines choses",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['treated_wood'] = {
	        label = 'Bois traité',
	        description = "peuvent être utile pour construire certaines choses",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['fabrics'] = {
	        label = 'tissu',
	        description = "morceau de tissus divers et variés",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true, 
	},
	['untreated_wood'] = {
	        label = 'Bois brut',
	        description = "serait plus utile traité",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['pile'] = {
	        label = 'Pile',
	        description = "utile pour certains objets",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['hinge'] = {
	        label = 'Charnière',
	        description = "peuvent être utile pour construire certaines choses",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['plastic_bottle'] = {
	        label = 'Bouteille en plastique',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['car_plug'] = {
	        label = 'Bougies de voiture',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['cover'] = {
	        label = 'Capot',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['door'] = {
	        label = 'Portière',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['printed_circuit'] = {
	        label = 'Circuit imprimé',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['steering_wheel'] = {
	        label = 'Volant',
	        description = "",
	        weight = 800,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['bag'] = {
		label = 'Sac à dos',
		weight = 1000,
		stack = false,
		consume = 0,
		client = {
			export = 'fb_wallet.openBackpack'
		}
	},
	['backpack_small'] = {
	        label = 'Sac à dos',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['backpack_normal'] = {
	        label = 'Sac de sport',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['backpack_big'] = {
	        label = 'Sac à dos de combat',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['bandage'] = {
	        label = 'Bandage',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['dirt'] = {
	        label = 'Terre',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['sand'] = {
	        label = 'Sable',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['glass_bottle'] = {
	        label = 'Bouteille en verre',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['string'] = {
	        label = 'Corde',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['adhesive_tape'] = {
	        label = 'Ruban adhésif',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	
	},
	['douille9'] = {
	        label = 'Douille 9x19 mm',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['douille45'] = {
	        label = 'Douille 45 ACP',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['douille5'] = {
	        label = 'Douille 5.56',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['douille7'] = {
	        label = 'Douille 7.62',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['douille12'] = {
	        label = 'Cartouche .12 Slug',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['balle9'] = {
	        label = 'Balle 9x19 mm',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['balle45'] = {
	        label = 'Balle 45 ACP',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['balle7'] = {
	        label = 'Balle 7.62',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['balle5'] = {
	        label = 'Balle 5.56',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = false,
	        degrade = 560,
	},
	['balle12'] = {
	        label = 'Cartouche .12 Slug',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['serflex'] = {
	        label = 'Collier de serrage',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['sleeping_bag'] = {
	        label = 'Sac de couchage',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['compress'] = {
	        label = 'Compresse',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['adrenalin'] = {
	        label = 'Adrénaline',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['disinfectant'] = {
	        label = 'Désinféctant',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	        degrade = 560,
	},
	['tonic'] = {
	        label = 'Tonique',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['vaccin1'] = {
	        label = 'Vaccin phase 1',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['gunpowder'] = {
	        label = 'Poudre à canon',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['menotte'] = {
	        label = 'Menottes ',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['casserole'] = {
	        label = 'Casserole',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['conserve_viande'] = {
	        label = 'Conserve de viande',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['conserve_legume'] = {
	        label = 'Conserve de légume',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['conserve_cassoulet'] = {
	        label = 'Conserve de cassoulet',
	        description = "sa c'est la desc",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['coal'] = { 
	        label = 'Charbon',
	        description = "sa c'est la desc",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['bag_ciment'] = {
	        label = 'Sac de ciment',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['essence'] = {
	        label = 'Essence',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['cadre_bmx'] = {
	        label = 'Cadre de vélo',
	        description = "",
	        weight = 800,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['roue_bmx'] = {
	        label = 'Roue de vélo',
	        description = "",
	        weight = 600,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['paille'] = {
	        label = 'Paille',
	        description = "sa c'est la desc",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['seringue'] = {
	        label = 'Seringue',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['chimique'] = {
	        label = 'Produits chimique',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['souffre'] = {
	        label = 'Souffre',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['map'] = {
	        label = 'Carte',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['lighter'] = {
	        label = 'Briquet',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['campfire'] = {
	        label = 'Feu de camps',
	        description = "",
	        weight = 700,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['basic_tent'] = {
	        label = 'Tente rudimentaire',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['viande_hawk'] = {
	        label = 'Viande de Faucon',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = false,
	        degrade = 5*60,
	},
	['water_purifier'] = {
	        label = "Purificateur d'eau",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['basic_bag'] = {
	        label = 'Sac rudimentaire',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['clean_fabric'] = {
	        label = 'Tissu propre',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	        degrade = 10000*60,
	},
	['clean_water_bottle'] = {
	        label = "Bouteille d'eau traitée",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['clean_water_bottle2'] = {
	        label = "Gourde d'eau traitée",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['gourde'] = {
	        label = 'Gourde',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['bicycle'] = {
	        label = 'Vélo',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['box'] = {
	        label = 'Coffre',
	        description = "",
	        weight = 900,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['radio'] = {
	        label = 'Radio',
	        description = "",
	        weight = 350,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['medikit'] = {
	        label = 'Kit de soins',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['testingkit'] = {
	        label = 'Kit de test',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['vaccin2'] = {
	        label = 'Vaccin phase 2',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['weed'] = {
	        label = 'Cannabis',
	        description = "",
	        weight = 100,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['meth'] = {
	        label = 'Méthamphétamine',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['hunting_knife '] = {
	        label = 'Couteau de chasse',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['machete'] = {
	        label = 'Machette',
	        description = "sa c'est la desc",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['molotov'] = {
	        label = 'Cocktail molotov',
	        description = "sa c'est la desc",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['battle_axe'] = {
	        label = 'Hache de combat',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['plomb'] = {
	        label = 'Bille de plomb',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['douille50'] = {
	        label = 'Douille Cal.50',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['balle50'] = {
	        label = 'Balle Cal.50',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['kevlar1'] = {
	        label = 'Gilet par balle rudimentaire',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['kevlar2'] = {
	        label = 'Gilet par balle expérimenté',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['silentieux_pistol'] = {
	        label = 'Silencieux pour pistolet',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['torche_pistol'] = {
	        label = 'Torche pour pistolet',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},

	['chargeur_pistol'] = {
	        label = 'Chargeur grande capacité pistolet',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['torche_pompe'] = {
	        label = 'Torche pour pompe',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['chargeur_mitraillette'] = {
	        label = 'Chargeur grande capacité mitraillette',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['silentieux_mitraillette'] = {
	        label = 'Silencieux mitraillette',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['torche_mitraillette'] = {
	        label = 'Torche pour mitraillette',
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['charguer_fusil_assaut'] = {
	        label = "Chargeur grande capacité fusils d'assaut",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['silentieux_fusil_assaut'] = {
	        label = "Silencieux fusils d'assaut",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['torche_fusil_assaut'] = {
	        label = "Torche pour fusils d'assaut",
	        description = "",
	        weight = 300,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['moule_douille'] = {
	        label = 'Moule à douille',
	        description = "",
	        weight = 800,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['generateur'] = {
	        label = 'Générateur',
	        description = "",
	        weight = 1000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['lamp_chantier'] = {
	        label = 'Lampe de chantier',
	        description = "",
	        weight = 900,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['frigo'] = {
	        label = 'Frigo',
	        description = "",
	        weight = 2000,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['rateau'] = {
	        label = 'Rateau',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['pelle'] = {
	        label = 'Pelle',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['betonniere'] = {
	        label = 'Betonniere',
	        description = "",
	        weight = 800,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['plaque_metal'] = {
	        label = 'Plaque de métal',
	        description = "",
	        weight = 700,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['pioche'] = {
	        label = 'Pioche',
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['bidon'] = {
	        label = "Bidon d'eau",
	        description = "",
	        weight = 500,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['cement'] = {
	        label = 'Ciment',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['plastic2'] = {
	        label = 'Plastique renforcer',
	        description = "",
	        weight = 400,
	        allowArmed = false,
	        close = false,
	        stack = false,
	},
	['ressort'] = {
	        label = 'Ressort ',
	        description = "",
	        weight = 200,
	        allowArmed = false,
	        close = false,
	        stack = true,
	},
	['tournevis'] = {
	    label = 'Tournevis',
	    description = "",
	    weight = 300,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['crochetage'] = {
	    label = 'Outils de crochetage',
	    description = "",
	    weight = 400,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['hammer'] = {
	    label = 'Marteau',
	    description = "",
	    weight = 400,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['arrosoir '] = {
	    label = 'Arrosoir',
	    description = "",
	    weight = 500,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['poubelle'] = {
	    label = 'Poubelle',
	    description = "",
	    weight = 700,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['plaque_verre'] = {
	    label = 'Plaque de verre',
	    description = "",
	    weight = 300,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['pneu'] = {
	    label = 'Pneu',
	    description = "",
	    weight = 300,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['battery'] = {
	    label = 'Batterie',
	    description = "",
	    weight = 400,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['chiffon'] = {
	    label = 'Chiffon',
	    description = "",
	    weight = 400,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['repair_kit'] = {
	    label = 'Kit de réparation',
	    description = "sa c'est la desc",
	    weight = 600,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['ragout'] = {
	    label = 'Ragout de viande',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = ftrue,
	    degrade = 2400*60,
	},
	['soupe'] = {
	    label = 'Soupe de légumes',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = true,
	    degrade = 2400*60,
	},
	['fish'] = {
	    label = 'Poisson',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = true,
	    degrade = 2400*60,
	},
	['sandwich'] = {
	    label = 'Sandwich',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = true,
	    degrade = 2400*60,
	},
	['jambon'] = {
	    label = 'Jambon',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = true,
	    degrade = 2400*60,
	},
	['viande_cuite'] = {
	    label = 'Viande cuite',
	    description = "",
	    weight = 200,
	    allowArmed = false,
	    close = false,
	    stack = true,
	    degrade = 2400*60,
	},
	['alcool'] = {
	    label = "Bouteille d'alcool",
	    description = "",
	    weight = 300,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['valcool2'] = {
	    label = 'Alcool (whisky, Rhum, Bière)',
	    description = "",
	    weight = 300,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},
	['jardinniere'] = {
	    label = 'Jardinnière',
	    description = "",
	    weight = 1000,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['epouvantail'] = {
	    label = 'Epouvantail',
	    description = "",
	    weight = 900,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['compost'] = {
	    label = 'Compost',
	    description = "",
	    weight = 1200,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['serre'] = {
	    label = 'Serre',
	    description = "",
	    weight = 1200,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['separateur_graine'] = {
	    label = 'Séparateur de graine',
	    description = "",
	    weight = 400,
	    allowArmed = false,
	    close = false,
	    stack = false,
	},
	['cuir'] = {
	    label = 'Cuir',
	    description = "",
	    weight = 100,
	    allowArmed = false,
	    close = false,
	    stack = true,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["bandage"] = {
		label = "Bandage",
		weight = 2,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["phone"] = {
		label = "Phone",
		weight = 1,
		stack = true,
		close = true,
	},

	["radio"] = {
		label = "Radio",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	["megaphone"] = {
		label = "Megaphone",
		weight = 1,
		stack = true,
		close = true,
	},

	
	["repairkit"] = {
		label = "Kit de réparation",
		weight = 1,
		stack = true,
		close = true,
	},
}