class Vikingo{
	var castaSocial 
	var rol /*granjero o soldado*/
	method puedeSubirAExpedicion()= rol.esProductivo() && castaSocial.puedeSubirExpedicion()
	//method invadir(ciudad)= ciudad.sufrirInvasion()
	method ascenderEscala()
	method cambiarCastaA(casta){
		castaSocial = casta
	}
	
	
	method subirAExpedicion(expedicion){
		if (self.puedeSubirAExpedicion()){expedicion.agregarVikingo(self)}
		else self.error("El vikingo no puede subirse a la expedición")
		//Buscar forma de re-escribirlo fancy
	}
	
	
	
}

class Granjero{
	var hijos
	var hectareas
	method esProductivo()= hectareas >= 2* hijos
	method condicionAscenso(){
	 hijos += 2
	 hectareas += 2 }
	
}
class Soldado {
	var vidasCobradas
	var armas
	//method vidasCobradas() = vidasCobradas
	method tieneArmas() = armas > 0
	method esProductivo()= vidasCobradas > 20 && self.tieneArmas()
	method condicionAscenso(){armas += 10}
}

class Casta{
	method ascenderEscala(vikingo)
	method puedeSubirExpedicion()= true
	
}

class Jarl inherits Casta{
	var tieneArmas = false
	override method puedeSubirExpedicion()= not tieneArmas
	override method ascenderEscala(vikingo){vikingo.cambiarCastaA(new Karl())}
} 

class Karl inherits Casta{ 
	override method ascenderEscala(vikingo) {vikingo.cambiarCasta(new Thrall())}
	}
	
class Thrall inherits Casta{ 
	override method ascenderEscala(vikingo) {}
	}
	
	
/*class Ciudad{
	var modo= new Capital()
	method modo()= modo
}*/

//Lo hacemos como clase porque asumimos que hay varias capitales con 
//distinta cant de monedas y defensores, pero para la información que hay en nuestro dominio creo que no haría falta
class Capital{
	var cantMonedasOro = 0
	var defensoresDerrotados = 0
	method valeLaPena(cantVikingos)= cantMonedasOro >= cantVikingos * 3
	method sufrirInvasion(cantVikingos){ defensoresDerrotados -= cantVikingos
		cantMonedasOro += defensoresDerrotados
	}
	method botin()= cantMonedasOro
}

class Expedicion{
	const ciudades = []
	var vikingos = []
	const cantVikingos = vikingos.size() /*No sé si es necesario que la expedicion conozca la cantidad de vikingos*/
	method expedicionValeLaPena()= ciudades.ForEach{ciudad => ciudad.valeLaPena(cantVikingos)}
	//method capitales()= ciudades.filter{ciudad => ciudad.modo()== new Capital()}
	//method invadirCapital(capital)= capital.sufrirInvasion(cantVikingos) 
	method realizarExpedicion(){ciudades.forEach{ciudad => ciudad.sufrirInvasion(cantVikingos)}
								(ciudades.forEach{ciudad => ciudad.botin()}).sum() / cantVikingos }
	}


class Aldea{
	var cantMonedasOro
	const iglesias = []
	method valeLaPena()= cantMonedasOro > 15
	method botin()= cantMonedasOro
	method cantMonedasOro(){cantMonedasOro = (iglesias.forEach({iglesia => iglesia.cantCrucifijos()}).sum())}
	method sufrirInvasion(cantVikingos){ iglesias.forEach({iglesia => iglesia.perderCrucifijos()})}
}

class AldeaAmurallada inherits Aldea{
	var cantVikingosComitiva
	override method valeLaPena()= self.cumpleCantVikingos() && super()
	method cumpleCantVikingos() = false
}

//Lo hacemos como clase para que cada iglesia tenga su propia cant de crucifijos
class Iglesia{
	var cantCrucifijos
	method cantCrucifijos()= cantCrucifijos
	method perderCrucifijos(){cantCrucifijos = 0}
}

/* Primera opción de modelado
 class Soldado inherits Vikingo{
	var vidasCobradas
	//method vidasCobradas() = vidasCobradas
	var tieneArmas = false
	override method esProductivo()= vidasCobradas > 20 && tieneArmas
}

class Granjero inherits Vikingo{
	var hijos
	var hectareas
	override method esProductivo()= hectareas >= 2* hijos
	
}

class Casta{
	method puedeSubir()= true
}

class Esclavo inherits Casta{
	var tieneArmas = false
	override method puedeSubir()= not tieneArmas
}*/

	

