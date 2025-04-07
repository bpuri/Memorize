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
    
    //intializing the default selected theme
    @State var lastClicked: String = "airplane.arrival"
            
    var themeNames: [String: String] = ["figure": "spooky", "airplane.arrival": "airplanes", "car": "cars"]
    
    var themes: [String: [String]] {
        [
            "figure": spooky,
            "airplane.arrival": airplanes,
            "car": cars
        ]
    }
    
    var body: some View {
        VStack{
            gameHeader
            ScrollView {
                cards(emoticons: currentArray)
            }
            
            Spacer()
            
            HStack{
                ForEach(themes.keys.sorted(), id: \.self){ key in
                    VStack{
                        renderThemes(themeName: key)
                        Text(themeNames[key] ?? "")
                            .font(.footnote)
                    }
                    
                    if key != themes.keys.sorted().last {
                        Spacer().frame(width: 65)
                    }
                }

            }.padding(.bottom, 20)
            
            
        }
        .padding(20)
        .onAppear{
            currentArray = airplanes
        }
        
    }
    
    func renderThemes(themeName: String) -> some View{
        Image(systemName: themeName)
            .font(.largeTitle)
            .foregroundColor(.pink)
            .onTapGesture {
                themeSelector(themeName: themeName)
            }
    }
    
    func themeSelector(themeName: String){
        guard themeName != lastClicked else { return }
        currentArray = themes[themeName] ?? []
        currentArray.shuffle()
        lastClicked = themeName
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
