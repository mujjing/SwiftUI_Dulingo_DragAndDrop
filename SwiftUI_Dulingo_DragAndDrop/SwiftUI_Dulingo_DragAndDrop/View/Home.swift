//
//  Home.swift
//

import SwiftUI

struct Home: View {
    //MARK: Properties
    @State var progress: CGFloat = 0
    @State var characters: [Character] = characters_
    
    //MARK: Custom Grid Arrays
    @State var suffledRows: [[Character]] = []
    @State var rows: [[Character]] = []
    
    //MARK: Animation
    @State var animateWrongText: Bool = false
    
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
            dropArea()
                .padding(.bottom, 30)
            dragArea()
        }
        .padding()
        .onAppear {
            if rows.isEmpty {
                characters = characters.shuffled()
                suffledRows = generatGrid()
                characters = characters_
                rows = generatGrid()
            }
        }
    }
}

extension Home {
    //MARK: drop Area
    func dropArea() -> some View {
        ZStack {
            VStack(spacing: 12) {
                ForEach($rows, id: \.self) { $row in
                    HStack(spacing: 10) {
                        ForEach($row) { $item in
                            Text(item.value)
                                .font(.system(size: item.fontSize))
                                .padding(.vertical, 5)
                                .padding(.horizontal, item.padding)
                                .opacity(item.isShowing ? 1 : 0)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(item.isShowing ? .clear : .gray.opacity(0.25))
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .stroke(.gray)
                                        .opacity(item.isShowing ? 1 : 0)
                                }
                                .onDrop(of: [.url], isTargeted: .constant(false)) { providers in
                                    if let first = providers.first {
                                        let _ = first.loadObject(ofClass: URL.self) { value, error in
                                            guard let url = value else { return }
                                            if item.id == "\(url)" {
                                                withAnimation {
                                                    item.isShowing = true
                                                    updatedShuffledArray(data: item)
                                                }
                                            } else {
                                                //Animating When Wrong Text Dropped
                                                animateText()
                                            }
                                        }
                                    }
                                    return false
                                }
                        }
                    }
                    
                    if rows.last != row {
                        Divider()
                    }
                }
            }
        }
    }
    //MARK: drag Area
    func dragArea() -> some View {
        ZStack {
            VStack(spacing: 12) {
                ForEach(suffledRows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row) { item in
                            Text(item.value)
                                .font(.system(size: item.fontSize))
                                .padding(.vertical, 5)
                                .padding(.horizontal, item.padding)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .stroke(.gray)
                                }
                                .onDrag {
                                    return .init(contentsOf: URL(string: item.id))!
                                }
                                .opacity(item.isShowing ? 0 : 1)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(item.isShowing ? .gray.opacity(0.25) : .clear)
                                }
                        }
                    }
                    if suffledRows.last != row {
                        Divider()
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
        for item in characters.enumerated() {
            let textSize = textSize(data: item.element)
            characters[item.offset].textSize = textSize
        }
        
        var gridArray: [[Character]] = [[]]
        var tempArray: [Character] = []
        
        var currentWidth: CGFloat = 0
        let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30
        
        for character in characters {
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
        return size.width + (data.padding * 2) + 15
    }
    
    //MARK: Updatind Shuffled Array
    func updatedShuffledArray(data: Character) {
        for index in suffledRows.indices {
            for subIndex in suffledRows[index].indices {
                if suffledRows[index][subIndex].id == data.id {
                    suffledRows[index][subIndex].isShowing = true
                }
            }
        }
    }
    
    //MARK: Animating View When Wrong Text Dropped
    func animateText() {
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
