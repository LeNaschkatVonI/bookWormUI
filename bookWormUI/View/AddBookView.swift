//
//  AddBookView.swift
//  bookWormUI
//
//  Created by Максим Нуждин on 23.06.2021.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var genre = ""
    @State private var author = ""
    @State private var review = ""
    @State private var rating: Int = 3
    var disabled: Bool {
        if title.isEmpty || genre.isEmpty || author.isEmpty || review.isEmpty {
            return true
        }
        
        return false
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        Form {
            Section {
                TextField("name of the book", text: $title)
                TextField("Author`s name", text: $author)
                
                Picker("genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section {
                RatingView(rating: $rating)
            }
            Section {
                TextField("write review", text: $review)
                    .frame(height: 150, alignment: .topLeading)
            }
            Section {
                Button("save") {
                    let book = Book(context: moc)
                    book.id = UUID()
                    book.author = author
                    book.title = title
                    book.rating = Int16(rating)
                    book.review = review
                    book.genre = genre
                    
                    try? moc.save()
                    presentationMode.wrappedValue.dismiss()
                }
            }.disabled(disabled)
            .navigationTitle("Add book")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
