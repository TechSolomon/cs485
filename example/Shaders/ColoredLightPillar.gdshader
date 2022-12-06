// Solomon Himelbloom
// CS 485 (Final Project)
// Fairbanks Weather Phenomena

shader_type spatial;
render_mode cull_disabled;
render_mode unshaded;

void vertex() 
{
	
}

// Adapted from Dr. Lawlor's source code:
// https://github.com/olawlor/SpaceAssetsGodot/blob/main/Examples/Raytrace/Raytrace2_sphere_plane.gdshader


float ray_cylinder_intersection(vec3 C,vec3 D) {
	
	
	float h = clamp(sin(TIME * 0.1), 0.8, 0.9) * 50.0; // Height
	float r = 0.25; // Radius
	
	C.z -= 25.0;
	
	// Solve quadratic equation for intersection with cylinder.
	float a = dot(D,D) - dot(D,vec3(0,1,0))*dot(D,vec3(0,1,0));
	float b = 2.0*(dot(D,C) - dot(D,vec3(0,1,0))*dot(C,vec3(0,1,0)));
	float c = dot(C,C) - dot(C,vec3(0,1,0))*dot(C,vec3(0,1,0)) - r*r;

	float disc = b*b - 4.0*a*c;
	if (disc<0.0) return -1.0; // No intersection.
	float t = (-b - sqrt(disc))/(2.0*a);

	// Check if intersection is within cylinder.
	vec3 world = C + t*D;

	if (abs(world.y)>h) return -1.0; // No intersection.
	return t;
}

void fragment() {

	vec3 world=(CAMERA_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 camera=CAMERA_MATRIX[3].xyz;
	vec3 C = camera, D = world-camera;
	
	float tCylinder = ray_cylinder_intersection(C,D);
	
	float t=1.0e9;
	if (tCylinder>0.0) t=tCylinder;
	if (t>0.9e9) discard;
	
	vec3 worldHit = C + t * D;
	vec3 worldNormal = normalize(worldHit); 
	
	vec3 toLight=normalize(vec3(0,1,0.5));
	float light = dot(worldNormal,toLight);
	if (light<0.0) light=0.0;
	light+=0.01;
	
	vec3 toCamera = normalize(-D);
	vec3 halfway = normalize(0.5*toCamera+0.5*toLight);
	if (dot(halfway,worldNormal)>0.98) light=10.0;

	// Lower opacity at the top and bottom of the cylinder.

	float opacity = 1.0;

	if (worldHit.y > 25.0) {
		opacity = 1.0 - (worldHit.y - 25.0) / 25.0;
	} else if (worldHit.y < -25.0) {
		opacity = 1.0 + (worldHit.y + 25.0) / 25.0;
	}
	
	// TODO: Smooth various aspects of the cylinder edges.
	
	ALPHA = opacity + (worldHit.y - 25.0) / 25.0;

	ALBEDO = vec3(0.5,0.9*light,0.9)*light;
}
