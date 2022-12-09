//
//  Home.swift
//

import SwiftUI

struct Home: View {
    //MARK: Properties
    @State var progress: CGFloat = 0
    @State var charactersArr: [Character] = characters_
    
    //MARK: Custom Grid Arrays
    @State var suffledRows: [[Character]] = [[]]
    @State var rows: [[Character]] = [[]]
    
    var body: some View {
        VStack(spacing: 15) {
            navBar()
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Form This Sentence")
                    .font(.title2.bold())
                
                Image("j")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
            }
            .padding(.top, 30)
            
            //MARK: Drag And Drop Space
            dragArea()
        }
        .padding()
        .onAppear {
            if rows.isEmpty {
                charactersArr = charactersArr.shuffled()
                suffledRows = generatGrid()
                charactersArr = characters_
                rows = generatGrid()
            }
        }
    }
}

extension Home {
    func dragArea() -> some View {
        ZStack {
            VStack(spacing: 12) {
                ForEach(suffledRows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row) { item in
                            Text(item.value)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Custom Nav Bar
    func navBar() -> some View{
        ZStack {
            HStack(spacing: 18) {
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                GeometryReader { geo in
                    ZStack {
                        Capsule()
                            .fill(.gray.opacity(0.25))
                        
                        Capsule()
                            .fill(.green)
                            .frame(width: geo.size.width * progress)
                    }
                }
                .frame(height: 20)
                
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    //MARK: Generating Custom Grid Columns
    func generatGrid() -> [[Character]] {
        for item in charactersArr.enumerated() {
            let textSize = textSize(data: item.element)
            charactersArr[item.offset].textSize = textSize
        }
        
        var gridArray: [[Character]] = [[]]
        var tempArray: [Character] = []
        
        var currentWidth: CGFloat = 0
        let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30
        
        for character in charactersArr {
            currentWidth += character.textSize
            
            if currentWidth < totalScreenWidth {
                tempArray.append(character)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = character.textSize
                tempArray.append(character)
            }
        }
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
    }
    
    func textSize(data: Character) -> CGFloat {
        let font = UIFont.systemFont(ofSize: data.fontSize)
        let attributes = [NSAttributedString.Key.font : font]
        let size = (data.value as NSString).size(withAttributes: attributes)
        return size.width * (data.padding * 2)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
