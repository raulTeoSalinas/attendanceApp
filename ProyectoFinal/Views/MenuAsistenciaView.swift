//
//  MenuAsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import SwiftUI

struct MenuAsistenciaView: View {
    
    let grupoSelected: Grupo
    
    var body: some View {
        List{
            NavigationLink(destination: AsistenciaView(grupoSelected: grupoSelected)) {
                Text("Tomar asistencia")
            }
            NavigationLink(destination: ReportAsistenciaView(grupoSelected: grupoSelected)) {
                Text("Ver informe (contador)")
            }
        }.navigationTitle(grupoSelected.materia)
    }
}


