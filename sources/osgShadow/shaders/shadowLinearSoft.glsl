
// simulation of texture2Dshadow glsl call on HW
// http://codeflow.org/entries/2013/feb/15/soft-shadow-mapping/
float texture2DCompare(const in sampler2D depths, const in vec2 uv, const in float compare, const in vec4 clampDimension){

    float depth = getSingleFloatFromTex(depths, clamp(uv, clampDimension.xy, clampDimension.zw));
    return step(compare, depth);

}

// simulates linear fetch like texture2d shadow
float texture2DShadowLerp(const in sampler2D depths, const in vec4 size, const in vec2 uv, const in float compare, const in vec4 clampDimension){

    vec2 f = fract(uv*size.xy+0.5);
    vec2 centroidUV = floor(uv*size.xy+0.5)*size.zw;

    float lb = texture2DCompare(depths, centroidUV+size.zw*vec2(0.0, 0.0), compare, clampDimension);
    float lt = texture2DCompare(depths, centroidUV+size.zw*vec2(0.0, 1.0), compare, clampDimension);
    float rb = texture2DCompare(depths, centroidUV+size.zw*vec2(1.0, 0.0), compare, clampDimension);
    float rt = texture2DCompare(depths, centroidUV+size.zw*vec2(1.0, 1.0), compare, clampDimension);
    float a = mix(lb, lt, f.y);
    float b = mix(rb, rt, f.y);
    float c = mix(a, b, f.x);
    return c;

}
