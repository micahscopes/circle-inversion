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