///@description 
index = -1; //indicates what cutscene is being played.

//general vars
draw_bars = 0;
done = 0;
stage = 0;

//start
wall_l = noone;
wall_r = noone;
wall_inst = noone;
spd = 0;

//fall
text_inst  = noone;
destroy = 0; //if true, going towards destroying self.
precent = 0; //used for drawing

//right click
trigger_spot = noone;

//anchor camera
ydest = 50;

//turnover
my_seq = -1;
turned_precent = 0

//kinghood
proceed = 0;
ost_index = OST.turn;

//trailer
text_inst2 = noone;
text_inst3 = noone;

//escape
escape_precent = 0;
escape_overlay_a = 0;
escape_sound = -1;