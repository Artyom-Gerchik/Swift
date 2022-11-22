//
//  MenuButtonsView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 21.10.22.
//

import SwiftUI

import SwiftUI

struct MenuButtons: View {
    @ObservedObject var vm : ViewModel
    
    var buttonImage: String
    
    var body: some View {
        Button(action: {
            print("MENU BUTTON TAPPED")
        }, label: {
            Image(systemName: buttonImage)
                .font(.system(size:vm.fontSize, weight: .regular))
        }).accentColor(Color.primary)
    }
}

//struct MenuButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuButtonsView()
//    }
//}
