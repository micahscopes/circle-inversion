precision mediump float;
#define GLSLIFY 1
attribute vec2 position;
uniform float viewportRatio;
uniform float scale;
uniform float pointSize;

// CGA2.glsl
const int I_CGA2_scalar = 0;
const int I_CGA2_e1 = 1;
const int I_CGA2_e2 = 2;
const int I_CGA2_enil = 3;
const int I_CGA2_einf = 4;
const int I_CGA2_e12 = 5;
const int I_CGA2_e1nil = 6;
const int I_CGA2_e1inf = 7;
const int I_CGA2_e2nil = 8;
const int I_CGA2_e2inf = 9;
const int I_CGA2_enilinf = 10;
const int I_CGA2_e12nil = 11;
const int I_CGA2_e12inf = 12;
const int I_CGA2_e1nilinf = 13;
const int I_CGA2_e2nilinf = 14;
const int I_CGA2_e12nilinf = 15;

struct CGA2 {
    float scalar;
    float e1;
    float e2;
    float enil;
    float einf;
    float e12;
    float e1nil;
    float e1inf;
    float e2nil;
    float e2inf;
    float enilinf;
    float e12nil;
    float e12inf;
    float e1nilinf;
    float e2nilinf;
    float e12nilinf;
};

CGA2 fromArray(float x[16]){
    return CGA2(x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15]);
}

void toArray(CGA2 x, inout float x_ary[16]){
    x_ary[0] = x.scalar;
    x_ary[1] = x.e1;
    x_ary[2] = x.e2;
    x_ary[3] = x.enil;
    x_ary[4] = x.einf;
    x_ary[5] = x.e12;
    x_ary[6] = x.e1nil;
    x_ary[7] = x.e1inf;
    x_ary[8] = x.e2nil;
    x_ary[9] = x.e2inf;
    x_ary[10] = x.enilinf;
    x_ary[11] = x.e12nil;
    x_ary[12] = x.e12inf;
    x_ary[13] = x.e1nilinf;
    x_ary[14] = x.e2nilinf;
    x_ary[15] = x.e12nilinf;
}

void zero(inout float x[16]){
    x[0] = 0.0;
    x[1] = 0.0;
    x[2] = 0.0;
    x[3] = 0.0;
    x[4] = 0.0;
    x[5] = 0.0;
    x[6] = 0.0;
    x[7] = 0.0;
    x[8] = 0.0;
    x[9] = 0.0;
    x[10] = 0.0;
    x[11] = 0.0;
    x[12] = 0.0;
    x[13] = 0.0;
    x[14] = 0.0;
    x[15] = 0.0;
}

CGA2 add(CGA2 u, CGA2 v){
    return CGA2(u.scalar + v.scalar, u.e1 + v.e1, u.e2 + v.e2, u.enil + v.enil, u.einf + v.einf, u.e12 + v.e12, u.e1nil + v.e1nil, u.e1inf + v.e1inf, u.e2nil + v.e2nil, u.e2inf + v.e2inf, u.enilinf + v.enilinf, u.e12nil + v.e12nil, u.e12inf + v.e12inf, u.e1nilinf + v.e1nilinf, u.e2nilinf + v.e2nilinf, u.e12nilinf + v.e12nilinf);
}

