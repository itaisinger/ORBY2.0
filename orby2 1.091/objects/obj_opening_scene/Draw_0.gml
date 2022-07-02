///@description 
#region background

var w = camera_get_view_width(view_current);
var h = camera_get_view_height(view_current);

draw_set_alpha(image_alpha);
draw_set_color(c_black);
draw_rectangle(0,0, w,h,0);
draw_reset();

#endregion
#region texts

var _o_col = get_colors(COLORS.purple);
var _o_w  = 3;
var _cur  = animcurve_get(cur_open);
var _itai = animcurve_get_channel(_cur,0);
var _orby = animcurve_get_channel(_cur,1);
var _2    = animcurve_get_channel(_cur,2);

var _prec = progress_prec/progress_max;
var _itai_a = animcurve_channel_evaluate(_itai,_prec);
var _orby_a = animcurve_channel_evaluate(_orby,_prec);
var _2_a    = animcurve_channel_evaluate(_2,   _prec);
if(_prec > 0.9) _2_a = min(0.4,_orby_a);

//a game by itai singer
draw_set_all(c_white,font_menu,min(image_alpha,_itai_a),fa_center,fa_middle);
draw_text_outline(w/2,h/2,"a game by Itai Singer", _o_w, _o_col);

//orby
draw_set_alpha(min(image_alpha,_orby_a));
draw_text_outline(w/2-string_width("2")/2,h/2,"ORBY", _o_w, _o_col);

//2
draw_set_alpha(min(image_alpha,_2_a));
var _2y = h/2// - string_height("2")*(1-_2_off);
draw_text_outline(w/2+ string_width("ORBY ")/2,_2y,"2", _o_w, _o_col);

#endregion