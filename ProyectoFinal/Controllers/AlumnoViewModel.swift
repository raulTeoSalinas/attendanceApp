//
//  AlumnoViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

class AlumnoViewModel: ObservableObject {
    
    @Published var alumnos = [Alumno]()
    
    private let alumnosDAO: AlumnoDAO
    
    init(alumnosDAO: AlumnoDAO) {
        self.alumnosDAO = alumnosDAO
        alumnos = try! alumnosDAO.getAlumnos()
    }
    
    func createAlumno(alumno: Alumno) {
        do {
            try alumnosDAO.createAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch {
            print("Error al crear el alumno: \(error)")
        }
    }
    
    func updateAlumno(record: Alumno) {
        do {
            try alumnosDAO.updateAlumno(record: record)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func deleteAlumno(alumno: Alumno){
        do {
            try alumnosDAO.deleteAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
}
