
using FEMAssembler

E = 2e11 ; # Young modulus
steel = materialsData(E);

A = 5e-3 ; # Cross-section area
section = elementsData(A);

# The coordinate matrix is given by
nodalCoords = [ 0.0 0.0 0.0 ;
                1.0 0.0 1.0 ;
                2.0 0.0 0.0 ] ;

# the connectivity matrix is given by
elemNodalConnec = [ [ 1 ],
                    [ 2 ],
                    [ 3 ],
                    [ 1, 2] ,
                    [ 1, 3] ] ;

# matrix with MEBI indexes of each element (on each row)
# MEBI = Materials / Elements / BoundaryConditions / InitialConditions
elemMEBIVals = [ 0 1 1 0  ; # no material / first element / first BC / no IC
                 0 1 2 0  ;
                 0 1 1 0  ;
                 1 2 0 0  ;
                 1 2 0 0 ] ;

fixedSupport = boundaryCondsData( [ 1, 2, 3 ], [0, 0, 0], [], [] );
loadAndSupp = boundaryCondsData( [ 2 ], [ 0], [ 3], [-1.0] );

# values of boundary conditions
condsVals = [ fixedSupport, loadAndSupp ];

thisBCsIndexes = computeDofsIndxs( elemNodalConnec, elemMEBIVals, condsVals );

f = assembler( nodalCoords, elemNodalConnec, elemMEBIVals, steel, section, thisBCsIndexes, [] )
