//
//  ContentView.swift
//  Memorize
//
//  Created by bhuvan puri on 3/29/25.
//

import SwiftUI

struct ContentView: View {
   @State var spooky: Array<String> = ["👻", "🎃", "👿", "🕷️", "☠️", "💀", "🕸️", "🧙", "👻", "🎃", "👿", "🕷️", "☠️", "💀", "🕸️", "🧙"]
    
    @State var airplanes: Array<String> = ["✈️", "🛫", "🛬", "🛩️", "✈","✈️", "🛫", "🛬", "🛩️", "✈"]
    
    @State var cars: Array<String> = ["🚘", "🚕", "🏎️", "🚠", "🚔", "🚘", "🚕", "🏎️", "🚠", "🚔"]
    
    @State var currentArray: Array<String> = []
    
    @State var lastClicked: String = "figure"
    
        
    var body: some View {
        VStack{
            gameHeader
            ScrollView {
                cards(emoticons: currentArray)
            }

            
            Spacer()
            
            HStack{
                VStack{
                    renderThemes(themeName: "figure")
                    Text("Spooky")
                          .font(.footnote)
                }
                Spacer()
                VStack{
                    renderThemes(themeName: "airplane.arrival")
                    Text("Airplanes")
                          .font(.footnote)
                }
                Spacer()
                VStack{
                    renderThemes(themeName: "car")
                    Text("Cars")
                          .font(.footnote)
                }

            }.padding(.bottom, 20)
            
            
        }
        .padding(20)
        .onAppear{
            currentArray = spooky
        }
        
    }
    
    func renderThemes(themeName: String) -> some View{
        Image(systemName: themeName)
            .font(.largeTitle)
            .foregroundColor(.pink)
            .onTapGesture {
                if themeName == "airplane.arrival"{
                    if lastClicked == "airplane.arrival"{
                        return
                    }else{
                        currentArray = airplanes
                        lastClicked = "airplane.arrival"
                        currentArray.shuffle()
                    }
                }else if themeName == "figure"{
                    if lastClicked == "figure"{
                        
                    }else {
                        currentArray = spooky
                        lastClicked = "figure"
                        currentArray.shuffle()
                    }
                }else if themeName == "car"{
                    if lastClicked == "car"{
                        return
                    }else{
                        currentArray = cars
                        lastClicked = "car"
                        currentArray.shuffle()
                    }
                        
                }
            }
    }
    
    var gameHeader: some View{
        Text("Memorize!").font(.largeTitle).padding(20)
    }
    
    
    func cards(emoticons: Array<String>) ->  some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
            ForEach(0..<emoticons.count, id: \.self){ index in
                CardView(content: emoticons[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
        .foregroundColor(.orange)
    }
            
}

struct CardView: View{
    
    let content: String
    @State var isFaceUp = false
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}



#Preview {
    ContentView()
}
