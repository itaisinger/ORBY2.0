function get_colors_background() {
	var arr = array_create(1,0);
	arr[COLORS.purple] = make_color_rgb(255,255,255);
	arr[COLORS.orange] = make_color_rgb(255,255,255);
	arr[COLORS.yellow] = make_color_rgb(30,30,30);
	arr[COLORS.blue]   = make_color_rgb(230,230,250);
	arr[COLORS.gray]   = make_color_rgb(255,255,255);
	arr[COLORS.black]  = make_color_rgb(255,255,255);
	arr[COLORS.pink]   = make_color_rgb(255,255,255);

	if(argument_count > 0)
		return arr[argument[0]];
	
	return arr;


}
