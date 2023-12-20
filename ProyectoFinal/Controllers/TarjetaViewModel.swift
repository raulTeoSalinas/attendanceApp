//
//  TarjetaViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

/// `TarjetaViewModel` es una clase observable que gestiona la lógica relacionada con la entidad ``Tarjeta``.
class TarjetaViewModel: ObservableObject {
    
    /// Una lista de objetos ``Tarjeta``.
    @Published var tarjetas = [Tarjeta]()
    
    /// El objeto ``TarjetaDAO`` utilizado para realizar operaciones de acceso a datos relacionadas con Tarjetas.
    private let tarjetaDAO: TarjetaDAO
    
    /// El objeto ``ServiceNFC`` utilizado para la lectura de tarjetas NFC.
    private let serviceNFC: ServiceNFC
    
    /// Inicializa una nueva instancia de `TarjetaViewModel`.
       ///
       /// - Parameter tarjetaDAO: El objeto ``TarjetaDAO`` que proporciona operaciones de acceso a datos.
    init(tarjetaDAO: TarjetaDAO) {

        self.tarjetaDAO = tarjetaDAO
        tarjetas = try! tarjetaDAO.getTarjetas()
        serviceNFC = ServiceNFC()
    }
    
    /// Crea una nueva tarjeta y actualiza la lista de tarjetas.
        ///
        /// - Parameter tarjeta: El objeto ``Tarjeta`` que se va a crear.
    func createTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.createTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    /// Elimina una tarjeta y actualiza la lista de tarjetas.
        ///
        /// - Parameter tarjeta: El objeto ``Tarjeta`` que se va a eliminar.
    func deleteTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.deleteTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    /// Maneja la lectura de una tarjeta NFC utilizando el servicio NFC.
        ///
        /// - Parameter completion: El bloque de finalización que se llama con el resultado de la lectura.
    func handleScan(completion: @escaping (String) -> Void) {
        
        serviceNFC.read(completion: completion)
    }
    
}
