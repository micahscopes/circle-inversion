/* Inject coordinates i_v of array v into coordinates i_u of array u */
void inject2ArrayWithCoords(inout float u[16], int i_u[2], float v[2], int i_v[2]){
    u[i_u[0]] = v[i_v[0]];
    u[i_u[1]] = v[i_v[1]];
}

/* Inject array v into coordinates i_u of array u */
void inject2Array(inout float u[16], int i_u[2], float v[2]){
    u[i_u[0]] = v[0];
    u[i_u[1]] = v[1];
}

/* Inject coordinates i_v of array v into coordinates i_u of struct u */
CGA2 inject2(CGA2 u, int i_u[2], float v[2], int i_v[2]){
    float u_ary[16];
    toArray(u, u_ary);
    inject2ArrayWithCoords(u_ary, i_u, v, i_v);
    return fromArray(u_ary);
}

/* Inject array v into coordinates i_u of struct u */
CGA2 inject2(CGA2 u, int i_u[2], float v[2]){
    float u_ary[16];
    toArray(u, u_ary);
    inject2Array(u_ary, i_u, v);
    return fromArray(u_ary);
}