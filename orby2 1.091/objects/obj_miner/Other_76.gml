var _event_type = event_data[? "event_type"];
var _message	= event_data[? "message"];

if(_event_type == "sequence event")
{
	if(_message == "multijump")
	{
		jumpforce = 14;
		state = MINERS.multijump;
	}
	if(_message == "jump")
		vsp = -jumpforce;
}