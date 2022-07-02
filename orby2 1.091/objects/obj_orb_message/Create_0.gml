///@description 
queue = ds_list_create();
switch_cd = 60;

enum MESSAGES{
	activate,
	
	//normal
	no_platform_uses,
	high,
	disabled,
	idle1,
	idle2,
	idle3,
	idle4,
	idle5,
	idle_dark,
	stuck,
	keyboard,
	death1,
	death2,
	death3,
	death4,
	disruptor,
	disruptor_yellow,
	
	//special
	hello,
	where,
	deep,
	fall,
	fall2,
	fall3,
	switch_color,
	switch_color2,
	switch_color3,
	float_cancel,
	more_orbs,
	more_orbs2,
	drawings,
	deposit,
	yoshi,
	end_escape,
	end_turnover,
	end_kinghood,
	end_obedience,
	end_destruction,
	use_savepoint,
	load_savepoint,
	idle_start,
	turnover1,
	turnover2,
	
	//not in use
	savepoint_pickup,
	savepoint_used,
	savepoint_old,
}

//normal
messages_strs[MESSAGES.high] =			   "0040dont look down O_O'"
messages_strs[MESSAGES.disabled] =		   "0000out of uses ._."
messages_strs[MESSAGES.no_platform_uses] = "0100no platforms left!"
messages_strs[MESSAGES.idle1] =			   "9620zZzZz...-&-"
messages_strs[MESSAGES.idle2] =			   "7920mm mamamia..\nmmm pizza...\nmm lasagnia.."
messages_strs[MESSAGES.idle3] =			   "1920those anvils aren't gonna\n get up there on their own!"
messages_strs[MESSAGES.idle4] =			   "9920and for a minute there..\ni loost myseeelff"
messages_strs[MESSAGES.idle5] =			   "1920you can also change colors\nwith your keyboard"
messages_strs[MESSAGES.idle_dark] =		   "0320I can't see a thing >:("
messages_strs[MESSAGES.stuck] =		       "0180im stuck >:("
messages_strs[MESSAGES.keyboard] =		   "0000you can also change colors\nwith your keyboard"
messages_strs[MESSAGES.death1] =		   "0000X_X"
messages_strs[MESSAGES.death2] =		   "3000noooooooooo"
messages_strs[MESSAGES.death3] =		   "0000rip"
messages_strs[MESSAGES.death4] =		   "0000:V"
messages_strs[MESSAGES.disruptor] =		   "0000i can't\nuse that right now >:("
messages_strs[MESSAGES.disruptor_yellow] = "1150i think this lamp is broken -_-"

//special
messages_strs[MESSAGES.hello] =			   "0030hi there!"
messages_strs[MESSAGES.where] =			   "0020where are we going? o3o"
messages_strs[MESSAGES.savepoint_pickup] = "0020yummy ^-^"
messages_strs[MESSAGES.savepoint_used] =   "0040what is that? O_o";
messages_strs[MESSAGES.deep] =			   "0120that looks deep x_x'";
messages_strs[MESSAGES.fall] =			   "2000aaaaaaaaaa\naaaaaaaaaaaaaa\naaaaaaaaaaaaa";
messages_strs[MESSAGES.switch_color] =	   "2030try to press right click :-)";
messages_strs[MESSAGES.switch_color2] =	   "2040now scroll with\nyour mouse wheel :^)";
messages_strs[MESSAGES.switch_color3] =	   "2040use me with left click :>";
messages_strs[MESSAGES.float_cancel] =	   "0030psst.. try to jump again\nwhen floating -3-";
messages_strs[MESSAGES.more_orbs] =	       "0030hey what are all of those?";
messages_strs[MESSAGES.more_orbs2] =       "0000they look just like me! 0-0";
messages_strs[MESSAGES.drawings] =         "1030are those drawings?\ni wonder what they mean!";
messages_strs[MESSAGES.deposit] =          "0010energy deposited! =~=";
messages_strs[MESSAGES.yoshi] =		       "0100leave it behind!";
messages_strs[MESSAGES.end_escape] =	   "1060we did it!\nwe are free! \\_(*0*)_/"
messages_strs[MESSAGES.end_turnover] =	   "0060are we one of them now? 0~0"
messages_strs[MESSAGES.end_kinghood] =	   "0060kneel!"
messages_strs[MESSAGES.end_obedience] =	   "0060maybe we'll get\nminer of the month! *-*"
messages_strs[MESSAGES.end_destruction] =  "1060coup d'etat! ~(@O@)~"
messages_strs[MESSAGES.use_savepoint] =	   "2100maybe we can use the energy\ncubes for ourselves?"
messages_strs[MESSAGES.idle_start] =	   "0240I wonder what\nthat big button does?"
messages_strs[MESSAGES.turnover1] =		   "2000what is happening?? 0o0"
messages_strs[MESSAGES.turnover2] =		   "0000what happened to you?? @~@"

//not in use
messages_strs[MESSAGES.savepoint_old] =	   "1000you can also respawn at a old\nsavepoint from the pause screen.";
/*/
to send a message, do o.message_full = o.messages_strs[MESSAGES.x];
the first char in a message is type speed. (base is 2, the int is added on top)
the following 3 are delay before the message starts typing.
/*/
list_played_messages = ds_list_create();

//various
state_action_prev = 0;
disabled_prev = 0;
high_cd = 0;
last_r = 0;
death_r = -1;
keyboard_notice = 25;
mask_index = mask_pixel;
