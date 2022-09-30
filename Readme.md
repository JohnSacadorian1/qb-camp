qb-camp using qb-bbq from https://github.com/oosayeroo/qb-bbq






Update - 14/9/22 - Purchaseable grills that you can place in the world and use. updated for new inventory update. 


Discord - https://discord.gg/3WYz3zaqG5

# A BBQ Script for QBCore Framework

## Please note

- Please make sure u use the latest dependencies aswell as core for this in order to work.

- This Job has been tested on the latest build as of 07/07/2022.


## Dependencies :

QBCore Framework - https://github.com/qbcore-framework/qb-core

PolyZone - https://github.com/mkafrin/PolyZone

qb-target - https://github.com/BerkieBb/qb-target

qb-input - https://github.com/qbcore-framework/qb-input

qb-menu - https://github.com/qbcore-framework/qb-menu

qb-shops - https://github.com/qbcore-framework/qb-shops 

## Known Issues 
```
FIXED -- shop not working on some servers. now converted to qb-menu based shop
```

## Credits : 

- Breadlord as this was his original idea and he gave me permission to do it instead. 
- Jason. for giving me some code to delete prop after use - Top Guy
- Flash061 for his idea of buyable grills to place down
- HunterMak98 for her images, names and descriptions
- Toxmina for helping with images 

## Insert into @qb-core/shared/items.lua 

```
QBShared.Items = {
--qb-bbq
	['tent'] 			        = {['name'] = 'tent', 		        	   	['label'] = 'Small Tent', 		    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'tent.png', 	        	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = '2 Person Camping Tent'},
	
}

```
