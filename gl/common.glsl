#pragma glslify: import('./cga2/index.glsl')


CGA2 point(vec2 x){
    float y[2];
    y[0] = x[0];
    y[1] = x[1];
    return point(injectOneBlade(zero(), y));
}

vec2 point_vec(CGA2 x) {
    x = point_coords(x);
    return vec2(x.e1, x.e2);
}

CGA2 circle(vec2 a, vec2 b, vec2 c) {
    return outer(point(a), point(b), point(c));
}

vec2 circle_center(vec2 a, vec2 b, vec2 c){
    CGA2 circ = circle(a,b,c);
    return point_vec(mul(circ, INF(), circ));
}

float circle_radius(vec2 a, vec2 b, vec2 c){
    CGA2 circ = circle(a,b,c);
    return circle_radius(circ);
}
vec2 reflect_glsl(vec2 x, CGA2 R){
    return point_vec(mul(R,point(x),R));
}