depth = DEPTH.wall_block;
is_made = 0;
index = 0;
state = 0; 
off = 0;

enum WALL_STATES{
	natural,
	breaking,
	breaking2,
	breaking3,
	broken,
}

effect_grid = noone;
effect_wave = noone;

grid_effects = [spr_key, spr_wall_break1, spr_wall_break2, spr_wall_break3, spr_wall_break4, spr_wall_break5];

destroy_spikes = false;