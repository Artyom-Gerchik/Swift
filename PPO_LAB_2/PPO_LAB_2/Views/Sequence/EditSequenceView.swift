//
//  EditSequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 2.11.22.
//

import SwiftUI

struct EditSequenceView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    func move(from source: IndexSet, to destination: Int) {
        vm.sequenceToEdit.actions.move(fromOffsets: source, toOffset: destination)
        DB_Manager().hardUpdateActions(updatedActions: vm.sequenceToEdit.actions)
    }
}

extension EditSequenceView: View {
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                if(vm.sequenceToEdit.name.isEmpty){
                    Text((locale ? "Погоняло" : "Name Of Sequence"))
                        .foregroundColor(isDarkMode ? Color.white.opacity(0.4) : Color.black.opacity(0.4))
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .lineLimit(1)
                }
                TextField(
                    "",
                    text: $vm.sequenceToEdit.name
                )
                .multilineTextAlignment(.center)
                .foregroundColor(isDarkMode ? Color.white : Color.black)
                .font(.system(size:vm.fontSize, weight: .regular))
                .lineLimit(1)
            }
            Spacer()
            VStack{
                List{
                    ForEach(vm.sequenceToEdit.actions, id: \.self){
                        action in
                        ActionCardView(vm: vm,
                                       actionId: action.id,
                                       actionName: action.name,
                                       actionDescription: action.description,
                                       actionDuration: action.duration,
                                       actionImageName: action.imageName)
                        
                    }.onMove(perform: move)
                }
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.updateSequence(updatedSequence: vm.sequenceToEdit)
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Text((locale ? "ДОБРО" : "OK"))
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }).accentColor(Color.primary)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear(perform: {
            vm.sequenceToEdit = vm.getSequenceForEdit(sequenceID: vm.sequenceIdToEdit)
        })
    }
}
