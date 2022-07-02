///@description 
if(instance_exists(obj_pause)) exit;

#region behavior

switch(state)
{
	#region create
	case MINERS.created:
	
	if(irandom(90) == 1 and ground) jump();
	
	if(y > 0 and ground)
		hsp = spd;
	
	break;
	#endregion
	#region fall
	case MINERS.fall:
	
	if(ground) state = MINERS.normal;
	if(y > room_height) instance_destroy();
	
	break;
	#endregion
	#region normal
	case MINERS.normal:
	
	//choose dir
	if(dir == 0) dir = sign(irandom_range(-10,10));
	
	//move
	hsp = spd*dir;
	
	//jump over obstacles
	if(place_meeting(x+hsp,y+vsp,obj_solid) and ground)
		jump();
	
	//jump when going off floor
	if(!place_meeting(x+hsp,y+1,obj_solid) and ground)
		jump();
	
	break;
	#endregion
	#region spawn
	
	case MINERS.spawn:
	
	eye_scale = 1.1;
	eyeout_index = 3;
	var spawn_obj = instance_find(obj_spawn_npc,0);
	switch(stage)
	{
		case 0: //disappear to prepare for spawn
		
		draw_xs = 0;
		draw_ys = 0;
		
		if(!instance_exists(obj_spawn_npc))
			spawn_obj = instance_create_depth(x,y, depth,obj_spawn_npc)
		y = spawn_obj.y;
		
		if(spawn_obj.state == SPAWN_STATES.natural)
		{
			spawn_obj.state = SPAWN_STATES.destroy;
			stage++;
		}
		
		break;
		//////////
		case 1: //spawn animation
				
		//desquash happens by itself at the bottom
		if(draw_xs == 1 and spawn_obj == noone)
		{
			spawn_obj = instance_create_depth(x,y, depth,obj_spawn_npc)
			y--;
			stage++;
		}
		
		break;
		///////////
		case 2: //create a new spawn
				
		if(spawn_obj.state == SPAWN_STATES.natural)
			stage++;
		
		break;
		///////////
		case 3: //walk and fall to demise
		
		hsp = -spd;
		if(x<0) global.miner_saved = 1;
		
		//jump when going off the floor
		if((!place_meeting(x+hsp,y+1,obj_solid) or place_meeting(x+hsp,y,obj_solid)) and ground)
			jump();
		
		//continute 
		if(instance_exists(obj_miner_body))
		{
			stage++;
			draw_xs = 0;
			draw_ys = 0;
			alarm[1] = 60;
		}
		
		break;
		//////////
		case 4: //shrink
		
		draw_xs = 0;
		draw_ys = 0;
		
		if(alarm[1] == 1)
		{
			alarm[1] = 60;
			stage++;
		}
		
		break;
		//////////
		case 5: //the body disappears
		
		draw_xs = 0;
		draw_ys = 0;
		
		var body = instance_find(obj_miner_body,0);
		var eye = instance_find(obj_player_eye,0);
		
		body.image_xscale -= 0.03;
		eye.image_yscale  -= 0.01;
		
		if(body.image_xscale < 0)
		{
			instance_destroy(body);
			x = spawn_obj.x;
			y = spawn_obj.y;
			stage = 0;
		}
		
		break;
	}
	
	break;
	#endregion
	#region multijump
	case MINERS.multijump:
	
	if(place_meeting(x,y,obj_solid))
	{
		while(place_meeting(x,y,obj_solid))
			y--;
	}
	
	//proceed
	if(y < obj_trigger.y)
	{
		global.miner_saved = 1;
		hsp = -spd;
	}
	
	break;
	#endregion
}

#endregion
#region movement
	
grav = approach(grav,0.007,0.8);
if(vsp < 0) grav = 0.8;

var ground_prev = ground;
ground = place_meeting(x,y+sign(grav),obj_solid)

if(!ground_prev and ground and stage < 3)
{
	draw_xs = 1.3;
	draw_ys = 0.7;
}

if(!ground) vsp += grav;
	
collision_npc()

x += hsp;
y += vsp;


//turn when stuck
if(x != xprevious)
	alarm[0] = 40;
	

#region die

if(y > room_height+100)	
	instance_destroy();
	
if(place_meeting(x,y,obj_hazard))
{	
	//body
	with instance_create_depth(x,y,depth,obj_miner_body)
	{
		eye_index = other.eyeout_index;
		eye_scale = other.eye_scale;
	}
	
	//eye
	with instance_create_depth(x,y,depth,obj_player_eye)
	{
		hsp = other.eye_hsp;
		vsp = other.eye_vsp;
	}
	
	if(state != MINERS.spawn)
		instance_destroy();
	else
	{
		draw_xs = 0;
		draw_ys = 0;
		y -= 30;
	}
}

eye_hsp = hsp;
eye_vsp = vsp;

#endregion

#endregion
#region desquash

var s_spd = 0.03;
draw_xs = approach(draw_xs,s_spd,draw_xs_goal);
draw_ys = approach(draw_ys,s_spd,draw_ys_goal);

#endregion
