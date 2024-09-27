shader_type canvas_item;

	float hash (float n)
	{ 
		return fract(sin(n)*43758.5453); 
	}

	float noise ( vec3 x ) 
	{ 
		vec3 p = floor(x);
		vec3 f = fract(x);
		f = f*f*(3.0-2.0*f);
		float n = p.x + p.y*57.0 + 113.0*p.z;
		return mix(mix(mix(hash(n+0.0 ),hash(n+1.0),f.x),mix(hash(n+57.0),hash(n+58.0),f.x),f.y),mix(mix(hash(n+113.0),hash(n+114.0),f.x),mix(hash(n+170.0),hash(n+171.0),f.x),f.y),f.z);
	}
	

	vec4 map( vec3 p )
	{
		float den = 0.2 - p.y;
		p = -7.0*p/dot(p,p);
		float co = cos(den - 0.25 * TIME);
		float si = sin(den - 0.25 * TIME);
		p.xz *= mat2(vec2(co,-si), vec2(si,co));
		float f;
		vec3 q = p - vec3(0.0,1.0,0.0) * TIME;
		f  = 0.50000 * noise( q ); q = q*2.02 - vec3(0.0,1.0,0.0)*TIME;
		f += 0.25000 * noise( q ); q = q*2.03 - vec3(0.0,1.0,0.0)*TIME;
		f += 0.12500 * noise( q ); q = q*2.01 - vec3(0.0,1.0,0.0)*TIME;
		f += 0.06250 * noise( q ); q = q*2.02 - vec3(0.0,1.0,0.0)*TIME;
		f += 0.03125 * noise( q );
		den = clamp( den + 4.0*f, 0.0, 1.0 );	
		vec3 col = mix( vec3(1.0,0.9,0.8), vec3(0.4,0.15,0.1), den ) + 0.05 * sin(p);	
		return vec4( col, den );
	}
	

	vec3 raymarch(vec3 ro, vec3 rd, vec2 pixel )
	{
		vec4 sum = vec4( 0.0 ,0.0,0.0,0.0);
		float t = 0.0;
		t+=0.05 * noise(vec3(pixel*sqrt(TIME), fract(TIME)));
		for( int i=0; i<100; i++ )
		{
			if( sum.a > 0.99 ) break;		
			vec3 pos = ro + t*rd;
			vec4 col = map( pos );		
			col.xyz *= mix( 3.1*vec3(1.0,0.5,0.05), vec3(0.48,0.53,0.5), clamp((pos.y-0.2)/2.0, 0.0, 1.0 ) );		
			col.a *= 0.6;
			col.rgb *= col.a;
			sum = sum + col*(1.0 - sum.a);	
			t += 0.05;
		}
		return clamp( sum.xyz, 0.0, 1.0 );
	}
	
void fragment() {

	vec2 q = UV;
	vec2 p = -1.0 + 2.0*q;
	vec2 mo = vec2(0.0,0.0);
	vec3 ro = 4.0*normalize(vec3(cos(3.0*mo.x), 1.4 - 1.0*(mo.y-.1), sin(3.0*mo.x)));
	vec3 ta = vec3(0.0,1.0,0.0);
	float cr = 0.5*cos(0.7*TIME);
	vec3 ww = normalize( ta - ro);
	vec3 uu = normalize(cross( vec3(sin(cr),cos(cr),0.0), ww ));
	vec3 vv = normalize(cross(ww,uu));
	vec3 rd = normalize( p.x*uu + p.y*vv + 2.0*ww );
	vec3 col = raymarch( ro, rd, FRAGCOORD.xy );
	col = col*0.5 + 0.5*col*col*(3.0-2.0*col);
	col *= 0.25 + 0.75*pow( 16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y), 0.1 );	
	COLOR = vec4( col, 1.0 );

}
