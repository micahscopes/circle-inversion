#pragma glslify: import('./cga2/index.glsl')

CGA2 point(vec2 x){
    float y[2];
    y[0] = x[0];
    y[1] = x[1];
    return point(injectOneBlade(zero(), y));
}

vec2 point_vec(CGA2 x) {
    return vec2(x.e1, x.e2);
}

CGA2 circle(vec2 a, vec2 b, vec2 c) {
    CGA2 circ = outer(outer(point(a), point(b)), point(c));
    CGA2 att = inner(INF(), circ);
    circ = mul(1.0/2.0/mul(att, att).scalar, circ);
    return circ;
}

vec2 reflect(vec2 x, CGA2 R){
    return point_vec(mul(mul(R,point(x)),R));
}