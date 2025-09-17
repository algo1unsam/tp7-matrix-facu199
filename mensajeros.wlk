import mensajeria.*
object morfeo {
    var property pesoPropio = 90
    var property transporte = camion
    var property tieneCredito=false

    method peso()= pesoPropio + transporte.peso()

    method puedeEntregarA(destino)= destino.dejarPasar(self)

    method puedeLlamar()=tieneCredito
}

object neo {
    var property tieneCredito=true 
    var property peso = 0

    method puedeEntregarA(destino)= destino.dejarPasar(self)

    method puedeLlamar()=tieneCredito
}

object trinity {
    var property peso = 900 
    method puedeEntregarA(destino)= destino.dejarPasar(self)
    method puedeLlamar()=true
}
object camion {
    var property acoplados = 1

    method peso()=acoplados*500
}

object monopatin {
    var property  peso = 1 
}

object puente {
    method dejarPasar(mensajero)= mensajero.peso()<=1000
}

object matrix {
    method dejarPasar(mensajero)= mensajero.puedeLlamar()
  
}

object paquete {
    var property estaPago = false
    var property destino = puente 
    
    method precio()=50
    method pago(valor){
        estaPago=valor
    }

    method pagar() {
        estaPago=true
    }

    method puedeSerEntregadoPor(mensajero) = estaPago and mensajero.puedeEntregarA(destino)
}

object paquetito {
  method estaPago()=true
  method precio()=0
  method puedeSerEntregadoPor(mensajero)=true
}

object paquetonViajero {
  var property destinos = [puente, matrix]
  var property pagado =0

  method precio()=destinos.size()*100
  method estaPago() = pagado >= self.precio()

  method pagar(monto) {
    pagado+=monto
  }

  method puedeSerEntregadoPor(mensajero)=self.estaPago() and destinos.all({destino => mensajero.puedeEntregarA(destino)})
}