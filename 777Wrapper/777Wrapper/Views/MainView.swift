//
//  ContentView.swift
//  777Wrapper
//
//  Created by Artyom on 16.06.23.
//

import SwiftUI

struct MainView{
    @ObservedObject var vm: ViewModel
}

extension MainView: View {
    var body: some View {
        
        VStack{
            HeaderView(vm: vm)
            Spacer()
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
