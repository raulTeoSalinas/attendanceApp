//
//  NFCScan.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

protocol NFCScan {
    
    func read() -> String
}

class NFCImpl: NFCScan {
    
    func read() -> String {
        // TODO: NFC implementation
        return "123456789"
    }
}
