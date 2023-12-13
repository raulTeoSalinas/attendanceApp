//
//  NFCScan.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation
import CoreNFC

protocol NFCScan {
    
    func read( completion: @escaping (String) -> Void)
}

class NFCImpl: NSObject, NFCScan, NFCNDEFReaderSessionDelegate {
    
    var session: NFCNDEFReaderSession?
    
    var completion: ((String) -> Void)?
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print(messages)
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
       let st = String((0..<10).map { _ in characters.randomElement()! })
        completion?(st)
    }
    
    

    func read(completion: @escaping (String) -> Void) {
        
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.global(), invalidateAfterFirstRead: true)
        
        guard NFCNDEFReaderSession.readingAvailable else { return }
        
        self.completion = completion
        

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Acerca tu tarjeta del metro."
        session?.begin()
        
        
        
//        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//            return String((0..<10).map { _ in characters.randomElement()! })
    }
}
