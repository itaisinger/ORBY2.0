//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 base_color;
uniform vec3 my_color;
uniform vec3 wall_color;
uniform vec3 base_wall_color;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//loop through the 8 rgb values of the base array and compare the rgbs.
	//note that comparing .rgb value is like 3 different if statements.
	if(gl_FragColor.rgb == base_color.rgb)
		gl_FragColor.rgb = my_color.rgb;
		
	if(gl_FragColor.rgb == base_wall_color.rgb)
		gl_FragColor.rgb = wall_color.rgb;
}