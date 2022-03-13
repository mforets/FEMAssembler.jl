module FEMAssembler

    # initialization of structures
    include("init.jl")

    # functions
    include("dofsComputations.jl")
    include("assembler.jl")

    # exports
    include("exports.jl")

end # module
