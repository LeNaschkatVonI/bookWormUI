//
//  RatingView.swift
//  bookWormUI
//
//  Created by Максим Нуждин on 24.06.2021.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    let maxRating = 5
    
    var label = ""
    var offImage: Image?
    var onImage: Image = Image(systemName: "star.fill")
    
    var offColor: Color = Color.gray
    var onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
