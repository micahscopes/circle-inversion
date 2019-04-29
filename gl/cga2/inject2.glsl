/* Inject coordinates i_v of array v into coordinates i_u of array u */
float[16] inject2(inout float u[16], int i_u[2], float v[2], int i_v[2]){
    u[i_u[0]] = v[i_v[0]];
    u[i_u[1]] = v[i_v[1]];
    return u;
}

/* Inject array v into coordinates i_u of array u */
float float[16] inject2(inout float u[2], int i_u[2], float v[16]){
    inject2(u, i_u, v);
    return u;
}

/* Inject coordinates i_v of array v into coordinates i_u of struct u */
CGA2 inject2(inout float u[2], int i_u[2], float v[16], int i_v[2]){
    return fromArray(inject(u, i_u, v, i_v));
}

/* Inject coordinates i_v of array v into coordinates i_u of struct u */
CGA2 inject2(inout float u[2], int i_u[2], float v[16]){
    return inject(u, i_u, v));
}