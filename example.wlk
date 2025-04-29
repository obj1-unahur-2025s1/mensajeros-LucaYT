object paquete {
  var estaPago = false
  var destino = laMatrix
  method estaPago(){return estaPago}
  method pagarPaquete(){estaPago = true}
  method destino(nuevoDestino){destino = nuevoDestino}
  method puedeEntregarse(unMensajero){return destino.dejaPasar(unMensajero) && estaPago}
  method precio(){return 50}
}

object puenteDeBrooklyn{
  method dejaPasar(unMensajero){
    return
    unMensajero.peso() < 1000
  }
}

object laMatrix{
  method dejaPasar(unMensajero){
    return
    unMensajero.puedeLlamar()
  }
}

object roberto{
  var transporte = bicicleta
  method peso(){return 90 + transporte.peso()}
  method puedeLlamar(){return false}
  method cambiaDeTransporte(nuevoTransporte){transporte = nuevoTransporte}
}

object chuckNorris{
  method peso(){return 80}
  method puedeLlamar(){return true}
}

object neo{
  var tieneCredito = true
  method peso(){return 0}
  method puedeLlamar(){tieneCredito}
  method cargarCredito(){tieneCredito = true}
  method agotarCredito(){tieneCredito = false}
}

object bicicleta {
  method peso() = 5
}

object camion{
  var acoplados = 1
  method cantAcoplados(unaCantidad){acoplados = unaCantidad}
  method peso(){acoplados * 500}
}

object empresaMensajes {
  const mensajeros = []
  const paquetesPendientes = []
  const paquetesEnviados = []
  method mensajeros() = mensajeros
  
  method contratar(unMensajero){
    mensajeros.add(unMensajero)
  }

  method despedir(unMensajero){
    mensajeros.remove(unMensajero)
  }

  method esGrande() = mensajeros.size() > 2

  method puedeEntregarPrimerMensajero(){return paquete.puedeEntregarse(mensajeros.first())}

  method pesoUltimoMensajero(){return mensajeros.last().peso()}

  method puedeEntregarsePaquete(){return paquete.puedeEntregarse(mensajeros.first())}

  method puedeEntregarse(unPaquete){return mensajeros.any({m => unPaquete.puedeEntregarse(m)})}
  //SI NECESITO QUE LA LISTA SEA DE OTRA COSA QUE NO SEAN LOS OBJETOS COMO NUMEROS, LA CAMBIO CON
  //LA FORMA HECHA ARRIBA

  method losQuePuedenEntregar(unPaquete){return mensajeros.filter({m => paquete.puedeEntregarse(m)})}

  method tieneSobrepeso(){return self.pesosDeLosMensajeros() / mensajeros.size() > 500}

  method pesosDeLosMensajeros(){return mensajeros.sum({m => m.peso()})}

  method enviar(unPaquete){
    if(self.puedeEntregarse(unPaquete)){
      paquetesEnviados.add(unPaquete)
    }
    else{
      paquetesPendientes.add(unPaquete)
    }
  }

  method facturacion(){return paquetesEnviados.sum({p => p.precio()})} //Así de simple papá
  //Le pones la suma de los precios de los paquetes, corta la bocha

  method enviarPaquetes(listaDePaquetes){
    listaDePaquetes.forEach({p => self.enviar(p)}) //a cada paquete lo envía a través de la funcion enviar
  }

  method enviarPendienteMasCaro(){
    if(self.puedeEntregarse(self.paqueteMasCaroPendiente()))
      self.enviar(self.paqueteMasCaroPendiente())
      paquetesPendientes.remove(self.paqueteMasCaroPendiente()) //HICE UNOo
  }
  method paqueteMasCaroPendiente(){return paquetesPendientes.max({p => p.precio()})}
}

object paquetito{
  method estaPago(){return true}
  method puedeEntregarse(unMensajero){return true}
  method precio(){return 0}
}

object paquetonViajero{
  const destinos = []
  var importePagado = 0
  method estaPago(){return importePagado >= self.precio()}
  
  method puedeEntregarse(unMensajero){
    return
    self.estaPago() &&
    self.puedePasarPorLosDestinos(unMensajero)
  }
  
  method puedePasarPorLosDestinos(unMensajero){
    return destinos.all({d => d.dejaPasar(unMensajero)})
  }

  method agregarDestino(unDestino){destinos.add(unDestino)}
  
  method precio(){return 100 * destinos.size()}
  
  method pagar(unImporte){importePagado += unImporte}
}

