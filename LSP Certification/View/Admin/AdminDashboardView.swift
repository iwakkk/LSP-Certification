//
//  AdminDashboardView.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import SwiftUI

struct AdminDashboardView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = AdminDashboardViewModel()
    
    @State private var selectedFilter = "ongoing"
    
    var filteredLoans: [LoanWithDetails] {
        switch selectedFilter {
        case "done":
            return viewModel.loansWithDetails.filter {
                $0.actualReturnDate != nil
            }

        case "ongoing":
            return viewModel.loansWithDetails.filter {
                $0.actualReturnDate == nil
            }

        default:
            return viewModel.loansWithDetails
        }
    }


    
    var body: some View {
        
        NavigationStack{
            
            List(viewModel.loansWithDetails) { loans in
                VStack(alignment: .leading) {
                    
                    HStack{
                        Text("\(loans.userName)")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(loans.actualReturnDate == nil ? "Not returned" : "Returned at \(loans.actualReturnDate!.formatted(.dateTime.day().month().year()))")
                            .foregroundColor(loans.actualReturnDate == nil ? .red : .green)
                        
                    }
                    .padding(.bottom, 5)
                    
                    
                    Text("\(loans.bookTitle)")
                    Text("Return date: \(loans.returnDate.formatted(.dateTime.day().month(.wide).year()))")
                   
                    
                    
                    
                    
                }
                
            }
            .navigationTitle("Admin")
            .navigationBarTitleDisplayMode( .inline)
            .navigationBarBackButtonHidden(true)
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
            }
            .task {
                await viewModel.loadLoansWithDetails()
            }
            
        }
    }
}

#Preview {
    AdminDashboardView()
}
