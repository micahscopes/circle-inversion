from alglbraic.algebras.clifford_algebra import ConformalGeometricAlgebra
from sympy import diag, Matrix, sqrt, symbols
from sympy.tensor import IndexedBase

from alglbraic.glsl import GLSL
from alglbraic.functions import map


class CGA(ConformalGeometricAlgebra):
    def __init__(self, size, **opts):
        ConformalGeometricAlgebra.__init__(self, size, **opts)
        self.nil, self.inf = self._grade_1_basis[-2:]
        self.mnk = self.nil ^ self.inf

    @GLSL
    def INF(self):
        result = self.inf
        return self.algebraic_operation("INF", result, n=0)

    @GLSL
    def NIL(self):
        result = self.nil
        return self.algebraic_operation("NIL", result, n=0)

    @GLSL
    def MNK(self):
        result = self.mnk
        return self.algebraic_operation("MNK", result, n=0)

    @GLSL
    def point(self):
        nil, inf = self.nil, self.inf
        Pt = lambda x: (x | x) * inf / 2 + x + nil
        u = self.algebraic_arguments(1)
        result = Pt(u)
        return self.algebraic_operation("point", result, n=1)

    @GLSL
    def point_coords(self):
        nil, inf = self.nil, self.inf
        u = self.algebraic_arguments(1)
        normalize = lambda pt: -pt / (pt | inf).scalar()
        result = normalize(u)
        # result = (-u/(u.grade(2)|self.inf)^self.mnk)/self.mnk

        return self.algebraic_operation("point_coords", result, n=1)

    # @GLSL
    # def circle_radius(self):
    #     nil, inf = self.nil, self.inf
    #     C = self.algebraic_arguments(1)
    #     Cinf = self.inf | C
    #     result = self.gl(sqrt((-C * C / (Cinf * Cinf).scalar()).scalar()))
    #     return map(
    #         "circle_radius",
    #         [self.type_name],
    #         self.n_ary_argnames(1),
    #         self.base_ring,
    #         result,
    #     )

    # @GLSL
    # def reflect(self):
    #     nil, inf = self.nil, self.inf
    #     Pt = lambda x: (x * x * self.inf / 2 + x + nil)
    #     normalize = lambda pt: -pt / (pt | inf).scalar()
    #     e1, e2 = self._grade_1_basis[0:2]
    #     u = symbols(["u[0]", "u[1]"])
    #     u = u[0] * e1 + u[1] * e2
    #     v = self.algebraic_element("v")
    #     reflection = normalize(v * Pt(u) * v)
    #     result = self.gl(
    #         self._coefficients_from_algebraic_element(reflection)[1:3],
    #         array_constructor="vec2",
    #     )

    #     return map("reflect", ["vec2", self.type_name], ["u", "v"], "vec2", result)
