//
//  AboutView.swift
//  Bullseye
//
//  Created by Ierchenko Anna  on 1/30/22.
//

import SwiftUI

struct AboutView: View {
    
    
    let beige = Color(red: 255.0 / 255.0, green: 216.0 / 255.0, blue: 179.0 / 255.0)
    
    struct AboutHeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    struct AboutBodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
        VStack {
            Text("Bullseye").modifier(AboutHeadingStyle())
            Text("This is Bullseye, the game where yiu can win points and earn fame by dragging a slider.").modifier(AboutBodyStyle())
            Text("Your goal is to place the slider as close as possible to the target value. As closer you are").modifier(AboutBodyStyle())
            Text("Enjoy!").modifier(AboutBodyStyle())
        }
        .navigationBarTitle("About Bullseye")
        .background(beige)
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
