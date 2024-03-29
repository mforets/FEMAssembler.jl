using FEMAssembler, LinearAlgebra
using Test

@testset "Test: linear von mises problem" begin
  include( joinpath( "..", "examples", "vonMisesTruss.jl" ) )

  L0 = sqrt( d^2 + h^2 ) ;

  cosalpha = d / L0 ;
  sinalpha = h / L0 ;

  Ldef12 = norm( [ d+UG[3],h+UG[4]] - [0,0]  ) ;
  Ldef23 = norm( [2d,0] - [ d+UG[3],h+UG[4]] ) ;

  F12Analy =  +Fx/(2cosalpha) + Fy/(2sinalpha) ;
  F23Analy =  -Fx/(2cosalpha) + Fy/(2sinalpha) ;

  delta12Num = Ldef12-L0 ;
  delta23Num = Ldef23-L0 ;

  delta12Analy = F12Analy*L0 / (E*A) ;
  delta23Analy = F23Analy*L0 / (E*A) ;

  @test maximum( abs.( [ delta12Num-delta12Analy, delta12Num-delta12Analy ] ) ) < 1e-10
end
