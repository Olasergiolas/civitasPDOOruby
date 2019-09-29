# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require './Dado'

module Civitas
  class TestP1

    @D = Dado.send :new           #Por qué no puedo hacer Dado.new??
    @repeticiones = [0, 0, 0, 0]

    for a in 1..100 do
      resultado = @D.quienEmpieza(4)
      @repeticiones[resultado] = @repeticiones[resultado] + 1
    end

    print @repeticiones

  end
end
