//
//  AlumnoDAO.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation
/// `AlumnoDAO` es una clase que proporciona métodos para realizar operaciones de acceso a datos
/// relacionadas con la entidad ``Alumno`` en la base de datos, utilizando la capa de persistencia proporcionada.
class AlumnoDAO {
    /// La capa de persistencia utilizada para acceder a la base de datos.
    var persistence: Persistence
    
    /// Inicializa una nueva instancia de `AlumnoDAO`.
        ///
        /// - Parameter persistence: La capa de persistencia a utilizar.
    init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    /// Crea un nuevo registro de alumno en la base de datos.
        ///
        /// - Parameter alumno: El objeto `Alumno` que se va a insertar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la inserción del alumno.
    func createAlumno(alumno: Alumno) throws {
        try persistence.dbQueue.write { db in
            try alumno.save(db)
        }
    }
    
    /// Obtiene un alumno específico de la base de datos mediante su identificador.
        ///
        /// - Parameter id: El identificador del alumno que se desea obtener.
        /// - Returns: El objeto `Alumno` encontrado o `nil` si no se encuentra ningún registro.
        /// - Throws: Se lanza un error si ocurre algún problema durante la lectura de datos.
    func getAlumno(id: Int64) throws ->  Alumno? {
        return try persistence.dbQueue.read { db in
            try Alumno.fetchOne(db)
        }
    }
    
    /// Obtiene todos los alumnos almacenados en la base de datos.
       ///
       /// - Returns: Un arreglo de objetos `Alumno` que representan a todos los alumnos.
       /// - Throws: Se lanza un error si ocurre algún problema durante la lectura de datos.
    func getAlumnos() throws -> [Alumno] {
        return try persistence.dbQueue.read { db in
            try Alumno.fetchAll(db)
        }
    }
    
    /// Actualiza la información de un alumno existente en la base de datos.
        ///
        /// - Parameter record: El objeto `Alumno` con la información actualizada.
        /// - Throws: Se lanza un error si ocurre algún problema durante la actualización del alumno.
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
    
    /// Elimina un registro de alumno de la base de datos.
        ///
        /// - Parameter alumno: El objeto `Alumno` que se va a eliminar.
        /// - Throws: Se lanza un error si ocurre algún problema durante la eliminación del alumno.
    func deleteAlumno(alumno: Alumno) throws {
        _ = try persistence.dbQueue.write { db in
            try alumno.delete(db)
        }
    }
}
