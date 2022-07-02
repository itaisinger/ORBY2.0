///@description 
if(text == "nothingatall")
	text = "";

text = keyboard_string;

text_inst.text = text;
if(wave(-1,1,2,0) > 0) text_inst.text += "|";

with(text_inst)
{
	x = other.x;
	y = other.y;
	scale = other.scale;
	color = other.color;
	outline_color = other.outline_color;
	outline_width = other.outline_width;
	halign = other.halign;
	valign = other.valign;
	font = other.font;
}

if(text == "")
	text = "nothingatall";