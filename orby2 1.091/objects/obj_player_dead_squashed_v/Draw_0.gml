if(obj_player.dead)
	update_sprites();

if(killer.grav>0)
while(place_meeting(x,y,killer))
{
	image_xscale = approach(image_xscale,0.05,1.5);
	image_yscale = lerp(abs(image_yscale),0.05,0.2)*sign(killer.grav);	
	
	if(image_xscale == 1.5) break;
}
draw_self();
draw_sprite_ext(eyeout_spr,0,x,y,image_xscale,image_yscale,0,c_white,1);