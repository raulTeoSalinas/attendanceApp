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
    
    @State private var selectedIdTarjeta: Int = 0
    
    private func updateProperties() {
            if let alumno = record as? Alumno {
                id = alumno.id
                name = alumno.name
                lastname1 = alumno.lastname1
                lastname2 = alumno.lastname2
                academicId = alumno.academicId
                
                // Suponiendo que alumno es un objeto y viewModel.tarjetas es una colección de objetos
                if let index = viewModel.tarjetas.firstIndex(where: { $0.id == alumno.idTarjeta }) {
                    selectedIdTarjeta = index
                    print(index)
                } else {
                    // Manejar el caso donde no se encuentra el idTarjeta en viewModel.tarjetas
                    selectedIdTarjeta = 0
                }




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
            let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId, idTarjeta: viewModel.tarjetas[selectedIdTarjeta].id)

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
            let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId, idTarjeta: "hola")
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
      
            Form{
                if idRecord.isEmpty {
                    HStack{
                        Text("ID:")

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

                    TextField("Ingrese nombre", text: $name)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Apellido 1:")

                    TextField("Ingrese apellido 1", text: $lastname1)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Apellido 2:")

                    TextField("Ingrese apellido 2", text: $lastname2)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Número de Cuenta:")
 
                    TextField("Ingrese número de cuenta", text: $academicId)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                
                Picker("Tarjeta", selection: $selectedIdTarjeta) {
                        ForEach(Array(viewModel.tarjetas.enumerated()), id: \.1.id) { index, tarjeta in
                            Text(tarjeta.id)
                                .tag(index) // Asigna un valor único (índice) como tag
                        }
                }


                
                
                
                
                //            HStack{
                //                Text("Tarjeta:")
                //                        .font(.caption)
                //                        .foregroundColor(.gray)
                //                        .padding(.leading)
                //                TextField("Ingrese tarjeta", text: $idTarjeta)
                //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                //                Button(action: {
                //                        handleScan()
                //                }) {
                //                    Text("Scanear")
                //                }
                //            }
                
                
                if !idRecord.isEmpty {
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
