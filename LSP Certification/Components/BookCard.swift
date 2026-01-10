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
            
        }
        .padding()
    }
}

//#Preview {
//    BookCard(book: Book)
//}
