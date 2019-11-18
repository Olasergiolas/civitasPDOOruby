# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Jugador'
require_relative 'TipoCasilla'
require_relative 'TituloPropiedad'

module Civitas  
    class Casilla
    
    @@carcel = 0
    def initialize(nombre, titulo, cantidad, numCasillaCarcel, mazo, tipo)
      @@carcel = numCasillaCarcel
      @nombre = nombre
      @importe = cantidad
      @tipo = tipo
      @mazo = mazo
      @sorpresa = nil
      @tituloPropiedad = titulo
    end
    
    def self.new_n(nombre)
      new(nombre, nil, 0, @@carcel, nil, TipoCasilla::DESCANSO)
    end
    
    def self.new_t(titulo)
      new(nil, titulo, 0, @@carcel, nil, TipoCasilla::CALLE)
    end
    
    def self.new_c_n(cantidad, nombre)
      new(nombre, nil, cantidad, @@carcel, nil, TipoCasilla::IMPUESTO)
    end
    
    def self.new_num_n(numCasillaCarcel, nombre)
      new(nombre, nil, 0, numCasillaCarcel, nil, TipoCasilla::JUEZ)
    end
    
    def self.new_m_n(mazo, nombre)
      new(nombre, nil, 0, @@carcel, mazo, TipoCasilla::SORPRESA)
    end
    
    def informe(iactual, todos)
      Diario.instance.ocurre_evento("El jugador #{todos[iactual].nombre} ha caido en una casilla #{toString}")
    end
    
    def jugadorCorrecto(iactual, todos)
      correcto = false
      if (iactual >= 0 && iactual <= todos.size)
        correcto = true
      end
      
      return correcto
    end
    
    def recibeJugador(iactual, todos)
      correcto = jugadorCorrecto(iactual, todos)
      if (correcto)
        informe(iactual, todos)
      end
      if (@tipo == TipoCasilla::CALLE && correcto)
        recibeJugador_calle(iactual,todos)
      elsif (@tipo == TipoCasilla::IMPUESTO && correcto)
        recibeJugador_impuesto(iactual,todos)
      elsif (@tipo == TipoCasilla::JUEZ && correcto)
        recibeJugador_juez(iactual,todos)
      elsif(@tipo == TipoCasilla::SORPRESA && correcto)
        recibeJugador_sorpresa(iactual,todos)
      end
    end
    
    def recibeJugador_calle(iactual, todos)
      jugador = todos[iactual]
      if (!@tituloPropiedad.tienePropietario)
        jugador.puedeComprarCasilla
      else
        @tituloPropiedad.tramitarAlquiler(jugador)
      end
    end
    
    def recibeJugador_impuesto(iactual, todos)
      todos[iactual].pagaImpuesto(@importe)
    end
    
    def recibeJugador_juez(iactual, todos)
      todos[iactual].encarcelar(@@carcel)
    end
    
    def recibeJugador_sorpresa(iactual, todos)
      @mazo.siguiente.aplicarAJugador(iactual, todos)
    end
    
    def toString
      if (@tipo == TipoCasilla::CALLE)
        info = "Casilla #{@tituloPropiedad.nombre} con importe #{@tituloPropiedad.precioCompra}, de tipo #{@tipo}, con un TituloPropiedad de nombre\n"
      
      else
        info = "Casilla #{@nombre} con importe #{@importe}, de tipo #{@tipo}, con un TituloPropiedad de nombre\n"
      end
    end
    
    attr_reader :nombre, :tituloPropiedad
  end 
end
