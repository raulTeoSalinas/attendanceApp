//
//  AsistenciaDAO.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import Foundation

class AsistenciaDAO {
    
    var persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func getAsistencias() throws -> [Asistencia] {
        return try persistence.dbQueue.read { db in
            try Asistencia.fetchAll(db)
        }
    }
    
    func createAsistencia(asistencia: Asistencia) throws {
        return try persistence.dbQueue.write { db in
            try asistencia.save(db)
        }
    }


    
}
