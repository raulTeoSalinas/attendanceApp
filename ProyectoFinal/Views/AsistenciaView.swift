//
//  AsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

struct AsistenciaView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    let grupoSelected: Grupo
    @State private var tarjetaId: String = ""
    
    func handleAdd(){
        viewModel.createAsistencia(idGrupo: grupoSelected.id!, idTarjeta: tarjetaId)
        tarjetaId = ""
    }
    
    var body: some View {
        List {
            Section(header: Text("Pasar Asistencia")) {
                HStack{
                    Text("Tarjeta:")
                    TextField("Ingrese tarjeta", text: $tarjetaId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        
                        viewModel.handleScan(completion: { readId in
                            self.tarjetaId = readId
                        })
                        
                        
                    }) {
                        Text("Scanear")
                    }
                    
                }
                Button(action: {
                    handleAdd()
                }) {
                    Text("Aceptar")
                }
            }
            
            Section(header: Text("Lista de asistencias")){
                ForEach(viewModel.asistencias) { asistencia in
                    if let alumno = viewModel.alumnos.first(where: { $0.id == asistencia.idAlumno && grupoSelected.id == asistencia.idGrupo }) {
                        
                        Text("Alumno: \(alumno.lastname1) \(alumno.lastname2) \(alumno.name)\nFecha: \(asistencia.time.formatted(.dateTime.month().day().year().hour().minute()))")
                        
                    }
                }
            }
        }
    }
}
