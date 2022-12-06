//
//  Home.swift
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(spacing: 15) {
            navBar()
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
                    }
                }
                .frame(height: 20)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
