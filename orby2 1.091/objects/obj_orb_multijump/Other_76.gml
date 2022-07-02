var _event_type = event_data[? "event_type"];
var _message	= event_data[? "message"];

if(_event_type == "sequence event")
{
	if(_message == "multijump")
	{
		uses = uses_max;
		multijump = true;
	}
	if(_message == "jump")
	{
		alarm[0] = 20;
		placed = 0;
	}
}