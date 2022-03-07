module FEMAssembler

    struct materialsData{T}
        youngModulus::T
    end

    struct elementsData
        crossSectionArea::Float64
    end

    struct boundaryCondsData
        diriDofs::Vector{Int}
    end

    struct systemMatrix{T}
        matrix::T       
    end
    include("assembler.jl")

    export elementsData,
           materialsData,
           boundaryCondsData,
           assembler

end # module
