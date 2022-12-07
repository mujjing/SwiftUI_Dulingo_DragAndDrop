//
//  Home.swift
//

import SwiftUI

struct Home: View {
    //MARK: Properties
    @State var progress: CGFloat = 0
    @State var characters: [Character] = characters
    
    //MARK: Custom Grid Arrays
    @State var suffledArray: [[Character]] = [[]]
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
        }
        .padding()
    }
}

extension Home {
    func dragArea() -> some View {
        ZStack {
            VStack(spacing: 12) {
                
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
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
