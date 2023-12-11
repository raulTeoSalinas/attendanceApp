//
//  RecordView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct RecordView: View {
    
//    var typeEntity: String
    let idRecord: String
//
//    let persistence: Persistence = Persistence()
//    let alumnoFound: Alumno
//    let profesorFound: Profesor
    let record: Any
    let persistence: Persistence = Persistence();
    
    @StateObject var viewModel: ViewModel
    
    init(idRecord: String, record: Any, viewModel: ViewModel) {
        self.idRecord = idRecord
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.record = record
    }
    
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
        if record is Alumno {
            let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId)
            persistence.updateAlumno(withId: idRecord, record: alumno)
            viewModel.updateAlumno(withId: idRecord, record: alumno)

            
        } else if record is Profesor {
            // Realizar acciones específicas para un Profesor
           
        } else {
            // Manejar otros casos si es necesario
            print("El tipo de objeto no es ni Alumno ni Profesor")
        }
    }
    
    var body: some View {
        VStack() {
            
            HStack{
                Text("ID:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese id", text: $id)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Nombre:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese nombre", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Apellido 1:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese apellido 1", text: $lastname1)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Apellido 2:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese apellido 2", text: $lastname2)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack{
                Text("Número de Cuenta:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading)
                TextField("Ingrese número de cuenta", text: $academicId)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .onAppear {
                updateProperties()
            }
            .navigationBarItems(
                trailing: Button(action: {
                    handleUpdate()
                }) {
                    Text("Actualizar")
                }
            )

    }
}

//#Preview {
//    RecordView(typeEntity: "Alumno", idRecord: "4120")
//}
