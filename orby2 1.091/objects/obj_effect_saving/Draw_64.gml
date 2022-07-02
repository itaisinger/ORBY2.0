///@description 
var x1 = camera_get_view_x(view_current);
var y1 = camera_get_view_y(view_current);
var w = camera_get_view_width(view_current);
var h = camera_get_view_height(view_current);
var mx = 40;
var my = 20;

draw_sprite_ext(spr_spawn,0,x1+w-mx,y1+h-my,radius,radius,angle,c_white,1);

draw_set_all(c_white,font_ui,1,fa_left,fa_middle);
var xoff = -string_width(text_full)/2;
if(animation_finished)
{
	draw_set_halign(fa_right);
	xoff *= -1;
}

draw_text_outline(x1+w-mx+xoff,y1+h-my,text_current,1,c_black);