bind_down  = ord("S");
bind_up    = ord("W");
bind_left  = ord("A");
bind_right = ord("D");
bind_jump  = vk_space;
bind_esc   = vk_escape;
bind_orb1  = mb_left;
bind_orb2  = mb_right;
//key_orb_down and up work different, cant get direct input for mouse wheel.

active = 1;
orb_active = 1;
jumped = 1; //used to reset the jumping buffer. defualt value is opposite of intuitive.
jump_with_up = 0;