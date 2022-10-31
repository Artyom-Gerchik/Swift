//
//  SequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import SwiftUI

struct SequenceView{
    @AppStorage("isDarkMode") private var isDarkMode = false
    
}

extension SequenceView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(isDarkMode ? Color.white : Color.black)
                .frame(height: 120)
        }.padding()
    }
}

struct SequenceView_Previews: PreviewProvider {
    static var previews: some View {
        SequenceView()
    }
}
