///@desc draw_text_outline()
///@arg0x
///@arg1y
///@arg2text
///@arg3outline_width
///@arg4outline_color
///@arg5scale
function draw_text_outline_ext(argument0, argument1, argument2, argument3, argument4, argument5) {

	var b_color = draw_get_color();
	var xx = argument0;
	var yy = argument1;
	var text = argument2;
	var w = argument3;
	draw_set_color(argument4);
	var s = argument5;

	draw_text_transformed(xx-w,yy,text,s,s,0); //left
	draw_text_transformed(xx+w,yy,text,s,s,0); //right
	draw_text_transformed(xx,yy-w,text,s,s,0); //up
	draw_text_transformed(xx,yy+w,text,s,s,0); //down

	draw_set_color(b_color);
	draw_text_transformed(xx,yy,text,s,s,0);


}
