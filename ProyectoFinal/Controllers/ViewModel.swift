//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

class ViewModel: ObservableObject {
    
    @Published var alumnos = [Alumno]()
    @Published var grupos = [Grupo]()
    @Published var tarjetas = [Tarjeta]()
    
    private let alumnosDAO: AlumnoDAO
    private let grupoDAO: GrupoDAO
    private let tarjetaDAO: TarjetaDAO
    private let serviceNFC: ServiceNFC
    
    init(
        alumnosDAO: AlumnoDAO,
        grupoDAO: GrupoDAO,
        tarjetaDAO: TarjetaDAO
    ) {
        self.alumnosDAO = alumnosDAO
        self.grupoDAO = grupoDAO
        self.tarjetaDAO = tarjetaDAO
        
        
        alumnos = try! alumnosDAO.getAlumnos()
        grupos = try! grupoDAO.getGrupos()
        tarjetas = try! tarjetaDAO.getTarjetas()
        serviceNFC = ServiceNFC()
    }
    
    func updateAlumno(record: Alumno) {
        do {
            try alumnosDAO.updateAlumno(record: record)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func updateGrupo(record: Grupo) {
        do {
            try grupoDAO.updateGrupo(record: record)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func deleteAlumno(alumno: Alumno){
        do {
            try alumnosDAO.deleteAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func deleteTarjeta(withId id: String){
        do {
            try tarjetaDAO.deleteTarjeta(withId: id)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func deleteGrupo(grupo: Grupo){
        do {
            try grupoDAO.deleteGrupo(record: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func createAlumno(alumno: Alumno){
        do {
            try alumnosDAO.createAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func createGrupo(grupo: Grupo){
        do {
            try grupoDAO.createGrupo(grupo: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }

    func createTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.createTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func getGrupoFromAlumno(idGrupo: Int64?) -> Grupo? {
        guard idGrupo != nil else { return nil }
        return grupos.filter { $0.id == idGrupo }.first
    }
    
    func handleScan() -> String {
        return serviceNFC.read()
    }
}
