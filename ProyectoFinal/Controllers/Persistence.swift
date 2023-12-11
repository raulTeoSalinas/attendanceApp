//
//  Persistence.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

struct Persistence {
    
    init(){
        
        do {
            
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            

            let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")

            // 2. Define the database schema
            try dbQueue.write { db in
                try db.create(table: "alumno") { t in
                    t.primaryKey("id", .text).notNull()
                    t.column("name", .text).notNull()
                    t.column("lastname1", .text).notNull()
                    t.column("lastname2", .text).notNull()
                    t.column("academicId", .text).notNull()
                }
            }
            
            try dbQueue.write { db in
                try db.create(table: "profesor") { t in
                    t.primaryKey("id", .text).notNull()
                    t.column("name", .text).notNull()
                    t.column("lastname1", .text).notNull()
                    t.column("lastname2", .text).notNull()
                    t.column("academicId", .text).notNull()
                }
            }

            // 4. Write and read in the database
            try dbQueue.write { db in
                try Alumno(id: "214", name: "Arthur", lastname1: "Blade", lastname2: "Smith", academicId: "3162").insert(db)
                try Alumno(id: "2144", name: "Barbara", lastname1: "Lopez", lastname2: "Velazquez", academicId: "3160").insert(db)
                try Alumno(id: "2141", name: "Ivan", lastname1: "Perez", lastname2: "Gutierrez", academicId: "3164").insert(db)
                try Alumno(id: "2142", name: "Ximena", lastname1: "Martinez", lastname2: "Salinas", academicId: "3165").insert(db)
            }
            
            try dbQueue.write { db in
                try Profesor(id: "214", name: "Carlos", lastname1: "Gomez", lastname2: "Lopez", academicId: "2162").insert(db)
                try Profesor(id: "2144", name: "Ana", lastname1: "Gutierrez", lastname2: "Fernandez", academicId: "2160").insert(db)
                try Profesor(id: "2141", name: "Juan", lastname1: "Diaz", lastname2: "Hernandez", academicId: "2164").insert(db)
                try Profesor(id: "2142", name: "Luis", lastname1: "Sanchez", lastname2: "Ramos", academicId: "2165").insert(db)
            }
            
            
            
        } catch {
            
        }
        
    }
    
    func profesores() -> [Profesor] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try Profesor.fetchAll(db)
        }
    }
    
    func alumnos() -> [Alumno] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try Alumno.fetchAll(db)
        }
    }
    
    
}
