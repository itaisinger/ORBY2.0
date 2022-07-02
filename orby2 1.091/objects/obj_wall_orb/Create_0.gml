///@description 
depth = DEPTH.wall_orb;

//////////////////////////////////
//                              //
//   bktGlitch 1.3.2            //
//    Written by Jan Vorisek    //
//     @blokatt | blokatt.net   //
//      jan@blokatt.net         //
//       31/01/2021             //
//                              //
//     "Here we go again."      //
//							 	//
//////////////////////////////////

// You can init the shader here manually if you want, otherwise it will be done automatically the first
// time you run bktglitch_activate(), which might take a few frames.
bktglitch_init()
alarm[0] = 10;
_rand = 0;
rand = random_range(0.8,1.2);

function high(){

bktglitch_set_intensity(0.833333);
bktglitch_set_line_shift(0.000000);
bktglitch_set_line_speed(0.000000);
bktglitch_set_line_resolution(0.000000);
bktglitch_set_line_drift(0.000000);
bktglitch_set_line_vertical_shift(0.000000);
bktglitch_set_noise_level(0.000000);
bktglitch_set_jumbleness(rand*0.286667);
bktglitch_set_jumble_speed(rand*2.500000);
bktglitch_set_jumble_resolution(rand*0.513333);
bktglitch_set_jumble_shift(rand*0.0300000);
bktglitch_set_channel_shift(0.00000);
bktglitch_set_channel_dispersion(0.001000);
bktglitch_set_shakiness(0.000000);
bktglitch_set_rng_seed(random(1));
}

