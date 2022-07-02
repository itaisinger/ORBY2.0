///@description 
update_sprites();

x += draw_off;
draw_self();
draw_sprite_ext(eyeout_spr,0,x,y,image_xscale,image_yscale,0,c_white,1);
x -= draw_off;
draw_set_color(c_black);
