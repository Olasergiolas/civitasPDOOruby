# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class SorpresaPorCasaHotel < Sorpresa
    def initialize(tipo, valor, texto)
      @tipo = tipo
      @valor = valor
      @texto = texto
    end
    
    
  end
end
