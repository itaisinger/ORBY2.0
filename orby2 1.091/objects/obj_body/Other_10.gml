///@description 
var send = false;
while(!place_meeting(x,y+1,obj_solid))
{
	send = true;
	y++;
	
	if(bbox_top > room_height)
	{
		instance_destroy();
		break;
	}
}
if(send)
{
	if(!place_meeting(x,y+1,obj_solid))
		with(obj_body)
		{
			if(!place_meeting(x,y+1,obj_solid)) event_user(0);
		}
}