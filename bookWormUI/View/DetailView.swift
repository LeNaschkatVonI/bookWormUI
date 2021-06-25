//
//  DetailView.swift
//  bookWormUI
//
//  Created by Максим Нуждин on 24.06.2021.
//
import CoreData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "belly3")
                        .frame(maxWidth: geo.size.width)
                    Text(book.genre?.uppercased() ?? "Unknown genre")
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                        .padding(10)
                }
                Text(book.author ?? "unknown author")
                    .foregroundColor(.secondary)
                    .font(.title)
                Text(book.review ?? "no review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Spacer()
                    Text("In library from: \(book.date ?? "\n'cant detect added date'")")
                        .foregroundColor(.secondary.opacity(0.65))
                        .padding(.trailing)
                }
            }
        }
        .navigationBarTitle(Text(book.title ?? "unknown title"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete book from your library"), message: Text("That`s not a temporary action, confirmation will delete your book from the storage"), primaryButton: .destructive(Text("ok")) {
                deleteBook()
            }, secondaryButton: .cancel(Text("nope")))
        })
        .navigationBarItems(trailing: Button("delete") {
            showingDeleteAlert.toggle()
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "test title"
        book.author = "test author"
        book.genre = "Fantasy"
        book.rating = 5
        book.review = "hmph"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
