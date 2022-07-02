///@description 
draw_set_color(color);
draw_set_font(font);
draw_set_valign(valign);
draw_set_halign(halign);
draw_set_alpha(image_alpha);

if(outline_color == -1 or outline_color == color)
	draw_text_transformed(x,y,text,scale,scale,0);
else
{	
	if(!outline_double)
		draw_text_outline_ext(x,y,text,outline_width,outline_color,scale);
	else
		draw_text_double_ext(x,y,text,outline_width,color,outline_color,scale);
}
draw_reset();