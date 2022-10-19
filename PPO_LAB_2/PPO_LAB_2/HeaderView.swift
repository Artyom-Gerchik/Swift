//
//  HeaderView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            Button(action: {
                //
            }, label: {
                Image(systemName: "gearshape")
                    .font(.system(size:24, weight: .regular))
            }).accentColor(Color.primary)
            
            Spacer()
            
            Button(action: {
                //
            }, label: {
                Image(systemName: "list.bullet")
                    .font(.system(size:24, weight: .regular))
            }).accentColor(Color.primary)
            
            Button(action: {
                //
            }, label: {
                Image(systemName: "rectangle.on.rectangle")
                    .font(.system(size:24, weight: .regular))
            }).accentColor(Color.primary)
            
            Spacer()
            
            Button(action: {
                //
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size:24, weight: .regular))
            }).accentColor(Color.primary)
        }
        .padding()
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
