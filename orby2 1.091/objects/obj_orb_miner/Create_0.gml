///@description 
colors = get_colors();
colors[array_length_1d(colors)] = make_color_rgb(140,200,60);
colors[array_length_1d(colors)] = make_color_rgb(160,100,10);
colors[array_length_1d(colors)] = make_color_rgb(240,0,200);
colors[array_length_1d(colors)] = make_color_rgb(255,255,255);
colors[array_length_1d(colors)] = make_color_rgb(240,30,30);
my_color = colors[random(array_length_1d(colors))]

xdest = 0;
ydest = 0;
parentx = 0;
parenty = 0;

parent = noone;
yoff =	 irandom_range(-74,-5);
xoff =	 irandom_range(-70,70);

walk_cd = 0;
r = 8;
alarm[0] = 100;