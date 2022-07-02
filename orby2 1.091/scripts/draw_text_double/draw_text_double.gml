///@desc draw_text_outline()
///@arg0x
///@arg1y
///@arg2text
///@arg3offset
///@arg4color
function draw_text_double(argument0, argument1, argument2, argument3, argument4) {

	var b_color = draw_get_color();
	var xx = argument0;
	var yy = argument1;
	var text = argument2;
	var off = argument3;
	draw_set_color(argument4);

	draw_text(xx-off,yy,text); //right
	draw_text(xx,yy+off,text); //down

	draw_set_color(b_color);
	draw_text(xx,yy,text);


}
