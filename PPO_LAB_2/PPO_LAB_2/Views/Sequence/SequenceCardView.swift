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
    @AppStorage("locale") private var locale = false
    
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
                .frame(height: 180)
            VStack{
                Spacer()
                HStack{
                    if(vm.state == ViewModel.State.secondPage){
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.sequenceIdToEdit = sequenceId
                                vm.state = ViewModel.State.editSequencePage
                            }
                        }, label: {
                            Image(systemName: "pencil")
                                .font(.system(size: vm.fontSize, weight: .regular))
                        }).accentColor(isDarkMode ? Color.black : Color.white)
                            .offset(x: 20)
                            .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                    Text(sequenceName)
                        .font(.system(size: vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.white : Color.black)
                        .lineLimit(1)
                        .padding([.leading, .trailing])
                    Spacer()
                    if(vm.state == ViewModel.State.secondPage){
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
                }.padding(.top)
                List{
                    ForEach(sequenceActions, id: \.self){
                        action in
                        HStack{
                            Spacer()
                            Text(action.name)
                                .lineLimit(1)
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                            Text(String(action.duration))
                                .lineLimit(1)
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.white : Color.black)
                            Spacer()
                        }
                    }
                }.padding()
            }
        }.padding([.trailing, .leading])
    }
}
