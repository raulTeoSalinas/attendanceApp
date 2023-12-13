//
//  GrupoView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

struct GrupoView: View {
    
    let grupo: Grupo?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var materia: String = ""
    @State private var carrera: String = ""
    
    private func updateProperties() {
        if let grupo = grupo {
            materia = grupo.materia
            carrera = grupo.carrera
        }
    }
    
    func handleUpdate() {
        
        guard var grupo = grupo else { return }
        
        grupo = Grupo(id: grupo.id, materia: materia, carrera: carrera)
        
        viewModel.updateGrupo(record: grupo)
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        guard let grupo = grupo else { return }
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
            
            if grupo != nil {
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
                if grupo == nil {
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
