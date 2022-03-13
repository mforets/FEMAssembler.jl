"""
computeDofsIndxs computes the vectors of indexes or degrees of freedom corresponding to the BCs
"""
function computeDofsIndxs( elemNodalConnec, elemMEBIVals, condsVals )

    nElems     = size( elemNodalConnec, 1) ;

    freeDofs = zeros(Int8, 2*numNodes-length(fixedDofs))

    # identify the BCs definitions and loop on them to extract the
    # corresponding elements
    boundaryTypes = unique( elemMEBIVals[:,3] ) ;
    for bctype in boundaryTypes;
        elemsWithBCType = findall( x->x==bctype, elemMEBIVals[:,3] );
        print(elemsWithBCType)

        for elem in elemsWithBCType
            elemNodalConnec[ elem ];
        end

    end

    return 1;
end


"""
nodes2dofs computes the vector of dofs for an input vector of nodes
"""

function nodes2dofs( nodes , degreespernode )

n    = length(nodes);
dofs = zeros( Int8, n*degreespernode ) ;

# for i=1:n
#   dofs( (i-1)*degreespernode + (1:degreespernode) ) = [ (degreespernode*(nodes(i)-1))+(1:degreespernode) ]' ;
# end
    return dofs;
end
