//
//  ContentView.swift
//  Bullseye
//
//  Created by Ierchenko Anna  on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)

    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    var body: some View {
        
            VStack {
                Spacer()
        //target  row
                HStack {
                    Text("Pull the bullseye as close as you can to: ").modifier(LabelStyle())
                           
                        Text("\(self.target)").modifier(ValueStyle())
                }
                Spacer()
                //slider row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: self.$sliderValue, in: 1...100)
                    Text("100").modifier(LabelStyle())
                      
                }
                Spacer()
                //button row
                    Button(action: {
                        self.alertIsVisible = true
                    }) {
                        Text("Hit me!")
                            .modifier(ButtonLargeTextStyle())
                    }.padding(10).background(Color.yellow).modifier(Shadow())
                    .alert(isPresented: $alertIsVisible) { () -> Alert in
                       // var roundedValue:Int = Int(self.sliderValue.rounded())
                        return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\n" + "You scored \(pointsForCurrentRound()) points this round."),
                                     dismissButton: .default(Text("Awesome!")) {
                                        self.score = self.score + self.pointsForCurrentRound()
                                        self.target = Int.random(in: 1...100)
                                        self.round = round + 1
                        })
                    }
                Spacer()
                //score row
                HStack {
                    Button(action: {
                        self.startNewGame()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise.circle").accentColor(midnightBlue)
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                        }
                    }.padding(10).background(Color.yellow).modifier(Shadow())
                    Spacer()
                   Text("Score").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                    Spacer()
                    Text("Round:").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack{
                        Image(systemName: "arrow.clockwise.circle").accentColor(midnightBlue)
                        Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }.padding(10).background(Color.yellow).modifier(Shadow())
                }
                .padding(.bottom, 20)
            }
            .background(Image("Background"), alignment: .center)
            .navigationBarTitle("Bullseye")
        }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
        }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
        title = "Perfect!"
        } else if difference < 5 {
           title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
 
