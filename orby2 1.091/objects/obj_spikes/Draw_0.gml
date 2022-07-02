///@description

//shade
var lay_id = layer_get_id("Background");
var back_id = layer_background_get_id(lay_id);
var bg_col = layer_background_get_blend(back_id);
var rgb_sum = color_get_red(bg_col)+color_get_green(bg_col)+color_get_blue(bg_col);

if(rgb_sum > 500) and (image_index == 0)
{
	var shade = 170;
	var draw_col = make_color_rgb(shade,shade,shade);
	draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,draw_col,image_alpha);
}
else draw_self();

//image_index = is_pink;
//draw_text(x,y,string(image_angle)+"\n"+string(image_xscale)+","+string(image_yscale))