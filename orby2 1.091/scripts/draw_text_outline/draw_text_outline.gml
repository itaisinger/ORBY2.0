///@desc draw_text_outline()
///@arg0x
///@arg1y
///@arg2text
///@arg3outline_width
///@arg4outline_color
function draw_text_outline(argument0, argument1, argument2, argument3, argument4) {

	var b_color = draw_get_color();
	var xx = argument0;
	var yy = argument1;
	var text = argument2;
	var w = argument3;
	draw_set_color(argument4);

	draw_text(xx-w,yy,text); //left
	draw_text(xx+w,yy,text); //right
	draw_text(xx,yy-w,text); //up
	draw_text(xx,yy+w,text); //down

	draw_set_color(b_color);
	draw_text(xx,yy,text);


}
