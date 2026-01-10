//
//  BookCard.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import SwiftUI

struct BookCard: View {
    
    let book: Book
    
    var body: some View {
        VStack(spacing: 8) {
            Image("HarryPotter")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .shadow(radius: 4)
            
            VStack{
                Text(book.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                
            }
            .frame(height: 60)
            
        }
        .frame(width: 150, height: 250)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

//#Preview {
//    BookCard(book: Book)
//}
