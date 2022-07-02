function get_colors() {
	var arr = array_create(1,0);
	arr[COLORS.purple] = make_color_rgb(106,45,165);
	arr[COLORS.orange] = make_color_rgb(230,101,34);
	arr[COLORS.yellow] = make_color_rgb(255,244,50);
	arr[COLORS.blue]   = make_color_rgb(0,110,180);
	arr[COLORS.gray]   = make_color_rgb(100,100,100);
	arr[COLORS.pink]   = make_color_rgb(237,0,140)
	arr[COLORS.black]  = make_color_rgb(0,0,0);
	arr[COLORS.green]  = make_color_rgb(90,181,102);

	if(argument_count > 0)
		return arr[argument[0]];

	return arr;


}
