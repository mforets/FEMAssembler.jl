module FEMAssembler

    # initialization of structures
    include("init.jl")

    # functions
    include("elements/linearTrussStiffnessMatrix.jl")
    include("dofsComputations.jl")
    include("assembler.jl")

    # exports
    include("exports.jl")

end # module
