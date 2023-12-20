//
//  ServiceNFC.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

//class ServiceNFC {
//    
//    var nfc: NFCScan
//    
//    init() {
//        self.nfc = NFCImpl()
//    }
//    
//    func read(completion: @escaping (String) -> Void) {
//        
//        nfc.read(completion: completion)
//        
//    }
//}

/// `ServiceNFC` es una clase que encapsula la funcionalidad relacionada con la lectura de tarjetas NFC.
class ServiceNFC {
    
    /// La implementación concreta de la interfaz ``NFCScan`` utilizada para la lectura NFC.
    var nfc: NFCScan
    
    /// Inicializa una nueva instancia de `ServiceNFC`.
    init() {
        self.nfc = NFCImpl()
    }
    
    /// Realiza la lectura de una tarjeta NFC.
        ///
        /// - Parameter completion: El bloque de finalización que se llama con el resultado de la lectura.
    func read(completion: @escaping (String) -> Void) {
        
        nfc.read(completion: completion)
        
    }
}
