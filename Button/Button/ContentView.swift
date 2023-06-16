//
//  ContentView.swift
//  Button
//
//  Created by Artyom on 30.11.22.
//

import SwiftUI

struct ContentView: View {
    @State var isPressed:Bool = false
    var body: some View {
        ZStack{
            
            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .scaleEffect(isPressed ? 0.7 : 1.0)
            Button(action: {
                withAnimation(.easeIn(duration: 0.25)) {
                    isPressed.toggle()
                }
                
            }, label: {
                Text("10")
                    .frame(width: 70, height: 70)
                    .foregroundColor(.black)
                    .font(.system(size: 36))
            }).scaleEffect(isPressed ? 0.7 : 1.0)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.isPressed = pressing
                                }
                            }, perform: { })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
