//
//  TimerView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 25.10.22.
//

import SwiftUI

struct TimerView{
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var actionsForViewTimer: [Action]
    @State var actionsForViewText: [Action]
    @State var currentDuration: Int = 0
}

extension TimerView: View {
    var body: some View {
        VStack{
            if(actionsForViewTimer.count > 0){
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(isDarkMode ? Color.white : Color.black)
                        .frame(height: 300)
                        .padding()
                    VStack{
                        Text(actionsForViewTimer[0].name).offset(y: -30)
                            .font(.system(size: 50, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                        Text("\(actionsForViewTimer[0].duration)")
                            .font(.system(size: 100, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                            .onReceive(timer) { _ in
                                if (actionsForViewTimer[0].duration > 0 && !vm.isPaused) {
                                    actionsForViewTimer[0].duration -= 1
                                }else if(!vm.isPaused){
                                    actionsForViewTimer.removeFirst()
                                    actionsForViewText.removeFirst()
                                }
                            }
                        
                    }
                }
                Spacer()
                List{
                    ForEach(actionsForViewText, id: \.self){
                        action in
                        HStack{
                            Spacer()
                            Text(action.name + ":")
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.black : Color.white)
                            Text(String(action.duration))
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.black : Color.white)
                            Spacer()
                        }
                        .listRowBackground(isDarkMode ? Color.white : Color.black)
                        .listRowSeparatorTint(isDarkMode ? Color.black : Color.white)
                    }
                }
                .scrollContentBackground(.hidden)
                
            }else{
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(isDarkMode ? Color.white : Color.black).padding()
                    Text("Finish!")
                        .font(.system(size: 70, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }
            }
        }
    }
    func test(){
        
    }
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView(vm:ViewModel(state: ViewModel.State.mainPage,fontSize: 24, actionsOnMainPage: [], sequences: []), actionsForViewTimer: [
//            Action(name: "test1", description: "tt", duration: 10, imageName: "sofa"),
//            Action(name: "test2", description: "tt", duration: 11, imageName: "sofa"),
//            Action(name: "test3", description: "tt", duration: 12, imageName: "sofa")], actionsForViewText: [
//                Action(name: "test1", description: "tt", duration: 10, imageName: "sofa"),
//                Action(name: "test2", description: "tt", duration: 11, imageName: "sofa"),
//                Action(name: "test3", description: "tt", duration: 12, imageName: "sofa")])
//    }
//}
