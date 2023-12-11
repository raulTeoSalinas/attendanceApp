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
    
    func updateAlumno(withId id: String, record: Alumno) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if var alumno = try Alumno.fetchOne(db, key: id) {
                    // Actualizar los campos necesarios
                    alumno.id = record.id
                    alumno.name = record.name
                    alumno.lastname1 = record.lastname1
                    alumno.lastname2 = record.lastname2
                    alumno.academicId = record.academicId
                    // Ejecutar la actualización en la base de datos
                    try alumno.update(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró un alumno con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al actualizar el alumno: \(error)")
        }
    }
    
    func updateProfesor(withId id: String, record: Profesor) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if var profesor = try Profesor.fetchOne(db, key: id) {
                    // Actualizar los campos necesarios
                    profesor.id = record.id
                    profesor.name = record.name
                    profesor.lastname1 = record.lastname1
                    profesor.lastname2 = record.lastname2
                    profesor.academicId = record.academicId
                    // Ejecutar la actualización en la base de datos
                    try profesor.update(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró un alumno con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al actualizar el alumno: \(error)")
        }
    }
    
    func deleteAlumno(withId id: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if let alumno = try Alumno.fetchOne(db, key: id) {
                    // Ejecutar la eliminación en la base de datos
                    try alumno.delete(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró un alumno con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar el alumno: \(error)")
        }
    }
    
    func deleteProfesor(withId id: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if let profesor = try Profesor.fetchOne(db, key: id) {
                    // Ejecutar la eliminación en la base de datos
                    try profesor.delete(db)
                } else {
                    // Manejar el caso en el que el profesor con el ID dado no fue encontrado
                    print("No se encontró un profesor con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar el profesor: \(error)")
        }
    }
    
    func createProfesor(profesor: Profesor) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear un nuevo profesor en la base de datos
                try profesor.save(db)
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear el profesor: \(error)")
        }
    }
    
    func createAlumno(alumno: Alumno) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear un nuevo alumno en la base de datos
                try alumno.save(db)
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear el alumno: \(error)")
        }
    }


    
}
