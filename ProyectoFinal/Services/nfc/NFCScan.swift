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
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<10).map { _ in characters.randomElement()! })
    }
}
