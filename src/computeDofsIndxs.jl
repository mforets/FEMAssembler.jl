
function computeDofsIndxs( elemNodalConnec, elemMEBIVals, condsVals )

#  = [ 2 9 10 ];
# freeDofs = zeros(Int8, 2*numNodes-length(fixedDofs))
#
# indDof  = 1 ; counter = 0
# while indDof <= (2*numNodes)
# if !(indDof in fixedDofs)
# global counter = counter + 1
# freeDofs[ counter ] = indDof
# end
# global indDof = indDof + 1
# end
#     return freeDofs
# end
    return 1;
end
