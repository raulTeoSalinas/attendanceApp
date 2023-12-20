//
//  AlumnoViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

/// `AlumnoViewModel` es una clase observable que gestiona la lógica relacionada con la entidad ``Alumno``.
class AlumnoViewModel: ObservableObject {
    
    /// Una lista de objetos ``Alumno``.
    @Published var alumnos = [Alumno]()
    
    /// El objeto ``AlumnoDAO`` utilizado para realizar operaciones de acceso a datos relacionadas con Alumnos.
    private let alumnosDAO: AlumnoDAO
    
    /// Inicializa una nueva instancia de `AlumnoViewModel`.
        ///
        /// - Parameter alumnosDAO: El objeto ``AlumnoDAO`` que proporciona operaciones de acceso a datos.
    init(alumnosDAO: AlumnoDAO) {
        self.alumnosDAO = alumnosDAO
        alumnos = try! alumnosDAO.getAlumnos()
    }
    
    /// Crea un nuevo alumno y actualiza la lista de alumnos.
        ///
        /// - Parameter alumno: El objeto ``Alumno`` que se va a crear.
    func createAlumno(alumno: Alumno) {
        do {
            try alumnosDAO.createAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch {
            print("Error al crear el alumno: \(error)")
        }
    }
    
    /// Actualiza la información de un alumno existente y actualiza la lista de alumnos.
        ///
        /// - Parameter record: El objeto ``Alumno`` con la información actualizada.
    func updateAlumno(record: Alumno) {
        do {
            try alumnosDAO.updateAlumno(record: record)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    /// Elimina un alumno y actualiza la lista de alumnos.
        ///
        /// - Parameter alumno: El objeto ``Alumno`` que se va a eliminar.
    func deleteAlumno(alumno: Alumno){
        do {
            try alumnosDAO.deleteAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
}
