//
//  MMOD_LAB1App.swift
//  MMOD-LAB1
//
//  Created by Artyom on 18.09.23.
//

import SwiftUI

@main
struct MMOD_LAB1App: App {
    var body: some Scene {
        WindowGroup {
            MainView(vm: ViewModel(state: ViewModel.State.mainPage, stringForTask1: "", stringForTask2: "", stringForTask3: "", stringForTask4: ""))
        }
    }
}
