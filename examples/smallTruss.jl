
using FEMAssembler

E = 2e11 ; # Young modulus
steel = materialsData(E);

A = 5e-3 ; # Cross-section area
section = elementsData(A);

# The coordinate matrix is given by
nodalCoords = [ 0.0 0.0 ;
                1.0 1.0 ;
                2.0 0.0 ;
                3.0 1.0 ;
                4.0 0.0 ];

# the connectivity matrix is given by
elemNodalConnec = [ [ 1, 2],
                  [ 1, 3] ] ;

elemMEBIVals = [ 1 1 ;
                 1 1 ] ;

f = assembler( nodalCoords, elemNodalConnec, elemMEBIVals, steel, section, [], [] )
