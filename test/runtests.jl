using FEMAssembler
using Test

@testset "Test: linear von mises problem" begin
  include("../examples/vonMisesTruss.jl")

  @test true
end
