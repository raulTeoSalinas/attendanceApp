//
//  AsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

struct AsistenciaView: View {
    
    @EnvironmentObject var mainVM: MainViewModel
    
    let grupoSelected: Grupo
    @State private var tarjetaId: String = ""
    
    func handleAdd(){
        mainVM.asistenciaViewModel.createAsistencia(idGrupo: grupoSelected.id!, idTarjeta: tarjetaId, alumnos: mainVM.alumnoViewModel.alumnos)
        mainVM.objectWillChange.send()
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
                        
                        mainVM.tarjetaViewModel.handleScan(completion: { readId in
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
                ForEach(mainVM.asistenciaViewModel.asistencias) { asistencia in
                    if let alumno = mainVM.alumnoViewModel.alumnos.first(where: { $0.id == asistencia.idAlumno && grupoSelected.id == asistencia.idGrupo }) {
                        
                        Text("Alumno: \(alumno.lastname1) \(alumno.lastname2) \(alumno.name)\nFecha: \(asistencia.time.formatted(.dateTime.month().day().year().hour().minute()))")
                        
                    }
                }
            }
        }
    }
}
