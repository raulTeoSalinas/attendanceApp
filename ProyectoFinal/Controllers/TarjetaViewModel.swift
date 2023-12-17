//
//  TarjetaViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

class TarjetaViewModel: ObservableObject {
    
    private let tarjetaDAO: TarjetaDAO
    private let serviceNFC: ServiceNFC
    @Published var tarjetas = [Tarjeta]()
    
    
    init(tarjetaDAO: TarjetaDAO) {

        self.tarjetaDAO = tarjetaDAO
        tarjetas = try! tarjetaDAO.getTarjetas()
        serviceNFC = ServiceNFC()
    }
    
    func createTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.createTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func deleteTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.deleteTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func handleScan(completion: @escaping (String) -> Void) {
        
        serviceNFC.read(completion: completion)
    }
    
}
