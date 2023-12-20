//
//  GrupoDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

/// `GrupoDAO` es una clase que proporciona métodos para realizar operaciones de acceso a datos
/// relacionadas con la entidad ``Grupo`` en la base de datos, utilizando la capa de persistencia proporcionada.
class GrupoDAO {
    
    /// La capa de persistencia utilizada para acceder a la base de datos.
    var persistence: Persistence
    
    /// Inicializa una nueva instancia de `GrupoDAO`.
        ///
        /// - Parameter persistence: La capa de persistencia a utilizar.
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    /// Crea un nuevo registro de grupo en la base de datos.
        ///
        /// - Parameter grupo: El objeto `Grupo` que se va a insertar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la inserción del grupo.
    func createGrupo(grupo: Grupo) throws {
        return try persistence.dbQueue.write { db in
            try grupo.save(db)
        }
    }

    /// Obtiene todos los grupos almacenados en la base de datos.
        ///
        /// - Returns: Un arreglo de objetos `Grupo` que representan a todos los grupos.
        /// - Throws: Se lanza un error si ocurre algún problema durante la lectura de datos.
    func getGrupos() throws -> [Grupo] {
        return try persistence.dbQueue.read { db in
            try Grupo.fetchAll(db)
        }
    }
    
    /// Actualiza la información de un grupo existente en la base de datos.
        ///
        /// - Parameter record: El objeto `Grupo` con la información actualizada.
        /// - Throws: Se lanza un error si ocurre algún problema durante la actualización del grupo.
    func updateGrupo(record: Grupo) throws {
        try persistence.dbQueue.write { db in
            try record.update(db)
        }
    }
    
    /// Elimina un registro de grupo de la base de datos.
        ///
        /// - Parameter record: El objeto `Grupo` que se va a eliminar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la eliminación del grupo.
    func deleteGrupo(record: Grupo) throws {
        _ = try persistence.dbQueue.write { db in
            try record.delete(db)
        }
    }
}
