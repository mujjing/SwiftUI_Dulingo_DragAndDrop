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
        HStack(spacing: 18) {
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
