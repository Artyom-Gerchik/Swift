//
//  SequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import SwiftUI

struct SequenceCardView{
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var sequenceId: UUID!
    @State var sequenceName: String = ""
    @State var sequenceActions: [Action] = []
    @State var bgColor: String!
}

extension SequenceCardView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(hex: bgColor)!)
                .frame(height: 120)
            Text(sequenceName)
                .foregroundColor(isDarkMode ? Color.black : Color.white)
        }.padding()
    }
}

struct SequenceCardView_Previews: PreviewProvider {
    static var previews: some View {
        SequenceCardView()
    }
}
