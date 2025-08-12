1. Add This to your QBCore/shared/items.lua, you can configure it if you want

    ['smalltv'] 			 	 	 = {['name'] = 'smalltv', 					['label'] = 'Small TV', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] =     'smalltv.png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'It allows you to play YouTube videos  or Twitch streams'},	
    ['mediumtv'] 			 	 	 = {['name'] = 'mediumtv', 					['label'] = 'Medium TV', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] =     'mediumtv.png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'It allows you to play YouTube     videos or Twitch streams'},	
    ['bigtv'] 			 	 		 = {['name'] = 'bigtv', 					['label'] = 'Big TV', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'bigtv.png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'It allows you to play YouTube videos or   Twitch streams'},	

2. Drop this query to your databse

    CREATE TABLE IF NOT EXISTS `17movTVs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `type` text DEFAULT NULL,
    `data` varchar(1000) DEFAULT NULL,
    `active` tinyint(4) DEFAULT 1,
    `owner` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8;

3. Drop the `inventoryImages` to your inventory system 

3. Create shop that contains TVs. You can do it on your own, but if you dont know how, here's some exapmles. You have to drop it to qb-shops/config.lua. If you will dont know how to do it, feel free to ask for help on our discord! We'll glad to help you.

    ["tvShop"] = {
        [1] = {
            name = "smalltv",
            price = 5000,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "mediumtv",
            price = 10000,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "bigtv",
            price = 30000,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
    },


    ["tvShop"] = {
        ["label"] = "TV Shop",
        ["coords"] = vector4(-1083.04, -245.82, 37.76, 208.26),
        ["ped"] = 'a_f_m_fatcult_01',
        ["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
        ["radius"] = 3.0,
        ["targetIcon"] = "fas fa-shopping-basket",
        ["targetLabel"] = "Open Shop",
        ["products"] = Config.Products["tvShop"],
        ["showblip"] = true,
        ["blipsprite"] = 434,
        ["blipcolor"] = 69
    },


How to add new Tv's models?

First of all search the model that you like, it can be even a custom model created by you. Then choose a name for the tv, by defaults the name is "small", "medium" and "big". Then add it under Config.Props in this format:
    ["tvName"] = "modelName", 

Remember the tvName, you have to use it later for every "tvName" gap. Why? Just to clarify: When user is using item "tvName", then the script knows that has to create a model, that is assigned to "tvName" under config.

Then you have to create item. It really depends on your framework, but on ESX, just add item to databse:

    INSERT INTO `items` (name, label, weight) VALUES
        ('tvName','tv Label', 2),
    ;

For QB:

    ['tvName'] 			 	 		 = {['name'] = 'tvName', 					['label'] = 'TV Label', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'tvName. png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'It allows you to play YouTube videos or Twitch streams'},

And the last, but the hardest one, you have to prepeare a Config.TvRendering. And here you also have to use this same name as on the Config.Props in this format:

    ["tvName"] = {
        offest = {x, y, z},
        scaleX = Int,
        scaleY = Int,
    },

Offest means offset screen from the model. Its very tricky, there is no method for this, you have to do it by trial and error by changing the appropriate X Y Z values
Scales means just size of the screen, you also have to set it on your own, just for your model