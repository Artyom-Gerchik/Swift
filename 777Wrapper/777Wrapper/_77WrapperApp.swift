//
//  _77WrapperApp.swift
//  777Wrapper
//
//  Created by Artyom on 16.06.23.
//

import SwiftUI

@main
struct _77WrapperApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(vm:ViewModel(state: ViewModel.State.mainPage))
        }
    }
}
