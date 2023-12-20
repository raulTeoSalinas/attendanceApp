//
//  TarjetaDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

/// `TarjetaDAO` es una clase que proporciona métodos para realizar operaciones de acceso a datos
/// relacionadas con la entidad  ``Tarjeta`` en la base de datos, utilizando la capa de persistencia proporcionada.
class TarjetaDAO {
    
    /// La capa de persistencia utilizada para acceder a la base de datos.
    var persistence: Persistence
    
    /// Inicializa una nueva instancia de `TarjetaDAO`.
        ///
        /// - Parameter persistence: La capa de persistencia a utilizar.
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    /// Crea un nuevo registro de tarjeta en la base de datos.
        ///
        /// - Parameter tarjeta: El objeto `Tarjeta` que se va a insertar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la inserción de la tarjeta.
    func createTarjeta(tarjeta: Tarjeta) throws {
        try persistence.dbQueue.write { db in
            try tarjeta.save(db)
        }
    }
    
    /// Obtiene todas las tarjetas almacenadas en la base de datos.
        ///
        /// - Returns: Un arreglo de objetos `Tarjeta` que representan a todas las tarjetas.
        /// - Throws: Se lanza un error si ocurre algún problema durante la lectura de datos.
    func getTarjetas() throws -> [Tarjeta]  {
        return try persistence.dbQueue.read { db in
            try Tarjeta.fetchAll(db)
        }
    }
    
    /// Elimina un registro de tarjeta de la base de datos.
        ///
        /// - Parameter tarjeta: El objeto `Tarjeta` que se va a eliminar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la eliminación de la tarjeta.
    func deleteTarjeta(tarjeta: Tarjeta) throws {
        _ = try persistence.dbQueue.write { db in
            try tarjeta.delete(db)
        }
    }
}
