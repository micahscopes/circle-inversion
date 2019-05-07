#pragma glslify: import('./cga3/index.glsl')

CGA3 outer(CGA3 p, CGA3 q, CGA3 r, CGA3 s){
    return outer(outer(p,q,r),s);
}

CGA3 point(vec3 x){
    float y[3];
    y[0] = x[0];
    y[1] = x[1];
    y[2] = x[2];
    return point(injectOneBlade(zero(), y));
}

vec3 point_vec(CGA3 x) {
    x = point_coords(x);
    return vec3(x.e1, x.e2, x.e3);
}

CGA3 sphere(vec3 a, vec3 b, vec3 c, vec3 d) {
    return outer(point(a), point(b), point(c), point(d));
}

vec3 sphere_center(vec3 a, vec3 b, vec3 c, vec3 d){
    CGA3 sphere = sphere(a,b,c,d);
    return point_vec(mul(sphere, INF(), sphere));
}

// float sphere_radius(vec3 a, vec3 b, vec3 c, vec3 d){
//     CGA2 circ = sphere(a,b,c,d);
//     return circle_radius(circ);
// }
vec3 reflect_glsl(vec3 x, CGA3 R){
    return point_vec(mul(R,point(x),R));
}