//
//  AddView.swift
//  TodoList
//
//  Created by Beliz on 6/9/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var textFieldText: String = ""
    @EnvironmentObject var listViewModel: ListViewModel

    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
     
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
                }
            }
            .padding(13)
            
        }
        .navigationTitle("Add an item")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count <= 0 {
            alertTitle = "Please enter a valid text"
            showAlert.toggle()
            return false
        }
        return true
     }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}


#Preview {

    NavigationView {
        AddView()
    }
    .preferredColorScheme(.light)
    .environmentObject(ListViewModel())
}
 
#Preview {

    NavigationView {
        AddView()
    }
    .preferredColorScheme(.dark)
    .environmentObject(ListViewModel())
}
 
