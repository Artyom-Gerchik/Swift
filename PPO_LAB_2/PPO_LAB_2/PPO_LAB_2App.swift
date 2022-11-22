//
//  PPO_LAB_2App.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

@main
struct PPO_LAB_2App: App {
    var body: some Scene {
        WindowGroup {
            MainView(vm:ViewModel(state: ViewModel.State.mainPage, fontSize: 24, actionsOnMainPage: [], sequences: []))
        }
    }
}
