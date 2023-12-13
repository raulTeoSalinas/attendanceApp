//
//  TarjetaDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class TarjetaDAO {
    
    var persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func createTarjeta(tarjeta: Tarjeta) throws {
        try persistence.dbQueue.write { db in
            try tarjeta.save(db)
        }
    }
    
    func getTarjetas() throws -> [Tarjeta]  {
        return try persistence.dbQueue.read { db in
            try Tarjeta.fetchAll(db)
        }
    }
    
    
    func deleteTarjeta(tarjeta: Tarjeta) throws {
        _ = try persistence.dbQueue.write { db in
            try tarjeta.delete(db)
        }
    }
}
