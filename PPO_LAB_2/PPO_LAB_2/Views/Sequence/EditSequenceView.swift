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
    @State var sequenceToEdit: Sequence = Sequence(name: "", actions: [], bgColor: "")
    
    func move(from source: IndexSet, to destination: Int) {
        sequenceToEdit.actions.move(fromOffsets: source, toOffset: destination)
        //DB_Manager().hardUpdateActionsOnMainPage(updatedActions: vm.actionsOnMainPage)
    }
}

extension EditSequenceView: View {
    var body: some View {
        VStack{
            ZStack{
                if(sequenceToEdit.name.isEmpty){
                    Text("Name Of Sequence")
                        .foregroundColor(isDarkMode ? Color.white.opacity(0.4) : Color.black.opacity(0.4))
                }
                TextField(
                    "",
                    text: $sequenceToEdit.name
                )
                .multilineTextAlignment(.center)
                .foregroundColor(isDarkMode ? Color.white : Color.black)
            }
            VStack{
                List{
                    ForEach(sequenceToEdit.actions, id: \.self){
                        action in
                        ActionCardView(vm: vm, actionId: action.id, actionName: action.name, actionDescription: action.description, actionDuration: action.duration, actionImageName: action.imageName)
                        
                    }.onMove(perform: move)
                }
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        
                        vm.updateSequence(updatedSequence: sequenceToEdit)
                        vm.state = ViewModel.State.secondPage
                        
                        
//                        newSequence = vm.sequenceOnCreatePhase
//
//                        vm.addSequence(sequenceName: newSequence.name, sequenceActions: newSequence.actions, bgColor: bgColor.toHex()!)
//                        //newSequence.bgColor = bgColor.toHex()!
//                        //vm.sequences.append(newSequence)
//                        vm.state = ViewModel.State.secondPage
//
//                        vm.sequenceOnCreatePhase = Sequence(name: "", actions: [], bgColor: "''")

                    }
                }, label: {
                    Text("OK")
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }).accentColor(Color.primary)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear(perform: {
                sequenceToEdit = vm.getSequenceForEdit(sequenceID: vm.sequenceIdToEdit)
            })
    }
}

//struct EditSequenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSequenceView()
//    }
//}
