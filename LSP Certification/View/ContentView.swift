//
//  ContentView.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Text("My Library")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Enter your name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Sign In")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                }
            }
            .onAppear {
                viewModel.errorMessage = nil
            }
            .navigationDestination(isPresented: $viewModel.showAdmin) {
                AdminDashboardView()
            }
            .navigationDestination(isPresented: $viewModel.showMember) {
                CatalogView()
            }
        }
    }
}

#Preview {
    ContentView()
}
