//
//  GrupoView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

/// `GrupoView` es una vista que permite la creación, actualización o eliminación de información sobre un grupo.
struct GrupoView: View {
    
    /// El ViewModel principal de la aplicación.
    @EnvironmentObject var mainVM: MainViewModel
    
    /// Control de presentación para navegar hacia atrás.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var materia: String = ""
    @State private var carrera: String = ""
    
    /// Grupo existente (si se está actualizando) o nulo (si se está creando uno nuevo).
    let grupo: Grupo?
    
    private func updateProperties() {
        if let grupo = grupo {
            materia = grupo.materia
            carrera = grupo.carrera
        }
    }
    
    func handleUpdate() {
        
        guard var grupo = grupo else { return }
        
        grupo = Grupo(id: grupo.id, materia: materia, carrera: carrera)
        
        mainVM.grupoViewModel.updateGrupo(record: grupo)
        mainVM.objectWillChange.send()
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        guard let grupo = grupo else { return }
        mainVM.grupoViewModel.deleteGrupo(grupo: grupo)
        mainVM.objectWillChange.send()
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        
        let grupo = Grupo(materia: materia, carrera: carrera)
        
        mainVM.grupoViewModel.createGrupo(grupo: grupo)
        mainVM.objectWillChange.send()
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
