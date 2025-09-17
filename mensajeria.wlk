import mensajeros.*

object mensajeria {

    var mensajeros = []
    var property paquetesEnviados = []
    var property paquetesPendientes = [] 


    method contratar(mensajero){
        mensajeros.add(mensajero)
    }

    method despedir(mensajero) {
        mensajeros.remove(mensajero)
    }

    method despedirATodos() {
        mensajeros.clear()
    }

    method esGrande()=mensajeros.size()>2

    method primeroPuedeEntregar(paquete)= !mensajeros.isEmpty() and paquete.puedeSerEntregadoPor(mensajeros.first())

    method pesoUltimoMensajero()= if(mensajeros.isEmpty()) 0 else mensajeros.last().peso()

    method mensajeros()=mensajeros

    method puedeEntregar(paquete)=mensajeros.any({mensajero => paquete.puedeSerEntregadoPor(mensajero)})

    method mensajerosQuePuedenEntregar(paquete)=mensajeros.filter({mensajero => paquete.puedeSerEntregadoPor(mensajero)})
    
    method tieneSobrepeso()=(mensajeros.sum({mensajero => mensajero.peso()}) / mensajeros.size() )> 500

    method enviar(paquete) {
      const mensajerosDisponibles = self.mensajerosQuePuedenEntregar(paquete)
      if(mensajerosDisponibles.isEmpty()){
        paquetesPendientes.add(paquete)
      }else{
        paquetesEnviados.add(paquete)
      }
    }

    method facturacion()= paquetesEnviados.sum({paquete => paquete.precio()})

    method enviarTodos(paquetes) {
        paquetes.forEach({paquete => self.enviar(paquete)})
    }

    method enviarPaqueteMasCaro() {
        const paqueteMasCaro = paquetesPendientes.max({paquete => paquete.precio()})
        if(self.puedeEntregar(paqueteMasCaro)){
            paquetesPendientes.remove(paqueteMasCaro)
            paquetesEnviados.add(paqueteMasCaro)
        }
    } 
}  
