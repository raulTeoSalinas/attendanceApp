//
//  ServiceNFC.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class ServiceNFC {
    
    var nfc: NFCScan
    
    init() {
        self.nfc = NFCImpl()
    }
    
    func read(completion: @escaping (String) -> Void) {
        
        nfc.read(completion: completion)
        
    }
}
