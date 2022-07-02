function draw_glitched(sprite,image,_x,_y,xscale,yscale,alpha,intensity,rand){

//rand is a number between 0 and 8. the bigger it is the more random the output will be.
//intensity makes the reults more extreme.
var _seed = random_range(1-rand,1+rand);
var _cost = 0.06*_seed;
var _num = ceil(intensity/_cost);
var _base_off
var _intens = intensity*_seed;
var _sw = sprite_get_width(sprite);
var _sh = sprite_get_height(sprite);

var _xoff, _yoff, _xs, _ys, _xx, _yy;
var _base_xs = _sw;
var _base_ys = _sh;
var _base_off = 
//draw base sprite
draw_sprite_ext(sprite,image,_x,_y,xscale,yscale,0,c_white,alpha);

for(var i=0; i < _num; i++)
{
 	_xoff = _sw*choose(1,-1)*_intens/2*irandom_range(1-rand,1+rand)
	_yoff = _sh*choose(1,-1)*_intens/2*irandom_range(1-rand,1+rand)
	
	_xs = ceil(_base_xs*_intens*random_range(1-rand,1+rand));
	_ys = ceil(_base_ys*_intens*random_range(1-rand,1+rand));
	
	_xx = random(_sw-_xs);
	_yy = random(_sh-_ys);
	
	draw_sprite_part(sprite,image,_xx,_yy,_xs,_ys,x+_xx+_xoff,y+_yy+_yoff);
}

}