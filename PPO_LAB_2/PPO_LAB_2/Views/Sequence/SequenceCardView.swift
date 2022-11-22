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
    //@State var blackCard: Bool!
    @State var whiteCard: Bool = false
    @State var colorForButtons: Color!
    
    func checkColor(){
        
        var beginingSBSTR = bgColor[bgColor.index(bgColor.startIndex, offsetBy: 0)..<bgColor.index(bgColor.startIndex, offsetBy: 2)]
        var middleSBSTR = bgColor[bgColor.index(bgColor.startIndex, offsetBy: 2)..<bgColor.index(bgColor.startIndex, offsetBy: 4)]
        var endSBSTR = bgColor[bgColor.index(bgColor.startIndex, offsetBy: 4)..<bgColor.index(bgColor.startIndex, offsetBy: 6)]
        
        print("******")
        print(String(beginingSBSTR))
        print(String(middleSBSTR))
        print(String(endSBSTR))
        print("\\\\\\")
        print(Int(String(beginingSBSTR), radix: 16)!)
        print(Int(String(middleSBSTR), radix: 16)!)
        print(Int(String(endSBSTR), radix: 16)!)
        print("******")
        
        var R = Int(String(beginingSBSTR), radix: 16)!
        var G = Int(String(middleSBSTR), radix: 16)!
        var B = Int(String(endSBSTR), radix: 16)!
        
        if (R >= 100 && G >= 100 && B >= 100){
            whiteCard = true
            colorForButtons = Color.black
        }else if(R <= 100 && G <= 100 && B <= 100){
            colorForButtons = Color.white
        }
    }
}

extension SequenceCardView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(hex: bgColor)!)
                .frame(height: 180)
                .onAppear(perform: {
                    checkColor()
                })
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
                                .foregroundColor(colorForButtons)
                        })
                        .offset(x: 20)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    Spacer()
                    Text(sequenceName)
                        .font(.system(size: vm.fontSize, weight: .regular))
                        .foregroundColor(colorForButtons)
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
                                .foregroundColor(colorForButtons)
                            
                        })
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
        }
        .onAppear(perform: {
            checkColor()
        })
        .padding([.trailing, .leading])
    }
}
