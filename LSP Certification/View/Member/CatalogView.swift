//
//  CatalogView.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import SwiftUI

struct CatalogView: View {
    
    @State private var viewModel = CatalogViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showMyLoans = false
    @State private var showConfirmation = false
    @State private var selectedBook: Book?
    @State private var loanDate = Date()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            
            // Book List
            ScrollView{
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.books) { book in
                        BookCard(book: book)
                            .opacity(book.availability == "unavailable" ? 0.4 : 1.0)
                            .overlay {
                                if book.availability == "unavailable" {
                                    Text("Unavailable")
                                        .font(.caption)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.red)
                                        .cornerRadius(20)
                                }
                            }
                            .onTapGesture {
                                guard book.availability == "available" else { return }
                                selectedBook = book
                                loanDate = Date()
                                showConfirmation = true
                                
                                
                            }
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("Catalog")
        .navigationBarBackButtonHidden(true)
        .task {
           await viewModel.loadBooks()
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    
                    if let user = SessionManager.shared.currentUser {
                        Label(user.name, systemImage: "person.fill")
                    }
                    
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Label("Logout", systemImage: "arrow.backward.square")
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .font(.title2)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showMyLoans = true
                }) {
                    Image(systemName: "book.circle")
                }
            }
        }
        .sheet(isPresented: $showMyLoans) {
            MyLoansView(
                catalogViewModel: viewModel
            )
        }
        .sheet(isPresented: $showConfirmation) {
            if let book = selectedBook {
                LoanConfirmationView(
                    book: book,
                    loanDate: $loanDate,
                    viewModel: viewModel
                )
            }
        }
       
        
    }
        
}

#Preview {
    CatalogView()
}
