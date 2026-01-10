//
//  MyLoans.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import SwiftUI

struct MyLoansView: View {
    
    let loans: [Loan] = []
    @State private var viewModel = MyLoansViewModel()
    @Bindable var catalogViewModel: CatalogViewModel
    
    var body: some View {
        NavigationStack{
            List(viewModel.loans) { loan in
                
                if let book = catalogViewModel.books.first(where: { $0.id == loan.bookId }) {
                    VStack(alignment: .leading) {
                        
                        Text(book.title)
                            .font(.headline)
                        
                        Text(book.author)
                            .foregroundColor(.secondary)
                        
                        Text("Loan: \(loan.loanDate.formatted(.dateTime.day().month(.wide).year()))")
                        Text("Return: \(loan.returnDate.formatted(.dateTime.day().month(.wide).year()))")
                        
                        if let actualReturnDate = loan.actualReturnDate {
                            Text("Returned at: \(actualReturnDate.formatted(.dateTime.day().month(.wide).year()))")
                                .foregroundColor(.green)
                        } else {
                            Button {
                                Task {
                                    try? await viewModel.returnLoan(loan)
                                    await catalogViewModel.loadBooks()
                                }
                            } label: {
                                Text("Return Now")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                        }
                    }
                    .padding(4)
                }
            }
            .navigationTitle("My Loans")
            .task {
                await catalogViewModel.loadBooks()
                await viewModel.loadLoansByUser()
            }
        }
    }
}
