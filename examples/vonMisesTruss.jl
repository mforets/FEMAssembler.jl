
using FEMAssembler

## scalar parameters
E  = 2e11 ; # Young modulus in Pa
A  = 5e-3 ; # Cross-section area in m^2
d  = 1.0 ; # horizontal distance in m
h  = 1.0 ; # height in m
Fx = 0    ;
Fy = -1e3 ; # vertical load in N

## set structs
steel = materialsData(E);
section = elementsData(A);

# The coordinate matrix is given by
nodalCoords = [  0  0 ;
                 d  h ;
                2d  0 ] ;

# the connectivity matrix is given by a vector of vectors.
elemNodalConnec = [ [ 1 ],
                    [ 2 ],
                    [ 3 ],
                    [ 1, 2] ,
                    [ 2, 3] ] ;

# matrix with MEBI indexes of each element (on each row)
# MEBI = Materials / Elements / BoundaryConditions / InitialConditions
elemMEBIVals = [ 0 1 1 0  ; # no material / first element / first BC / no IC
                 0 1 2 0  ;
                 0 1 1 0  ;
                 1 2 0 0  ;
                 1 2 0 0 ] ;

thisBCsIndexes = BCsIndexes( [1, 2, 5, 6 ], # fixed degrees of freedom
    [3, 4] ); # fixed degrees of freedom

load = [ Fx, Fy ] ;

KG, FG, Kmatrices = assembler( nodalCoords, elemNodalConnec, elemMEBIVals, steel, section, thisBCsIndexes, load, [] ) ;

print("KG:\n")
display(KG)
print("\n")

KGred = copy( KG ) ;
FGred = copy( FG ) ;

KGred = KGred[ thisBCsIndexes.neumDofs, thisBCsIndexes.neumDofs ] ;
FGred = FGred[ thisBCsIndexes.neumDofs                          ] ;

print("KGred", KGred,"\n")
# the system is solved.
UGred = KGred \ FGred ;

UG = zeros( size( FG ) ) ;
UG[ thisBCsIndexes.neumDofs ] = UGred ;
