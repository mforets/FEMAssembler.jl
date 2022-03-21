"""
assembler is the functions in charge of the construction of the matrix and RHS of the main FEM system
"""
function assembler( nodalCoords, elemNodalConnec, elemMEBIVals, materialsData, elementsData, thisBCsIndexes, load, currentSolution )

    nElems     = size( elemNodalConnec, 1) ;
    nNodes     = size( nodalCoords,     1) ;

    # The global stiffness equations are computed for the unknown displacements (free dofs)
    KG = zeros( 2*nNodes, 2*nNodes ) ;
    FG = zeros( 2*nNodes ) ;

    for elem in (1:nElems);
        if elemMEBIVals[ elem, 1 ] > 0
            nodesOfThisElem = elemNodalConnec[ elem ] ;
            dofsElem = nodes2dofs( nodesOfThisElem , 2 ) ;
print("\ndofsElem: ", dofsElem)
            E = materialsData.youngModulus ;
            A = elementsData.crossSectionArea ;

            nodesOfElemCoords = nodalCoords[ nodesOfThisElem, : ] ;
            L = norm( nodalCoords[ nodesOfThisElem[1], : ] - nodalCoords[ nodesOfThisElem[2], : ] );

            KGelem = linearTrussStiffnessMatrix( E, A, nodesOfElemCoords );

display(KGelem)
            stiffnessParam = E * A / L ;

            KG[ dofsElem, dofsElem ] = KG[ dofsElem, dofsElem ] .+ stiffnessParam * KGelem ;
        end
    end

    FG[ thisBCsIndexes.neumDofs ] = load ;

    return KG, FG;

end
