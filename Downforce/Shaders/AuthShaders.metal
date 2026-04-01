//
//  AuthShaders.metal
//  Downforce
//
//  Created by Ayush Bhople on 26/03/26.
//

#include <metal_stdlib>
using namespace metal;


[[ stitchable ]] float2 wave(float2 pos, float time, float2 size) {
    float2 uv = pos / size;
    
    float strength = pow(uv.x, 1.5);
    
    float wave1 = sin((pos.x * 0.05) - (time * 5.0));
//    float wave2 = sin((pos.x * 0.09) - (time * 3.0));
    
    pos.y += (wave1) * strength * 8.0;
    return pos;
}


[[ stitchable ]] float2 heatDistortion(float2 pos, float time, float2 size) {
    float2 uv = pos / size;

    // Focus distortion more in center vertically
    float verticalFalloff = smoothstep(0.0, 0.3, uv.y) * (1.0 - smoothstep(0.7, 1.0, uv.y));
    
    // Stronger near exhaust (bottom area usually)
    float horizontalFalloff = smoothstep(0.2, 0.8, uv.x);

    float strength = verticalFalloff * horizontalFalloff;
//    float strength = horizontalFalloff;

    // Multi-frequency shimmer (important)
    float wave1 = sin(pos.y * 0.08 + time * 6.0);
    float wave2 = sin(pos.y * 0.15 + time * 4.0);
    float wave3 = sin(pos.y * 0.03 - time * 3.0);

    float distortion = (wave1 + wave2 * 0.5 + wave3 * 0.3);

    // Apply subtle horizontal distortion
    pos.x += distortion * strength * 1.5;

    return pos;
}
