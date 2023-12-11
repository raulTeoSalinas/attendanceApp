//
//  RecordView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct RecordView: View {
    
    let typeEntity: String
    let idRecord: String

    let record: Any
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var id: String = ""
    @State private var name: String = ""
    @State private var lastname1: String = ""
    @State private var lastname2: String = ""
    @State private var academicId: String = ""
    
    private func updateProperties() {
            if let alumno = record as? Alumno {
                id = alumno.id
                name = alumno.name
                lastname1 = alumno.lastname1
                lastname2 = alumno.lastname2
                academicId = alumno.academicId
            } else if let profesor = record as? Profesor {
                id = profesor.id
                name = profesor.name
                lastname1 = profesor.lastname1
                lastname2 = profesor.lastname2
                academicId = profesor.academicId
            }
        }
    
    func handleUpdate() {
        switch typeEntity {
        case "Alumnos":
            let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId)
            viewModel.updateAlumno(withId: idRecord, record: alumno)
        case "Profesores":
            let profesor = Profesor(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId)
            viewModel.updateProfesor(withId: idRecord, record: profesor)

        default:
            // Manejar otros casos si es necesario
            print("El tipo de entidad no es válido")
        }
        
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        switch typeEntity {
        case "Alumnos":
            viewModel.deleteAlumno(withId: idRecord)
        case "Profesores":
            viewModel.deleteProfesor(withId: idRecord)
        default:
            // Manejar otros casos si es necesario
            print("El tipo de entidad no es válido")
        }
        
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        
        switch typeEntity {
        case "Alumnos":
            let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId)
            viewModel.createAlumno(alumno: alumno)
        case "Profesores":
            let profesor = Profesor(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId)
            viewModel.createProfesor(profesor: profesor)
        default:
            // Manejar otros casos si es necesario
            print("El tipo de entidad no es válido")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleScan() {
        let randomString = String((0..<10).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()! })
        id = randomString
    }
    
    var body: some View {
        VStack() {
            
            if idRecord.isEmpty {
                HStack{
                    Text("ID:")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    TextField("Ingrese id", text: $id)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        handleScan()
                    }) {
                        Text("Scanear")
                    }
                }
            }
           
            HStack{
                Text("Nombre:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese nombre", text: $name)

                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Apellido 1:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese apellido 1", text: $lastname1)

                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Apellido 2:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese apellido 2", text: $lastname2)

                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Número de Cuenta:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese número de cuenta", text: $academicId)
  
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
