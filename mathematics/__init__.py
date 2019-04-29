from alglbraic.algebras.clifford_algebra import ConformalGeometricAlgebra
from sympy import diag, Matrix

from alglbraic import GLSL
from alglbraic.glsl import meta_glsl

class CGA(ConformalGeometricAlgebra):
    def __init__(self, size, **opts):
        ConformalGeometricAlgebra.__init__(self, size, **opts)
        self.nil, self.inf = self._grade_1_basis[-2:]
        self.mnk = self.nil^self.inf

    @meta_glsl()
    def point(self, **kwargs) -> GLSL:
        u = self.algebraic_arguments(1)
        result = self.nil + u + (u|u)*self.inf/2
        return self.algebraic_operation("point", result, n=1, **kwargs)

    @meta_glsl()
    def point_coords(self, **kwargs) -> GLSL:
        u = self.algebraic_arguments(1)
        # import ipdb; ipdb.set_trace()
        result = (-u/(u.grade(2)|self.inf)^self.mnk)/self.mnk
        return self.algebraic_operation("point_coords", result, n=1, **kwargs)
