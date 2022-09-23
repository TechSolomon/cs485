// RobotArm.gdshader
// Solomon Himelbloom
// 2022-09-22
// CS 485 HW1: Godot Shaders

shader_type spatial;
render_mode unshaded;
varying vec3 highVisibility;

// "Guidelines For Robotics Safety" (1987)
// https://www.osha.gov/enforcement/directives/std-01-12-002

uniform float visibilityRepeats = 5.0; // stripes per meter
uniform vec4 safetyColor : hint_color;
uniform sampler2D jointDepth;

void vertex()
{
	highVisibility = (WORLD_MATRIX*vec4(VERTEX,1.0)).xyz;
}

void fragment()
{
	// Speaker Grill
	vec2 region = UV;
	vec3 import = texture(jointDepth,region).rgb;
		
	float alert=fract(highVisibility.x*visibilityRepeats*0.75);
	if (alert<0.5)
		ALBEDO = fract(highVisibility*0.5);
	else
		ALBEDO = (safetyColor.xyz*0.25);
}