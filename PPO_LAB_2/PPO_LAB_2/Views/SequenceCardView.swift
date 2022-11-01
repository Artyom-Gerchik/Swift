//
//  SequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import SwiftUI

struct SequenceCardView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var sequenceId: UUID 
    @State var sequenceName: String = ""
    @State var sequenceActions: [Action] = []
    @State var bgColor: String!
}

extension SequenceCardView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(hex: bgColor)!)
            //.fill(Color.black)
                .frame(height: 180)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(sequenceName)
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.secondTimerPage
                            vm.isPaused = false
                            vm.sequenceIdForTimer = sequenceId
                        }
                    }, label: {
                        Image(systemName: "play")
                            .font(.system(size: vm.fontSize, weight: .regular))
                    }).accentColor(isDarkMode ? Color.black : Color.white)
                        .offset(x: -20)
                        .buttonStyle(PlainButtonStyle())
                    
                }
                List{
                    ForEach(sequenceActions, id: \.self){
                        action in
                        HStack{
                            Spacer()
                            Text(action.name)
                            Text(String(action.duration))
                            Spacer()
                        }
                    }
                }.frame(width: 300, height: 100)
                    .padding()
            }
        }.padding()
    }
}

//struct SequenceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SequenceCardView(vm: ViewModel(state: ViewModel.State.createSequencePage,fontSize: 24, actionsOnMainPage: [], sequences: []))
//    }
//}
