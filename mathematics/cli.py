import click
from . import CGA
from alglbraic.algebras.clifford_algebra import CliffordAlgebra
from alglbraic.functions import map
from sympy import diag, Matrix, symbols
from sympy import cos, sin
from sympy.tensor import IndexedBase

@click.group(chain=True)
def commands():
    pass

@commands.command()
@click.pass_context
@click.option("--size", "size", type=int)
@click.option("--base", "base_ring")
def cga(ctx, **opts):
    opts = {k: v for (k, v) in opts.items() if v is not None}
    alg = ctx.obj["latest_struct"] = CGA(**opts)
    ctx.obj["results"][alg.type_name] = alg
    return alg.bundle()


@commands.command()
@click.pass_context
@click.option("--size", "size", type=int)
def planar_rotation(ctx, **kwargs):
    size = kwargs.get('size')
    if size > 4 or size < 2:
        return ''
    class rotation(object):
        @staticmethod
        def bundle():
            CL = CliffordAlgebra('Cl%i' % size, size*[1])
            
            x, u, v = [
                CL._algebraic_element_from_coefficients(
                    [0]+symbols(['%s[%i]' % (s,i) for i in range(size)])
                ) for s in 'xuv'
            ]

            th = symbols('theta')
            rot_plane = u^v
            R = cos(th)+rot_plane*sin(th)
            Rinv = cos(th)-rot_plane*sin(th)
            rotated = R*x*Rinv

            result = CL._coefficients_from_algebraic_element(rotated)[1:1+size]

            type_vec = 'vec%i' % size
            return map('rotate', ([type_vec]*3) + ['float'], ['x','u','v','theta'], type_vec, result)

    ctx.obj["results"]['rotate%s' % size] = rotation
