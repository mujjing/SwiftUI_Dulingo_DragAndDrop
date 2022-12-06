//
//  Home.swift
//

import SwiftUI

struct Home: View {
    //MARK: Properties
    @State var progress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 15) {
            navBar()
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Form This Sentence")
                    .font(.title2.bold())
            }
        }
        .padding()
    }
}

extension Home {
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
