///@description 
if(instance_exists(obj_pause)) exit;

#region get inside anvils

var anvil = instance_place(x,y,obj_anvil);
if(anvil != noone)
{
	state = CAPITAL_STATES.anvil;
	my_anvil = anvil;
}

#endregion

#region momentum
vsp += momentum_y;
momentum_y = 0;

hsp += momentum_x;
if(ground) momentum_x = approach(momentum_x,ground_fric,0);
else momentum_x = approach(momentum_x,air_fric,0);

#endregion

switch(state)
{
	#region natural
	case CAPITAL_STATES.natural:
	
	if(walk_dis == 0)
	{
		//set new walk range
		if(walk_cd <= 0)
		{
			walk_cd  = irandom_range(20,180);
			walk_dis = irandom_range(30,100)*irandom_range(-1,1);
			walk_spd = random_range(2,4);
			if(place_meeting(x+sign(walk_dis),y,obj_solid)) 
				walk_dis *= -1;
			
			if(walk_dis%5 == 0) grav *= -1;
			if(walk_dis%12 == 0) state = CAPITAL_STATES.despawn;
		}
		//wait in place
		else
		{
			walk_cd--;
			if(place_meeting(x,y,obj_capital)) walk_cd--;
		}
	}
	//walk
	else
	{
		hsp = min(walk_spd,abs(walk_dis))*sign(walk_dis);
		
		collision_npc();
		
		if(hsp == 0) walk_dis *= -1;
		
		x += hsp;
		walk_dis = approach(walk_dis,abs(hsp),0);
	}

	draw_xs_goal = 1;
	draw_ys_goal = 1;
	
	var bx1 = -100;
	var bx2 = 100;
	
	if(sign(walk_dis) < 0) bx1 -= 300; 
	if(sign(walk_dis) > 0) bx2 += 300;
	
	//run from player
	if(collision_rectangle(x+bx1,y-300,x+bx2,y+300,obj_player,0,0))
	{
		if(!obj_player.is_king and !obj_player.is_capital) //transition to run from player
		{
			draw_xs = 1.6;
			draw_ys = 1.6;
			
			if(!audio_is_playing(sfx_capital_fright))
				fright_id = play_sfx(sfx_capital_fright);
			state = CAPITAL_STATES.run;
			alarm_set(0,0);
			run_dir = 0;
		
			//look at player
			var eye_xmax = (sprite_get_width(spr_eyeout)*image_xscale)/2  - sprite_get_width(spr_eye)/2;
			var eye_ymax = (sprite_get_height(spr_eyeout)*image_yscale)/2 - sprite_get_width(spr_eye)/2;
			var dir = point_direction(x,y, obj_player.x,obj_player.y);
		
			eye_xoff = lengthdir_x(eye_xmax,dir);
			eye_yoff = lengthdir_y(eye_ymax,dir);
			
			if(irandom(10)>80) state = CAPITAL_STATES.despawn;
		}
		else if(obj_player.is_king) //transition to bow to player
		{
			state = CAPITAL_STATES.bow;
			walk_dis = 0;
		}
	}
	
	if(instance_exists(obj_king))
		state = CAPITAL_STATES.bow_king;
	
	break;
	#endregion
	#region run 
	case CAPITAL_STATES.run:
	
	//return to natural
	if(!instance_exists(obj_player))
	{
		state = CAPITAL_STATES.natural;
		exit;
	}
	
	//move
	var move_dir = run_dir;
	if(move_dir == 0) move_dir = sign(x-obj_player.x);
	hsp = spd*1.7*move_dir;
	walk_dis = hsp //just to draw the eye moving
	collision_npc();
	
	if(hsp == 0 and ground) grav *= -1;
	
	x += hsp;
	
	//look at player
	if(alarm_get(0) == -1)
	{
		var eye_xmax = (sprite_get_width(spr_eyeout)*image_xscale)/2  - sprite_get_width(spr_eye)/2;
		var eye_ymax = (sprite_get_height(spr_eyeout)*image_yscale)/2 - sprite_get_width(spr_eye)/2;
		var dir = point_direction(x,y, obj_player.x,obj_player.y);
		
		eye_xoff = lengthdir_x(eye_xmax,dir);
		eye_yoff = lengthdir_y(eye_ymax,dir);
		
		alarm_set(0,irandom_range(60*2,60*6));
	}
	
	//switch direction if doesnt work
	if(x != xprevious) alarm[1] = 60*1.5;
	
	draw_xs_goal = 1;
	draw_ys_goal = 1;
	
	break;
	#endregion
	#region bow
	case CAPITAL_STATES.bow:
	
	grav = abs(grav);
		
	//look at the player and bow
	walk_dis = approach(walk_dis,1,sign(obj_player.x-x)); 
	
	draw_xs_goal = 1.3;
	draw_ys_goal = 0.7;
	
	image_xscale = 2;
	var o = instance_place(x,y,obj_capital);
	if(o == noone) o = instance_place(x,y,obj_wall);
	
	if(o != noone)
	{
		if(x == o.x)
		{
			if(id>other)
				x++;
		}
		
		image_xscale = 1;
		var dir = point_direction(o.x,o.y, x,y)
		hsp += lengthdir_x(1,dir)
		collision_npc();
		x += hsp;
	}
	
	image_xscale = 1;
	
	if(obj_player.killer != noone)
	{
		state = CAPITAL_STATES.shock;
		draw_xs = 1;
		draw_ys = 1.6;
	}
	
	break;
	#endregion
	#region bow king
	case CAPITAL_STATES.bow_king:
	
	grav = abs(grav);
	
	if(!instance_exists(obj_king))
	{
		state = CAPITAL_STATES.shock;
		draw_xs = 1;
		draw_ys = 1.6;
		exit;
	}
	
	//look at the king and bow
	walk_dis = approach(walk_dis,1,sign(obj_king.x-x)); 
	
	draw_xs_goal = 1.3;
	draw_ys_goal = 0.7;
	
	image_xscale = 2;
	var o = instance_place(x,y,obj_capital);
	if(o == noone) o = instance_place(x,y,obj_wall);
	
	if(o != noone)
	{
		if(x == o.x)
		{
			if(id>other)
				x++;
		}
		
		image_xscale = 1;
		var dir = point_direction(o.x,o.y, x,y)
		hsp += lengthdir_x(1,dir)
		collision_npc();
		x += hsp;
	}
	
	image_xscale = 1;
	
	break;
	#endregion
	#region shock
	case CAPITAL_STATES.shock:
	
	if(place_meeting(x,y,obj_solid))
	{
		y = instance_place(x,y,obj_solid).bbox_top-1;
	}
		
	if(walk_dis == 0)
	{
		//set new walk range
		walk_dis = irandom_range(20,70)*irandom_range(-1,1);
		walk_spd = irandom_range(spd*1.4,spd*1.8);
		
		if(walk_dis%25 == 0) grav *= -1;
	}
	//walk
	else
	{
		hsp = min(walk_spd,abs(walk_dis))*sign(walk_dis);
		
		collision_npc();
		
		if(hsp == 0) walk_dis *= -1;
		
		x += hsp;
		walk_dis = approach(walk_dis,abs(hsp),0);
	}

	draw_xs_goal = 0.7;
	draw_ys_goal = 1.3;
	
	//transition to bow
	var bx1 = -200;
	var bx2 =  200;
	
	if(sign(walk_dis) < 0) bx1 -= 500; 
	if(sign(walk_dis) > 0) bx2 += 500;
	
	if(instance_exists(obj_player))
	if(collision_rectangle(x+bx1,y-400,x+bx2,y+400,obj_player,0,0) and obj_player.is_king)
	{
		state = CAPITAL_STATES.bow;
		walk_dis = 0;
	}
	
	break;
	#endregion
	#region anvil
	
	case CAPITAL_STATES.anvil:
	
	var a_spd = 0;
	var anvil_v = my_anvil.object_index == obj_anvil_v or my_anvil.object_index == obj_anvil_spiked
	
	//choose the right sprite + collect total move speed
	if(anvil_v)
	{
		sprite_index = spr_capital_anvil_v;
		a_spd += my_anvil.vsp;
	}
	else
	{
		sprite_index = spr_capital_anvil_h;
		a_spd += my_anvil.hsp;
	}
	
	//stick to my anvil
	x = my_anvil.x;
	y = my_anvil.y;
	
	//exit state if done moving.
	if(a_spd == 0)
	{
		sprite_index = spr_capital;
		//find what direction to exit from
		if(anvil_v)
		{
			if(my_anvil.grav>0) y = my_anvil.bbox_top-1;
			if(my_anvil.grav<0) y = my_anvil.bbox_bottom+sprite_height+1;
			
			x = (my_anvil.bbox_right+my_anvil.bbox_left)/2;
		}
		else
		{
			if(my_anvil.grav>0) //anvil going right
			{
				//try to stand on my anvil
				x = (my_anvil.bbox_right+my_anvil.bbox_left)/2;
				y = my_anvil.bbox_top-1;
				
				//if the place is occupied with a wall, go to the left of the anvil.
				if(place_meeting(x,y,obj_solid))
				{
					x = my_anvil.bbox_left-sprite_width/2-1;
					y = my_anvil.bbox_bottom;
				}
			}
			if(my_anvil.grav<0) //anvil going left
			{
				//try to stand on my anvil
				x = (my_anvil.bbox_right+my_anvil.bbox_left)/2;
				y = my_anvil.bbox_top-1;
				
				//if the place is occupied with a wall, go to the left of the anvil.
				if(place_meeting(x,y,obj_solid))
				{
					x = my_anvil.bbox_right+sprite_width/2+1;
					y = my_anvil.bbox_bottom;
				}
			}
		}
		
		state = CAPITAL_STATES.natural;
	}
	
	break;
	
	
	#endregion
	#region despawn
	
	case CAPITAL_STATES.despawn:
	
	draw_xs_goal = 0;
	draw_ys_goal = 0;
	
	if(draw_xs == 0) instance_destroy();
	
	break;
	
	#endregion
}

if(instance_exists(obj_credits))
if(obj_credits.end_index == ENDINGS.kinghood)
	state = CAPITAL_STATES.bow;

#region grav

var ground_prev = ground;
ground = place_meeting(x,y+sign(grav),obj_solid)

if(!ground_prev and ground)
{
	draw_xs = 1.3;
	draw_ys = 0.7;
}

if(!ground) vsp += grav;
collision_npc();
y += vsp;

#endregion
#region desquash
var s_spd = 0.03;
draw_xs = approach(draw_xs,s_spd,draw_xs_goal);
draw_ys = approach(draw_ys,s_spd,draw_ys_goal);

#endregion
#region offscreen

if((bbox_right>room_width) or(bbox_left<0) or(bbox_top<0) or(bbox_bottom>room_height))
{
	if(onscreen)
		instance_destroy();
	state = 0;
} else onscreen = true;

#endregion