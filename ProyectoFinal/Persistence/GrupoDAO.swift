//
//  GrupoDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class GrupoDAO {
    
    var persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    
    func createGrupo(grupo: Grupo) throws {
        return try persistence.dbQueue.read { db in
            try grupo.save(db)
        }
    }

    
    func getGrupos() throws -> [Grupo] {
        return try persistence.dbQueue.read { db in
            try Grupo.fetchAll(db)
        }
    }
    
    func updateGrupo(record: Grupo) throws {
        try persistence.dbQueue.write { db in
            try record.update(db)
        }
    }
    
    func deleteGrupo(record: Grupo) throws {
        _ = try persistence.dbQueue.write { db in
            try record.delete(db)
        }
    }
}
