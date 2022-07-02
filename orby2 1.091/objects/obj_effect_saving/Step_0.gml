///@description 

//text
if(text_cd > 0) text_cd--;
else
{
	if(text_current == text_full)
		animation_finished = true;
	
	if(!animation_finished)
	{
		text_current += string_char_at(text_full,string_length(text_current)+1);
		if(text_current == text_full)
			text_cd = 30*anim_speed;
	}
	else
	{
		text_current = string_delete(text_current,1,1);
		//if(text_current == "s") text_current = "";
	}
	
	text_cd = text_cd_max*anim_speed;
}




//cube
if(!animation_finished) radius = approach(radius,0.06/anim_speed,radius_max);
else radius = approach(radius,0.04/anim_speed,0);
angle += spd;


//destroy
if(text_current == "" and animation_finished)
	instance_destroy();