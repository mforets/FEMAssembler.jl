
using FEMAssembler

E = 2e11 ; # Young modulus
steel = materialsData(E);

A = 5e-3 ; # Cross-section area
section = elementsData(A);

# The coordinate matrix is given by
nodalCoords = [ 0.0  0.0 ;
                1.0  1.0 ;
                2.0  0.0 ] ;

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

load = [ 0, -1.0 ] ;

KG, FG = assembler( nodalCoords, elemNodalConnec, elemMEBIVals, steel, section, thisBCsIndexes, load, [] ) ;

print("KG:\n")
display(KG)

KGred = copy( KG ) ;
FGred = copy( FG ) ;

KGred = KGred[ thisBCsIndexes.neumDofs, thisBCsIndexes.neumDofs ] ;
FGred = FGred[ thisBCsIndexes.neumDofs                          ] ;

print("KGred", KGred)
# the system is solved.
UGred = KGred \ FGred ;

UG = zeros( size( FG ) ) ;
UG[ thisBCsIndexes.neumDofs ] = UGred ;
