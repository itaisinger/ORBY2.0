///@description 
draw_set_font(font);
draw_set_valign(fa_left);
draw_set_halign(fa_top);
draw_set_alpha(image_alpha);
draw_set_color(color);
var margin = 10;
var w = (string_width(text)+margin*2)*scale;
var h = (string_height(text)+margin*2)*scale;

//draw outline
draw_set_color(outline_color);
draw_rectangle(x,y,x+w,y+h,0);

//draw base
draw_set_color(color);
draw_rectangle(x+outline_width,y+outline_width,x+w-outline_width,y+h-outline_width,0);


//draw text
draw_set_color(outline_color);
draw_text_transformed(x+margin*scale,y+margin*scale,text,scale,scale,0);

draw_set_color(c_red);
//draw_text(x+50,y,id)
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1)
draw_reset();