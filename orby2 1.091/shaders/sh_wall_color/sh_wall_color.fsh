//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 base_color;
uniform vec3 my_color;

void main()
{
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord );
   // gl_FragColor = v_vColour;
	
	if(gl_FragColor.rgb == base_color.rgb)
		gl_FragColor.rgb = my_color.rgb;
}