//
//  AsistenciaDAO.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import Foundation

/// `AsistenciaDAO` es una clase que proporciona métodos para realizar operaciones de acceso a datos
/// relacionadas con la entidad ``Asistencia`` en la base de datos, utilizando la capa de persistencia proporcionada.
class AsistenciaDAO {
    
    /// La capa de persistencia utilizada para acceder a la base de datos.
    var persistence: Persistence
    
    /// Inicializa una nueva instancia de `AsistenciaDAO`.
        ///
        /// - Parameter persistence: La capa de persistencia a utilizar.
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    /// Obtiene todas las asistencias almacenadas en la base de datos.
        ///
        /// - Returns: Un arreglo de objetos `Asistencia` que representan a todas las asistencias.
        /// - Throws: Se lanza un error si ocurre algún problema durante la lectura de datos.
    func getAsistencias() throws -> [Asistencia] {
        return try persistence.dbQueue.read { db in
            try Asistencia.fetchAll(db)
        }
    }
    
    /// Crea un nuevo registro de asistencia en la base de datos.
        ///
        /// - Parameter asistencia: El objeto `Asistencia` que se va a insertar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la inserción de la asistencia.
    func createAsistencia(asistencia: Asistencia) throws {
        return try persistence.dbQueue.write { db in
            try asistencia.save(db)
        }
    }


    
}