CGA2 one(){
    return CGA2(1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

CGA2 sub(CGA2 u, CGA2 v){
    return CGA2(u.scalar - v.scalar, u.e1 - v.e1, u.e2 - v.e2, u.enil - v.enil, u.einf - v.einf, u.e12 - v.e12, u.e1nil - v.e1nil, u.e1inf - v.e1inf, u.e2nil - v.e2nil, u.e2inf - v.e2inf, u.enilinf - v.enilinf, u.e12nil - v.e12nil, u.e12inf - v.e12inf, u.e1nilinf - v.e1nilinf, u.e2nilinf - v.e2nilinf, u.e12nilinf - v.e12nilinf);
}

CGA2 zero(){
    return CGA2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

CGA2 mul(float a, CGA2 x){
    return CGA2(a*x.scalar, a*x.e1, a*x.e2, a*x.enil, a*x.einf, a*x.e12, a*x.e1nil, a*x.e1inf, a*x.e2nil, a*x.e2inf, a*x.enilinf, a*x.e12nil, a*x.e12inf, a*x.e1nilinf, a*x.e2nilinf, a*x.e12nilinf);
}

CGA2 mul(CGA2 u, CGA2 v){
    return CGA2(u.e1*v.e1 - u.e12*v.e12 + u.e12inf*v.e12nil + u.e12nil*v.e12inf - u.e12nilinf*v.e12nilinf + u.e1inf*v.e1nil + u.e1nil*v.e1inf + u.e1nilinf*v.e1nilinf + u.e2*v.e2 + u.e2inf*v.e2nil + u.e2nil*v.e2inf + u.e2nilinf*v.e2nilinf - u.einf*v.enil - u.enil*v.einf + u.enilinf*v.enilinf + u.scalar*v.scalar, u.e1*v.scalar + u.e12*v.e2 + u.e12inf*v.e2nil + u.e12nil*v.e2inf + u.e12nilinf*v.e2nilinf - u.e1inf*v.enil - u.e1nil*v.einf + u.e1nilinf*v.enilinf - u.e2*v.e12 + u.e2inf*v.e12nil + u.e2nil*v.e12inf - u.e2nilinf*v.e12nilinf + u.einf*v.e1nil + u.enil*v.e1inf + u.enilinf*v.e1nilinf + u.scalar*v.e1, u.e1*v.e12 - u.e12*v.e1 - u.e12inf*v.e1nil - u.e12nil*v.e1inf - u.e12nilinf*v.e1nilinf - u.e1inf*v.e12nil - u.e1nil*v.e12inf + u.e1nilinf*v.e12nilinf + u.e2*v.scalar - u.e2inf*v.enil - u.e2nil*v.einf + u.e2nilinf*v.enilinf + u.einf*v.e2nil + u.enil*v.e2inf + u.enilinf*v.e2nilinf + u.scalar*v.e2, u.e1*v.e1nil - u.e12*v.e12nil - u.e12nil*v.e12 - u.e12nil*v.e12nilinf + u.e12nilinf*v.e12nil - u.e1nil*v.e1 - u.e1nil*v.e1nilinf - u.e1nilinf*v.e1nil + u.e2*v.e2nil - u.e2nil*v.e2 - u.e2nil*v.e2nilinf - u.e2nilinf*v.e2nil + u.enil*v.enilinf + u.enil*v.scalar - u.enilinf*v.enil + u.scalar*v.enil, u.e1*v.e1inf - u.e12*v.e12inf - u.e12inf*v.e12 + u.e12inf*v.e12nilinf - u.e12nilinf*v.e12inf - u.e1inf*v.e1 + u.e1inf*v.e1nilinf + u.e1nilinf*v.e1inf + u.e2*v.e2inf - u.e2inf*v.e2 + u.e2inf*v.e2nilinf + u.e2nilinf*v.e2inf - u.einf*v.enilinf + u.einf*v.scalar + u.enilinf*v.einf + u.scalar*v.einf, u.e1*v.e2 + u.e12*v.scalar - u.e12inf*v.enil - u.e12nil*v.einf + u.e12nilinf*v.enilinf + u.e1inf*v.e2nil + u.e1nil*v.e2inf + u.e1nilinf*v.e2nilinf - u.e2*v.e1 - u.e2inf*v.e1nil - u.e2nil*v.e1inf - u.e2nilinf*v.e1nilinf - u.einf*v.e12nil - u.enil*v.e12inf + u.enilinf*v.e12nilinf + u.scalar*v.e12, u.e1*v.enil + u.e12*v.e2nil - u.e12nil*v.e2 - u.e12nil*v.e2nilinf - u.e12nilinf*v.e2nil + u.e1nil*v.enilinf + u.e1nil*v.scalar - u.e1nilinf*v.enil - u.e2*v.e12nil - u.e2nil*v.e12 - u.e2nil*v.e12nilinf + u.e2nilinf*v.e12nil - u.enil*v.e1 - u.enil*v.e1nilinf - u.enilinf*v.e1nil + u.scalar*v.e1nil, u.e1*v.einf + u.e12*v.e2inf - u.e12inf*v.e2 + u.e12inf*v.e2nilinf + u.e12nilinf*v.e2inf - u.e1inf*v.enilinf + u.e1inf*v.scalar + u.e1nilinf*v.einf - u.e2*v.e12inf - u.e2inf*v.e12 + u.e2inf*v.e12nilinf - u.e2nilinf*v.e12inf - u.einf*v.e1 + u.einf*v.e1nilinf + u.enilinf*v.e1inf + u.scalar*v.e1inf, u.e1*v.e12nil - u.e12*v.e1nil + u.e12nil*v.e1 + u.e12nil*v.e1nilinf + u.e12nilinf*v.e1nil + u.e1nil*v.e12 + u.e1nil*v.e12nilinf - u.e1nilinf*v.e12nil + u.e2*v.enil + u.e2nil*v.enilinf + u.e2nil*v.scalar - u.e2nilinf*v.enil - u.enil*v.e2 - u.enil*v.e2nilinf - u.enilinf*v.e2nil + u.scalar*v.e2nil, u.e1*v.e12inf - u.e12*v.e1inf + u.e12inf*v.e1 - u.e12inf*v.e1nilinf - u.e12nilinf*v.e1inf + u.e1inf*v.e12 - u.e1inf*v.e12nilinf + u.e1nilinf*v.e12inf + u.e2*v.einf - u.e2inf*v.enilinf + u.e2inf*v.scalar + u.e2nilinf*v.einf - u.einf*v.e2 + u.einf*v.e2nilinf + u.enilinf*v.e2inf + u.scalar*v.e2inf, u.e1*v.e1nilinf - u.e12*v.e12nilinf + u.e12inf*v.e12nil - u.e12nil*v.e12inf - u.e12nilinf*v.e12 + u.e1inf*v.e1nil - u.e1nil*v.e1inf + u.e1nilinf*v.e1 + u.e2*v.e2nilinf + u.e2inf*v.e2nil - u.e2nil*v.e2inf + u.e2nilinf*v.e2 - u.einf*v.enil + u.enil*v.einf + u.enilinf*v.scalar + u.scalar*v.enilinf, u.e1*v.e2nil + u.e12*v.enil + u.e12nil*v.enilinf + u.e12nil*v.scalar - u.e12nilinf*v.enil - u.e1nil*v.e2 - u.e1nil*v.e2nilinf - u.e1nilinf*v.e2nil - u.e2*v.e1nil + u.e2nil*v.e1 + u.e2nil*v.e1nilinf + u.e2nilinf*v.e1nil + u.enil*v.e12 + u.enil*v.e12nilinf - u.enilinf*v.e12nil + u.scalar*v.e12nil, u.e1*v.e2inf + u.e12*v.einf - u.e12inf*v.enilinf + u.e12inf*v.scalar + u.e12nilinf*v.einf - u.e1inf*v.e2 + u.e1inf*v.e2nilinf + u.e1nilinf*v.e2inf - u.e2*v.e1inf + u.e2inf*v.e1 - u.e2inf*v.e1nilinf - u.e2nilinf*v.e1inf + u.einf*v.e12 - u.einf*v.e12nilinf + u.enilinf*v.e12inf + u.scalar*v.e12inf, u.e1*v.enilinf + u.e12*v.e2nilinf + u.e12inf*v.e2nil - u.e12nil*v.e2inf + u.e12nilinf*v.e2 - u.e1inf*v.enil + u.e1nil*v.einf + u.e1nilinf*v.scalar - u.e2*v.e12nilinf + u.e2inf*v.e12nil - u.e2nil*v.e12inf - u.e2nilinf*v.e12 + u.einf*v.e1nil - u.enil*v.e1inf + u.enilinf*v.e1 + u.scalar*v.e1nilinf, u.e1*v.e12nilinf - u.e12*v.e1nilinf - u.e12inf*v.e1nil + u.e12nil*v.e1inf - u.e12nilinf*v.e1 - u.e1inf*v.e12nil + u.e1nil*v.e12inf + u.e1nilinf*v.e12 + u.e2*v.enilinf - u.e2inf*v.enil + u.e2nil*v.einf + u.e2nilinf*v.scalar + u.einf*v.e2nil - u.enil*v.e2inf + u.enilinf*v.e2 + u.scalar*v.e2nilinf, u.e1*v.e2nilinf + u.e12*v.enilinf - u.e12inf*v.enil + u.e12nil*v.einf + u.e12nilinf*v.scalar + u.e1inf*v.e2nil - u.e1nil*v.e2inf + u.e1nilinf*v.e2 - u.e2*v.e1nilinf - u.e2inf*v.e1nil + u.e2nil*v.e1inf - u.e2nilinf*v.e1 - u.einf*v.e12nil + u.enil*v.e12inf + u.enilinf*v.e12 + u.scalar*v.e12nilinf);
}

CGA2 mul(int a, CGA2 x){
    return mul(float(a), x);
}

CGA2 dual(CGA2 u){
    return CGA2(u.e12nilinf, u.e2nilinf, -u.e1nilinf, u.e12nil, -u.e12inf, -u.enilinf, u.e2nil, -u.e2inf, -u.e1nil, u.e1inf, u.e12, -u.enil, u.einf, u.e2, -u.e1, -u.scalar);
}

CGA2 involve(CGA2 u){
    return CGA2(u.scalar, -u.e1, -u.e2, -u.enil, -u.einf, u.e12, u.e1nil, u.e1inf, u.e2nil, u.e2inf, u.enilinf, -u.e12nil, -u.e12inf, -u.e1nilinf, -u.e2nilinf, u.e12nilinf);
}

CGA2 inner(CGA2 u, CGA2 v){
    return CGA2(u.e1*v.e1 - u.e12*v.e12 + u.e12inf*v.e12nil + u.e12nil*v.e12inf - u.e12nilinf*v.e12nilinf + u.e1inf*v.e1nil + u.e1nil*v.e1inf + u.e1nilinf*v.e1nilinf + u.e2*v.e2 + u.e2inf*v.e2nil + u.e2nil*v.e2inf + u.e2nilinf*v.e2nilinf - u.einf*v.enil - u.enil*v.einf + u.enilinf*v.enilinf, u.e12*v.e2 + u.e12inf*v.e2nil + u.e12nil*v.e2inf + u.e12nilinf*v.e2nilinf - u.e1inf*v.enil - u.e1nil*v.einf + u.e1nilinf*v.enilinf - u.e2*v.e12 + u.e2inf*v.e12nil + u.e2nil*v.e12inf - u.e2nilinf*v.e12nilinf + u.einf*v.e1nil + u.enil*v.e1inf + u.enilinf*v.e1nilinf, u.e1*v.e12 - u.e12*v.e1 - u.e12inf*v.e1nil - u.e12nil*v.e1inf - u.e12nilinf*v.e1nilinf - u.e1inf*v.e12nil - u.e1nil*v.e12inf + u.e1nilinf*v.e12nilinf - u.e2inf*v.enil - u.e2nil*v.einf + u.e2nilinf*v.enilinf + u.einf*v.e2nil + u.enil*v.e2inf + u.enilinf*v.e2nilinf, u.e1*v.e1nil - u.e12*v.e12nil - u.e12nil*v.e12 - u.e12nil*v.e12nilinf + u.e12nilinf*v.e12nil - u.e1nil*v.e1 - u.e1nil*v.e1nilinf - u.e1nilinf*v.e1nil + u.e2*v.e2nil - u.e2nil*v.e2 - u.e2nil*v.e2nilinf - u.e2nilinf*v.e2nil + u.enil*v.enilinf - u.enilinf*v.enil, u.e1*v.e1inf - u.e12*v.e12inf - u.e12inf*v.e12 + u.e12inf*v.e12nilinf - u.e12nilinf*v.e12inf - u.e1inf*v.e1 + u.e1inf*v.e1nilinf + u.e1nilinf*v.e1inf + u.e2*v.e2inf - u.e2inf*v.e2 + u.e2inf*v.e2nilinf + u.e2nilinf*v.e2inf - u.einf*v.enilinf + u.enilinf*v.einf, -u.e12inf*v.enil - u.e12nil*v.einf + u.e12nilinf*v.enilinf - u.einf*v.e12nil - u.enil*v.e12inf + u.enilinf*v.e12nilinf, -u.e12nil*v.e2 - u.e12nilinf*v.e2nil - u.e1nilinf*v.enil - u.e2*v.e12nil - u.e2nil*v.e12nilinf - u.enil*v.e1nilinf, -u.e12inf*v.e2 + u.e12nilinf*v.e2inf + u.e1nilinf*v.einf - u.e2*v.e12inf + u.e2inf*v.e12nilinf + u.einf*v.e1nilinf, u.e1*v.e12nil + u.e12nil*v.e1 + u.e12nilinf*v.e1nil + u.e1nil*v.e12nilinf - u.e2nilinf*v.enil - u.enil*v.e2nilinf, u.e1*v.e12inf + u.e12inf*v.e1 - u.e12nilinf*v.e1inf - u.e1inf*v.e12nilinf + u.e2nilinf*v.einf + u.einf*v.e2nilinf, u.e1*v.e1nilinf - u.e12*v.e12nilinf - u.e12nilinf*v.e12 + u.e1nilinf*v.e1 + u.e2*v.e2nilinf + u.e2nilinf*v.e2, -u.e12nilinf*v.enil + u.enil*v.e12nilinf, u.e12nilinf*v.einf - u.einf*v.e12nilinf, u.e12nilinf*v.e2 - u.e2*v.e12nilinf, u.e1*v.e12nilinf - u.e12nilinf*v.e1, 0.0);
}

CGA2 lcontract(CGA2 u, CGA2 v){
    return CGA2(u.e1*v.e1 - u.e12*v.e12 + u.e12inf*v.e12nil + u.e12nil*v.e12inf - u.e12nilinf*v.e12nilinf + u.e1inf*v.e1nil + u.e1nil*v.e1inf + u.e1nilinf*v.e1nilinf + u.e2*v.e2 + u.e2inf*v.e2nil + u.e2nil*v.e2inf + u.e2nilinf*v.e2nilinf - u.einf*v.enil - u.enil*v.einf + u.enilinf*v.enilinf + u.scalar*v.scalar, -u.e2*v.e12 + u.e2inf*v.e12nil + u.e2nil*v.e12inf - u.e2nilinf*v.e12nilinf + u.einf*v.e1nil + u.enil*v.e1inf + u.enilinf*v.e1nilinf + u.scalar*v.e1, u.e1*v.e12 - u.e1inf*v.e12nil - u.e1nil*v.e12inf + u.e1nilinf*v.e12nilinf + u.einf*v.e2nil + u.enil*v.e2inf + u.enilinf*v.e2nilinf + u.scalar*v.e2, u.e1*v.e1nil - u.e12*v.e12nil - u.e12nil*v.e12nilinf - u.e1nil*v.e1nilinf + u.e2*v.e2nil - u.e2nil*v.e2nilinf + u.enil*v.enilinf + u.scalar*v.enil, u.e1*v.e1inf - u.e12*v.e12inf + u.e12inf*v.e12nilinf + u.e1inf*v.e1nilinf + u.e2*v.e2inf + u.e2inf*v.e2nilinf - u.einf*v.enilinf + u.scalar*v.einf, -u.einf*v.e12nil - u.enil*v.e12inf + u.enilinf*v.e12nilinf + u.scalar*v.e12, -u.e2*v.e12nil - u.e2nil*v.e12nilinf - u.enil*v.e1nilinf + u.scalar*v.e1nil, -u.e2*v.e12inf + u.e2inf*v.e12nilinf + u.einf*v.e1nilinf + u.scalar*v.e1inf, u.e1*v.e12nil + u.e1nil*v.e12nilinf - u.enil*v.e2nilinf + u.scalar*v.e2nil, u.e1*v.e12inf - u.e1inf*v.e12nilinf + u.einf*v.e2nilinf + u.scalar*v.e2inf, u.e1*v.e1nilinf - u.e12*v.e12nilinf + u.e2*v.e2nilinf + u.scalar*v.enilinf, u.enil*v.e12nilinf + u.scalar*v.e12nil, -u.einf*v.e12nilinf + u.scalar*v.e12inf, -u.e2*v.e12nilinf + u.scalar*v.e1nilinf, u.e1*v.e12nilinf + u.scalar*v.e2nilinf, u.scalar*v.e12nilinf);
}

CGA2 outer(CGA2 u, CGA2 v){
    return CGA2(u.scalar*v.scalar, u.e1*v.scalar + u.scalar*v.e1, u.e2*v.scalar + u.scalar*v.e2, u.enil*v.scalar + u.scalar*v.enil, u.einf*v.scalar + u.scalar*v.einf, u.e1*v.e2 + u.e12*v.scalar - u.e2*v.e1 + u.scalar*v.e12, u.e1*v.enil + u.e1nil*v.scalar - u.enil*v.e1 + u.scalar*v.e1nil, u.e1*v.einf + u.e1inf*v.scalar - u.einf*v.e1 + u.scalar*v.e1inf, u.e2*v.enil + u.e2nil*v.scalar - u.enil*v.e2 + u.scalar*v.e2nil, u.e2*v.einf + u.e2inf*v.scalar - u.einf*v.e2 + u.scalar*v.e2inf, -u.einf*v.enil + u.enil*v.einf + u.enilinf*v.scalar + u.scalar*v.enilinf, u.e1*v.e2nil + u.e12*v.enil + u.e12nil*v.scalar - u.e1nil*v.e2 - u.e2*v.e1nil + u.e2nil*v.e1 + u.enil*v.e12 + u.scalar*v.e12nil, u.e1*v.e2inf + u.e12*v.einf + u.e12inf*v.scalar - u.e1inf*v.e2 - u.e2*v.e1inf + u.e2inf*v.e1 + u.einf*v.e12 + u.scalar*v.e12inf, u.e1*v.enilinf - u.e1inf*v.enil + u.e1nil*v.einf + u.e1nilinf*v.scalar + u.einf*v.e1nil - u.enil*v.e1inf + u.enilinf*v.e1 + u.scalar*v.e1nilinf, u.e2*v.enilinf - u.e2inf*v.enil + u.e2nil*v.einf + u.e2nilinf*v.scalar + u.einf*v.e2nil - u.enil*v.e2inf + u.enilinf*v.e2 + u.scalar*v.e2nilinf, u.e1*v.e2nilinf + u.e12*v.enilinf - u.e12inf*v.enil + u.e12nil*v.einf + u.e12nilinf*v.scalar + u.e1inf*v.e2nil - u.e1nil*v.e2inf + u.e1nilinf*v.e2 - u.e2*v.e1nilinf - u.e2inf*v.e1nil + u.e2nil*v.e1inf - u.e2nilinf*v.e1 - u.einf*v.e12nil + u.enil*v.e12inf + u.enilinf*v.e12 + u.scalar*v.e12nilinf);
}

CGA2 I(){
    return CGA2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
}

CGA2 rcontract(CGA2 u, CGA2 v){
    return CGA2(u.e1*v.e1 - u.e12*v.e12 + u.e12inf*v.e12nil + u.e12nil*v.e12inf - u.e12nilinf*v.e12nilinf + u.e1inf*v.e1nil + u.e1nil*v.e1inf + u.e1nilinf*v.e1nilinf + u.e2*v.e2 + u.e2inf*v.e2nil + u.e2nil*v.e2inf + u.e2nilinf*v.e2nilinf - u.einf*v.enil - u.enil*v.einf + u.enilinf*v.enilinf + u.scalar*v.scalar, u.e1*v.scalar + u.e12*v.e2 + u.e12inf*v.e2nil + u.e12nil*v.e2inf + u.e12nilinf*v.e2nilinf - u.e1inf*v.enil - u.e1nil*v.einf + u.e1nilinf*v.enilinf, -u.e12*v.e1 - u.e12inf*v.e1nil - u.e12nil*v.e1inf - u.e12nilinf*v.e1nilinf + u.e2*v.scalar - u.e2inf*v.enil - u.e2nil*v.einf + u.e2nilinf*v.enilinf, -u.e12nil*v.e12 + u.e12nilinf*v.e12nil - u.e1nil*v.e1 - u.e1nilinf*v.e1nil - u.e2nil*v.e2 - u.e2nilinf*v.e2nil + u.enil*v.scalar - u.enilinf*v.enil, -u.e12inf*v.e12 - u.e12nilinf*v.e12inf - u.e1inf*v.e1 + u.e1nilinf*v.e1inf - u.e2inf*v.e2 + u.e2nilinf*v.e2inf + u.einf*v.scalar + u.enilinf*v.einf, u.e12*v.scalar - u.e12inf*v.enil - u.e12nil*v.einf + u.e12nilinf*v.enilinf, -u.e12nil*v.e2 - u.e12nilinf*v.e2nil + u.e1nil*v.scalar - u.e1nilinf*v.enil, -u.e12inf*v.e2 + u.e12nilinf*v.e2inf + u.e1inf*v.scalar + u.e1nilinf*v.einf, u.e12nil*v.e1 + u.e12nilinf*v.e1nil + u.e2nil*v.scalar - u.e2nilinf*v.enil, u.e12inf*v.e1 - u.e12nilinf*v.e1inf + u.e2inf*v.scalar + u.e2nilinf*v.einf, -u.e12nilinf*v.e12 + u.e1nilinf*v.e1 + u.e2nilinf*v.e2 + u.enilinf*v.scalar, u.e12nil*v.scalar - u.e12nilinf*v.enil, u.e12inf*v.scalar + u.e12nilinf*v.einf, u.e12nilinf*v.e2 + u.e1nilinf*v.scalar, -u.e12nilinf*v.e1 + u.e2nilinf*v.scalar, u.e12nilinf*v.scalar);
}

CGA2 reverse(CGA2 u){
    return CGA2(u.scalar, u.e1, u.e2, u.enil, u.einf, -u.e12, -u.e1nil, -u.e1inf, -u.e2nil, -u.e2inf, -u.enilinf, -u.e12nil, -u.e12inf, -u.e1nilinf, -u.e2nilinf, u.e12nilinf);
}

CGA2 conjugate(CGA2 u){
    return reverse(involve(u));
}

CGA2 INF(){
    return CGA2(0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

CGA2 MNK(){
    return CGA2(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

CGA2 NIL(){
    return CGA2(0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

CGA2 point(CGA2 u){
    return CGA2(u.e12*u.e12nil + u.e1nil*u.e1nilinf + u.e2nil*u.e2nilinf + u.scalar, u.e1 + u.e12nil*u.e2 + u.e12nilinf*u.e2nil + u.e1nilinf*u.enil, -u.e1*u.e12nil - u.e12nilinf*u.e1nil + u.e2 + u.e2nilinf*u.enil, u.enil + 1.0, 0.5*pow(u.e1, 2.0) + u.e1*u.e1nilinf - 0.5*pow(u.e12, 2.0) - u.e12*u.e12nilinf + u.e12inf*u.e12nil - 0.5*pow(u.e12nilinf, 2.0) + u.e1inf*u.e1nil + 0.5*pow(u.e1nilinf, 2.0) + 0.5*pow(u.e2, 2.0) + u.e2*u.e2nilinf + u.e2inf*u.e2nil + 0.5*pow(u.e2nilinf, 2.0) - u.einf*u.enil + u.einf + 0.5*pow(u.enilinf, 2.0), u.e12, u.e1nil, u.e12inf*u.e2nil + u.e12nil*u.e2inf + u.e1inf + u.e1nilinf*u.enilinf, u.e2nil, -u.e12inf*u.e1nil - u.e12nil*u.e1inf + u.e2inf + u.e2nilinf*u.enilinf, -u.e12*u.e12nil - u.e1nil*u.e1nilinf - u.e2nil*u.e2nilinf + u.enilinf, u.e12nil, -u.e12inf*u.enil + u.e12inf - u.e12nil*u.einf + u.e12nilinf*u.enilinf, -u.e12nil*u.e2 - u.e12nilinf*u.e2nil - u.e1nilinf*u.enil + u.e1nilinf, u.e1*u.e12nil + u.e12nilinf*u.e1nil - u.e2nilinf*u.enil + u.e2nilinf, u.e12nilinf);
}

CGA2 point_coords(CGA2 u){
    return CGA2(u.e1*u.e1nil/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e2*u.e2nil/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.enil*u.enilinf/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)), u.e12*u.e2nil/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e1nil*u.enilinf/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e1nil*u.scalar/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)), -u.e12*u.e1nil/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e2nil*u.enilinf/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e2nil*u.scalar/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)), 0.0, 0.0, u.e1*u.e2nil/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) + u.e12nil*u.enilinf/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)) - u.e1nil*u.e2/(pow(u.e1nil, 2.0) + pow(u.e2nil, 2.0)), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}

// injectOneBlade.glsl
/* Inject array v at the indices for e1, e2 in array u */
void injectOneBladeArray(inout float u[16], float v[2]){
    u[I_CGA2_e1] = v[0];
    u[I_CGA2_e2] = v[1];
}

/* Inject array v into e1, e2 of struct u */
CGA2 injectOneBlade(CGA2 u, float v[2]){
    float u_ary[16];
    toArray(u, u_ary);
    injectOneBladeArray(u_ary, v);
    return fromArray(u_ary);
}

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
    circ = mul(1.0/mul(att, att).scalar, mul(0.5, circ));
    return circ;
}

vec2 reflect(vec2 x, CGA2 R){
    return point_vec(mul(mul(R,point(x)),R));
}

void main() {
  gl_PointSize = pointSize;
  vec2 x = reflect(position, circle(vec2(0.5,0.2), vec2(0.5, 0.8), vec2(0.3, 0.2)));
  gl_Position =
      vec4(scale * x[0] * viewportRatio, scale * x  [1], 0, 1);
}