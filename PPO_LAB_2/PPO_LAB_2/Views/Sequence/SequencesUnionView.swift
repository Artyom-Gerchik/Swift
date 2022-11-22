//
//  SequencesUnionView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 1.11.22.
//

import SwiftUI
import AlertToast

struct SequencesUnionView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    @State var checks: [Bool] = []
    @State var checkId: Int = 0
    @State var idsForUnion: [UUID] = []
    @State var bgColor: Color = Color.green
    @State var seqUnions: [Sequence] = []
    @State var toast: Bool = false
}

extension SequencesUnionView: View {
    var body: some View {
        VStack{
            HStack{
                ColorPicker("", selection: $bgColor)
                    .labelsHidden()
                    .scaleEffect((CGSize(width: 1.5, height: 1.5)))
            }.padding()
            Spacer()
            Text((locale ? "Избранные: " : "Selected sequences: "))
                .font(.system(size:vm.fontSize, weight: .regular))
                .foregroundColor(isDarkMode ? Color.white : Color.black)
                .lineLimit(1)
            HStack{
                List{
                    ForEach(seqUnions, id: \.self){
                        sequence in
                        Text(sequence.name)
                            //.lineLimit(1)
                    }
                }
            }.padding()
        }
        List{
            ForEach(vm.sequences, id: \.self){
                sequence in
                SequenceCardView(vm: vm,sequenceId: sequence.id, sequenceName: sequence.name, sequenceActions: sequence.actions, bgColor: sequence.bgColor)
                    .onTapGesture {  }
                    .onLongPressGesture(minimumDuration: 0.5, perform: {
                        if((idsForUnion.first(where: {$0 == sequence.id})) != nil){
                            idsForUnion.removeAll(where: {$0 == sequence.id})
                            seqUnions.removeAll(where: {$0.id == sequence.id})
                        }else{
                            idsForUnion.append(sequence.id)
                            seqUnions.append(sequence)
                        }
                    })
            }
        }
        HStack{
            Button(action: {
                withAnimation(.easeIn(duration: 0.25)) {
                    if(!idsForUnion.isEmpty && idsForUnion.count > 1){
                        vm.unionSequences(sequencesIds: idsForUnion, bgColor: bgColor.toHex()!)
                        vm.state = ViewModel.State.secondPage
                    }else{
                        toast.toggle()
                    }
                }
            }, label: {
                Text((locale ? "ОПГ" : "UNION"))
                    .font(.system(size:vm.fontSize, weight: .regular))
                    .foregroundColor(isDarkMode ? Color.black : Color.white)
                    .lineLimit(1)
            }).accentColor(Color.primary)
                .buttonStyle(.borderedProminent)
        }.padding()
            .toast(isPresenting: $toast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: (locale ? "Мало Братков Внатуре!" : "Low Count"))
            }
    }
}
