//
//  ReportAsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import SwiftUI

/// `ReportAsistenciaView` es una vista que muestra un informe de asistencias para un grupo específico.
struct ReportAsistenciaView: View {
    
    /// ViewModel principal que gestiona los datos de la aplicación.
    @EnvironmentObject var mainVM: MainViewModel

    
    @State private var alumnoAsistenciaCount: [String: Int] = [:]
    
    /// Grupo seleccionado para el cual se generará el informe de asistencias.
    let grupoSelected: Grupo

    
    func getAlumnoAsistenciaCount(){
        alumnoAsistenciaCount = mainVM.asistenciaViewModel.getAlumnoAsistenciaCount(grupo: grupoSelected, alumnos: mainVM.alumnoViewModel.alumnos)
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

