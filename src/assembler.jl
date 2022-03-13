"""
assembler is the functions in charge of the construction of the matrix and RHS of the main FEM system 
"""
function assembler( nodalCoords, elemNodalConnec, elemMEBIVals, materialsData, elementsData, thisBCsIndexes, currentSolution )

    nElems     = size( elemNodalConnec, 1) ;
    nNodes     = size( nodalCoords,     1) ;



    return 1;

end
