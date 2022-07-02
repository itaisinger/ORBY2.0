///@description 
draw_set_font(font);
draw_set_valign(valign);
draw_set_halign(halign);
draw_set_alpha(image_alpha);
draw_set_color(color);
if(color != outline_color)
	draw_text_outline_ext(x,y,text,floor(3*scale),outline_color,scale+scale_add);
else
	draw_text_transformed(x,y,text,scale+scale_add,scale+scale_add,0);
	
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_reset();