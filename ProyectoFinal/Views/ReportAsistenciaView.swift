//
//  ReportAsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import SwiftUI

struct ReportAsistenciaView: View {
    
    @EnvironmentObject var asistenciaViewModel: AsistenciaViewModel
    @EnvironmentObject var alumnoViewModel: AlumnoViewModel

    
    @State private var alumnoAsistenciaCount: [String: Int] = [:]
    
    let grupoSelected: Grupo

    
    func getAlumnoAsistenciaCount(){
        alumnoAsistenciaCount = asistenciaViewModel.getAlumnoAsistenciaCount(grupo: grupoSelected, alumnos: alumnoViewModel.alumnos)
    }
    
    var body: some View {
        List{
            Section(header: Text("Informe Asistencias")){
                ForEach(alumnoAsistenciaCount.keys.sorted(), id: \.self) { nombre in
                    if let asistencias = alumnoAsistenciaCount[nombre] {
                        Text("\(nombre)\nNúmero Asistencias: \(asistencias)")
                    }
                }

            }
                
        }.onAppear{getAlumnoAsistenciaCount()}
    }
}

