
"""
computeDofsIndxs.

This function computes the vectors of indexes or degrees of freedom corresponding to the BCs.

    The output is a `BCsIndexes` type struct.

"""
function computeDofsIndxs( elemNodalConnec, elemMEBIVals, condsVals )

    nElems   = size( elemNodalConnec, 1)     ;
    numNodes = maximum( elemNodalConnec )[1] ;

    # candidate for BCsIndexes.neumDofs
    neumDofs = Vector( 1:2*numNodes ) ;

    # and candidate for BCsIndexes.diriDofs
    diriDofs = [] ;

    # get the relevant BCs definitions
    boundaryTypes = sort( unique( elemMEBIVals[:,3] ) ) ;  # get and sort them
    boundaryTypes[1]==0 && popfirst!( boundaryTypes);       # and remove zeros

    # loop on the BCs
    for bctype in boundaryTypes;
        print("\nbctype:", bctype)
        elemsWithBCType = findall( x->x==bctype, elemMEBIVals[:,3] );
        print("\n elems with bctype:", elemsWithBCType)

        for elem in elemsWithBCType
            print("\nelem:", elem)
            print( elemNodalConnec[ elem ] );
            elemDofs = nodes2dofs( elemNodalConnec[ elem ] , 2) ;
        end

    end

    BCdata = BCsIndexes(  diriDofs, neumDofs  );
    return BCdata;
end



"""
nodes2dofs computes the vector of dofs for an input vector of nodes
"""

function nodes2dofs( nodes , degreespernode )

    n    = length(nodes);
    dofs = zeros( Int, n*degreespernode ) ;
    for i in (1:n);
        print("\ni:",i,"\n")
        print( (i-1)*degreespernode .+ Vector(1:degreespernode) )
        print((degreespernode*(nodes[i]-1)).+Vector(1:degreespernode))
        dofs[ (i-1)*degreespernode .+ Vector(1:degreespernode) ] = (degreespernode*(nodes[i]-1)).+Vector(1:degreespernode)  ;
    end
    return dofs;
end
