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
    @Published var asistencias = [Asistencia]()
    
    private let alumnosDAO: AlumnoDAO
    private let grupoDAO: GrupoDAO
    private let tarjetaDAO: TarjetaDAO
    private let asistenciaDAO: AsistenciaDAO
    private let serviceNFC: ServiceNFC
    
    init(
        alumnosDAO: AlumnoDAO,
        grupoDAO: GrupoDAO,
        tarjetaDAO: TarjetaDAO,
        asistenciaDAO: AsistenciaDAO
    ) {
        self.alumnosDAO = alumnosDAO
        self.grupoDAO = grupoDAO
        self.tarjetaDAO = tarjetaDAO
        self.asistenciaDAO = asistenciaDAO
        
        
        alumnos = try! alumnosDAO.getAlumnos()
        grupos = try! grupoDAO.getGrupos()
        tarjetas = try! tarjetaDAO.getTarjetas()
        asistencias = try! asistenciaDAO.getAsistencias()
        serviceNFC = ServiceNFC()
    }
        
    func handleScan(completion: @escaping (String) -> Void) {
        
        serviceNFC.read(completion: completion)
    }
    
    


    
}
