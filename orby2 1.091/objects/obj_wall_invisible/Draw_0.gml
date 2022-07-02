///@description 
draw_self();


//shine
shine_offset++;
if(shine_offset > sprite_width*2) shine_offset = -sprite_width*2;

var shine_w = 20;
var bottom_offset = 0;
var xmin = x+4;
var xmax = x+sprite_width-4

x1 = clamp(xmin,x+shine_offset,xmax);
x2 = clamp(xmin,x+shine_offset+shine_w,xmax);
x3 = clamp(xmin,x+shine_offset+bottom_offset,xmax);
x4 = clamp(xmin,x+shine_offset+bottom_offset+shine_w,xmax);

draw_set_alpha(image_alpha);
draw_set_color(shine_color);
draw_primitive_begin(pr_trianglestrip)

draw_vertex(x1,y+4);
draw_vertex(x2,y+4);

draw_vertex(x3,y+sprite_height-4);
draw_vertex(x4,y+sprite_height-4);

draw_primitive_end();
draw_reset();