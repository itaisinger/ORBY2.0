///@description 
if(!active) exit;

draw_set_alpha(1);
draw_set_color(c_black);
with(obj_hazard) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
draw_set_color(c_gray);
with(obj_solid) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
draw_set_color(c_green);
with(obj_player) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
draw_set_color(c_red);
with(obj_player_dead) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
draw_set_color(c_blue);
with(obj_capital) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
with(obj_menu_text) draw_circle(xstart,ystart,3,0);
with(obj_menu_text) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
with(obj_orb) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
with(obj_lamp) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
with(obj_anvil_h) draw_text(x,y,hsp)
with(obj_camera) draw_text(look_x,look_y,"c");