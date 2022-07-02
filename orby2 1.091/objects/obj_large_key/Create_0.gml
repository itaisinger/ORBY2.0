//this object saves the anvils that are on top of it.
event_inherited();
sprite_index = spr_large_key_red;
base_h = image_yscale;

var anvils = obj_game.list_placed_anvils;
image_yscale = (base_h/4)*(4-ds_list_size(anvils));