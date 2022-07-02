///@description 
var vis = 1;
depth = DEPTH.wall_fake;

orb_alpha = 1 - get_invis_alpha();
if(orb_alpha < 1) vis = 0;

if(place_meeting(x,y,obj_player))
{
	player_alpha = approach(player_alpha, 0.03, min(player_alpha,0.3));
	vis = 0;
} else player_alpha = approach(player_alpha, 0.03, 1);

if(vis) image_alpha = approach(image_alpha, 0.02, 1);
else image_alpha = min(player_alpha,orb_alpha);
