# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require './Diario'

module Civitas
    class MazoSorpresas
    
    def initialize(d = false)
      @sorpresas = Array.new
      @barajada
      @usadas
      @cartasEspeciales = Array.new
      @ultimaSorpresa
      
      if (d == false || d == true)
        @debug = d
      else
        @debug = false
      end
      init
      if (@debug == true)
        Diario.instance.ocurre_evento("Modo debug activado.")
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
      if @sorpresas.include? sorpresa == true
        @sorpresas.delete(sorpresa)
        @cartasEspeciales << sorpresa
        Diario.instance.ocurre_evento("Se ha inhabilitado la carta sorpresa ???") # falta clase sorpresa para poder intentar referenciarla
      end
    end
    
    def habilitarCartaEspecial(sorpresa)
      if @cartasEspeciales.include? sorpresa == true
        @cartasEspeciales.delete(sorpresa)
        @sorpresas << sorpresa
        Diario.instance.ocurre_evento("Se ha habilitado la carta sorpresa ???") # el mismo problema sargento MacJohnson
      end
    end
    
    private
    def init
      @barajada = false
      @usadas = 0
    end
  end
end
