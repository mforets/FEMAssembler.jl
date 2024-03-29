function linearTrussStiffnessMatrix( E, A, nodalCoords  )

  diff = nodalCoords[ 2, : ] - nodalCoords[ 1, : ] ;

  length   = sqrt( diff' * diff ) ;
  c        = diff[1] / length ;
  s        = diff[2] / length ;

  Qloc2glo = [  c -s 0  0 ;
                s  c 0  0 ;
                0 0  c -s ;
                0 0  s  c ] ;

  Kloc     = E*A/length * [ 1  0 -1 0 ;
                            0  0  0 0 ;
                            -1 0  1 0 ;
                            0  0  0 0 ] ;
  Kglo     = Qloc2glo * Kloc * transpose(Qloc2glo) ;

  return Kglo
end
#
