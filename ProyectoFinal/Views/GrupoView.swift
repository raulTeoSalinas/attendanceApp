//
//  GrupoView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

struct GrupoView: View {
    
    let record: Grupo?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var materia: String = ""
    @State private var carrera: String = ""
    
    private func updateProperties() {
        if let record = record {
            materia = record.materia
            carrera = record.carrera
        }
    }
    
    func handleUpdate() {
        let grupo = Grupo(materia: materia, carrera: carrera)
        
        viewModel.updateGrupo(record: grupo)
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        guard let grupo = record else { return }
        viewModel.deleteGrupo(grupo: grupo)
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        
        let grupo = Grupo(materia: materia, carrera: carrera)
        
        viewModel.createGrupo(grupo: grupo)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        Form {
            HStack{
                Text("Materia:")
                TextField("Ingrese materia", text: $materia)
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Carrera:")
                TextField("Ingrese carrera", text: $carrera)
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            if record != nil {
                Button(action: {
                    handleDelete()
                }) {
                    Text("Borrar")
                }
            }
            
            
        }
        .onAppear {
            updateProperties()
        }
        .navigationBarItems(
            trailing: {
                if record == nil {
                    Button(action: {
                        handleCreate()
                    }) {
                        Text("Crear")
                    }
                } else {
                    Button(action: {
                        handleUpdate()
                    }) {
                        Text("Actualizar")
                    }
                }
            }()
        )
    }
}
