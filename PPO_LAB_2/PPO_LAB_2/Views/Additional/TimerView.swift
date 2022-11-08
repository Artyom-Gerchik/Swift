//
//  TimerView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 25.10.22.
//

import SwiftUI
import AVFoundation

struct TimerView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var actionsForViewTimer: [Action]
    @State var actionsForViewText: [Action]
    @State var getBackActions: [Action]
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
                                    if(actionsForViewTimer[0].duration == 3 || actionsForViewTimer[0].duration == 2 || actionsForViewTimer[0].duration == 1){
                                        let systemSoundID: SystemSoundID = 1013
                                        AudioServicesPlaySystemSound(systemSoundID)
                                    }
                                    actionsForViewTimer[0].duration -= 1
                                }else if(!vm.isPaused){
                                    getBackActions.append(actionsForViewText.removeFirst())
                                    actionsForViewTimer.removeFirst()
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
                Spacer()
                HStack{
                    Button(action: {
                        actionsForViewTimer[0].duration = actionsForViewText[0].duration
                        let tmp = getBackActions.popLast()
                        if(tmp != nil){
                            actionsForViewTimer.insert(tmp!, at: 0)
                            actionsForViewText.insert(tmp!, at: 0)
                        }
                    }, label: {
                        Image(systemName: "backward.frame")
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                    })
                    Spacer()
                    HStack{
                        Text(String(getBackActions.count + 1) + " | " + String(actionsForViewText.count + getBackActions.count))
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                    }
                    Spacer()
                    Button(action: {
                        getBackActions.append(actionsForViewText.removeFirst())
                        actionsForViewTimer.removeFirst()
                    }, label: {
                        Image(systemName: "forward.frame")
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                    })
                }.padding()
                
            }else{
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(isDarkMode ? Color.white : Color.black).padding()
                    Text((locale ? "Стапэ!" : "Finish!"))
                        .font(.system(size: 70, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }
            }
        }
    }
}
