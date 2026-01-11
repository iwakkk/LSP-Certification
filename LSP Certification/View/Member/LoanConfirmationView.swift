//
//  LoanConfirmationView.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import SwiftUI

struct LoanConfirmationView: View {
    
    let book: Book
    @Binding var loanDate: Date
    
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var viewModel: CatalogViewModel
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .center){
                
                
                    
                    
                    VStack(alignment: .leading){
                        Text(book.title)
                            .font(.headline)
                        
                        
                        Text(book.author)
                            .foregroundColor(.secondary)
                        
                        DatePicker("Date: ", selection: $loanDate, displayedComponents: .date)
                        
                    }
                    .padding()
                    
                
                
              
                
                
                
            }
            
            .padding()
            .presentationDetents([.fraction(0.5)])
            .navigationTitle("Confirm Loan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Confirm") {
                        
                        Task{
                            do {
                                try await viewModel.addLoan(for: book, loanDate: loanDate)
                                    dismiss()
                            }
                            catch {
                                print("Failed to add loan: \(error)")
                            }
                        }
                        
                    }
                }
            }
            
        }
    }
    
}

