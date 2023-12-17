//
//  Migrations.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation
import GRDB

enum MigrationVersion: String {
    
    case v1 = "v1"
    case v2 = "v2"
}

class Migrations {
    
    func v1(dbQueue: DatabaseQueue) throws {
        
        var migrator = DatabaseMigrator()
        // 1st migration
        migrator.registerMigration(MigrationVersion.v1.rawValue) { db in
            
            try db.create(table: "tarjeta") { t in
                t.primaryKey("id", .text).notNull()
            }
            
            try db.create(table: "grupo") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("materia", .text).notNull()
                t.column("carrera", .text).notNull()
            }
            
            try db.create(table: "alumno") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("lastname1", .text).notNull()
                t.column("lastname2", .text).notNull()
                t.column("academicId", .text).notNull()
                t.column("idTarjeta", .text).notNull()
                t.column("idGrupo", .integer)

                t.foreignKey(["idTarjeta"], references: "tarjeta", onDelete: .cascade)
                t.foreignKey(["idGrupo"], references: "grupo", onDelete: .restrict)
            }
            
            try db.create(table: "asistencia") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("time", .datetime).notNull()
                t.column("idGrupo", .integer).notNull()
                t.column("idAlumno", .integer).notNull()

                t.foreignKey(["idGrupo"], references: "grupo", onDelete: .restrict)
                t.foreignKey(["idAlumno"], references: "alumno", onDelete: .restrict)
            }
        }
        
        try migrator.migrate(dbQueue)
    }
}
