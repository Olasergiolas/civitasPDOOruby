# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
    class MazoSorpresas
      @sorpresas = Array.new
      @barajada
      @usadas
      @debug = false
      @cartasEspeciales = Array.new
      @ultimaSorpresa
    end
    
    def initialize(d = false)
      if (d == false || d == true)
        @debug = d
      end
      init
      if (@debug == true)
        Diario.ocurre_evento("Modo debug activado.")
      end
    end
    
    def alMazo(s)
      if @barajada == false
        @sorpresas << s
      end
    end
    
    def siguiente
      if (@barajada == false || @usadas == @sorpresas.size)
        if (@debug == false)
          @sorpresas.shuffle
        end
        
        @usadas = 0
        @barajada = true
      end
      
      @usadas += 1
      @ultimaSorpresa = @sorpresas[0]
      @sorpresas << @ultimaSorpresa
      @sorpresas.shift  
    end
    
    def inhabilitarCartaEspecial(sorpresa)
      if @sorpresa.include?(sorpresa) == true
        @sorpresa.delete(sorpresa)
        @cartasEspeciales << sorpresa
        Diario.ocurre_evento("Se ha inhabilitado la carta sorpresa ???") # falta clase sorpresa para poder intentar referenciarla
      end
    end
    
    def habilitarCartaEspecial(sorpresa)
      if @cartasEspeciales.include?(sorpresa) == true
        @cartasEspeciales.delete(sorpresa)
        @sorpresa << sorpresa
        Diario.ocurre_evento("Se ha habilitado la carta sorpresa ???") # el mismo problema sargento MacJohnson
      end
    end
    
    private
    def init
      @barajada = false
      @usadas = 0
    end
end
