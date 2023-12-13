//
//  AlumnoDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class AlumnoDAO {
    
    var persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    func createAlumno(alumno: Alumno) throws {
        try persistence.dbQueue.write { db in
            try alumno.save(db)
        }
    }
    
    func getAlumno(id: Int64) throws ->  Alumno? {
        return try persistence.dbQueue.read { db in
            try Alumno.fetchOne(db)
        }
    }
    
    func getAlumnos() throws -> [Alumno] {
        return try persistence.dbQueue.read { db in
            try Alumno.fetchAll(db)
        }
    }
    
    func updateAlumno(record: Alumno) throws {
        try persistence.dbQueue.write { db in
            guard var alumno = try Alumno.fetchOne(db, key: record.id) else { return }
            alumno.name = record.name
            alumno.lastname1 = record.lastname1
            alumno.lastname2 = record.lastname2
            alumno.academicId = record.academicId
            alumno.idTarjeta = record.idTarjeta
            try alumno.update(db)
        }
    }
    
    
    func deleteAlumno(alumno: Alumno) throws {
        _ = try persistence.dbQueue.write { db in
            try alumno.delete(db)
        }
    }
}
