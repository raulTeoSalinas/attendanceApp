//
//  GrupoView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import SwiftUI

struct GrupoView: View {
    
    let idRecord: String
    
    let record: Grupo?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var id: String = ""
    @State private var materia: String = ""
    @State private var carrera: String = ""

    
    private func updateProperties() {
        if let record = record {
            id = record.id
            materia = record.materia
            carrera = record.carrera
        }
    }
    
    func handleUpdate() {
        let grupo = Grupo(id: id, materia: materia, carrera: carrera)
            
        viewModel.updateGrupo(withId: idRecord, record: grupo)
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        
        viewModel.deleteGrupo(withId: idRecord)
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
            
        let grupo = Grupo(id: id, materia: materia, carrera: carrera)
        
        viewModel.createGrupo(grupo: grupo)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        VStack() {
            
            if idRecord.isEmpty{
                HStack{
                Text("ID:")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading)
                TextField("Ingrese id", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            HStack{
                Text("Materia:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese materia", text: $materia)

                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Carrera:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese carrera", text: $carrera)

                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        
            if !idRecord.isEmpty {
                Button(action: {
                    handleDelete()
                }) {
                    Text("Borrar")
                }
            }
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .onAppear {
                updateProperties()
            }
            .navigationBarItems(
                trailing: {
                    if idRecord.isEmpty {
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

//#Preview {
//    RecordView(typeEntity: "Alumno", idRecord: "4120")
//}

