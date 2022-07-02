///@description 
if(grav<0 or anvil_index != -1) exit;
if(magnet_anvil != noone)
{
	if(place_meeting(x,magnet_anvil.bbox_top+1,magnet_anvil))
		y = magnet_anvil.bbox_top;
	else magnet_anvil = noone;
}
else
{
	var anvil_inst = instance_place(x,y+1,obj_anvil_v);
	if(anvil_inst != noone)
	if(anvil_inst.grav>0)
		magnet_anvil = anvil_inst;
}