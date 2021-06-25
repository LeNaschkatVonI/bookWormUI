//
//  ContentView.swift
//  bookWormUI
//
//  Created by Максим Нуждин on 23.06.2021.
//c

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.colorScheme) var CS
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books, id: \.id) { book in
                        NavigationLink(
                            destination: DetailView(book: book),
                            label: {
                                EmojiRatingview(rating: book.rating).font(.largeTitle)
                                VStack {
                                    Text(book.title ?? "unknown title")
                                        .font(.headline)
                                    Text(book.author ?? "unknown author")
                                }
                            })
                    }.onDelete(perform: { indexSet in
                        deleteBooks(at: indexSet)
                    })
                }
                NavigationLink(
                    destination: AddBookView()  ,
                    label: {
                        Text("add new book")
                    })
            }
            .navigationBarItems(leading: Button("toggle CS") {
               //
            },trailing: EditButton())
            .navigationBarTitle("BookWormUI")
        }
    }
    
    func deleteBooks(at offSets: IndexSet) {
        for offset in offSets {
            let book = books[offset]
            
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
