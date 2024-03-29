
using LinearAlgebra

struct materialsData{T}
    youngModulus::T
end

struct elementsData
    crossSectionArea::Float64
end

struct boundaryCondsData
    DirichletNodalDOFs::Vector{Int}
    DirichletNodalVals::Vector{Float64}
    NeumannNodalDOFs::Vector{Int}
    NeumannNodalVals::Vector{Float64}
end

struct BCsIndexes
    diriDofs::Vector{Int}
    neumDofs::Vector{Int}
end

struct systemMatrix{T}
    matrix::T
end
