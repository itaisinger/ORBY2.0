///@description 
colors = get_colors();
colors[array_length(colors)] = make_color_rgb(140,200,60);
colors[array_length(colors)] = make_color_rgb(160,100,10);
colors[array_length(colors)] = make_color_rgb(240,0,200);
colors[array_length(colors)] = make_color_rgb(255,255,255);
colors[array_length(colors)] = make_color_rgb(240,30,30);
my_color = colors[random(array_length(colors))]

xdest = 0;
ydest = 0;

walk_cd = 0;
r = 10;