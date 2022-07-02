///@desc draw_text_outline()
///@arg0x
///@arg1y
///@arg2text
///@arg3offset
///@arg4main color
///@arg4back color
///@arg6scale
function draw_text_double_ext(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var xx = argument0;
	var yy = argument1;
	var text = argument2;
	var off = argument3;
	var m_color = argument4;
	draw_set_color(argument5);
	var s = argument6;

	draw_text_transformed(xx-off,yy,text,s,s,0); //right
	draw_text_transformed(xx,yy+off,text,s,s,0); //down

	draw_set_color(m_color);
	draw_text_transformed(xx,yy,text,s,s,0);


}
