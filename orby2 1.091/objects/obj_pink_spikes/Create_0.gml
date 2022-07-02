///@description 
double = 1;
image_xscale = 2;

function attach(spikes){
	//attach myself to a spikes instance
	
	x = spikes.x;
	y = spikes.y;
	image_angle = spikes.image_angle;
	image_yscale = spikes.image_yscale;
	
	//basically only small spikes cuase problems so no reason to hang around here anymore.
	if(spikes.object_index != obj_spikes_small) 
		return;
		
		
	var _a = spikes.image_angle;
	y -= lengthdir_y(32,_a-90)*image_yscale;
	
	
	var _xx = lengthdir_x(9,_a);
	var _yy = lengthdir_y(9,_a);
	
	//check for nearby spikes
	instance_deactivate_object(spikes);
	var _right = instance_place(x+_xx,y+_yy,obj_hazard)
	var _left  = instance_place(x-_xx,y-_yy,obj_hazard)
	
	//ignore them if they are not the same direction
	if(_right != noone and _right.image_angle == image_angle) _right = 1;
	else _right = 0;
	
	if(_left != noone and _left.image_angle == image_angle) _left = 1;
	else _left = 0;
	
	//middle
	if(_left and _right)
	{
		log("in the middle")
	}
	//none at right
	else if(_left)
	{
		log("none at right")
		
		x -= lengthdir_x(32,image_angle);
		y -= lengthdir_y(32,image_angle);
		
		//if the spikes are in different degrees, make myself single
		//var _at_left = instance_place(x-_xx,y-_yy,obj_hazard);
		//instance_deactivate_object(_at_left);
	}
	//none at left
	else if(_right)
	{
		log("none at left")
		
		x += lengthdir_x(32,image_angle);
		y += lengthdir_y(32,image_angle);
		
		//while(!place_meeting(x-_xx,y-_yy,obj_hazard))
		//{
		//	x += lengthdir_x(1,image_angle);
		//	y += lengthdir_y(1,image_angle);
		//}
	}
	//loner
	else
	{
		log("loner")
		image_xscale = 1;
		double = 0;
	}
	
	instance_activate_object(spikes);
}
function get_sfx(vsp){

var _tiers = [0,10,30]

vsp = abs(vsp);
global.vsp_last = vsp;

if(vsp < _tiers[1]) return sfx_jump_pink1;
if(vsp < _tiers[2]) return sfx_jump_pink2;
return sfx_jump_pink3;
}