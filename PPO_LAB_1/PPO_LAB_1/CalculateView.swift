//
//  CategoryCalculateView.swift
//  PPO_LAB_1
//
//  Created by Artyom on 3.09.22.
//

import AlertToast
import SwiftUI

struct CalculateView {
    @ObservedObject var vm: CalculateViewModel
    
    @State var copyToast = false
    @State var pasteToast = false
    @State var swapToast = false
    @State var jopaToast = false
    @State var bullShitToast = false
    @State var leadingZeroToast = false
    @State var dotBullShit = false
    
    @State private var orientation = UIDevice.current.orientation
}

extension CalculateView: View {
    var body: some View {
        ZStack{
            if (orientation.isLandscape){
                HStack{
                    VStack{
                        conversionButton
                        conversion.padding(.horizontal)
                    }
                    VStack{
                        keyBoard
                    }
                }
            }else if (orientation.isPortrait){
                VStack{
                    conversionButton
                    conversion.padding(.horizontal)
                    keyBoard
                }
            }
            else if (orientation == UIDeviceOrientation.portraitUpsideDown) {
                VStack{
                    conversionButton
                    conversion.padding(.horizontal)
                    keyBoard
                }
            }
        }
        .onAppear {
            orientation = UIApplication.shared.statusBarOrientation == .portrait ? UIDeviceOrientation.portrait : UIDeviceOrientation.landscapeLeft
        }
        .onRotate { newOrientation in
            orientation = newOrientation
            print(orientation == UIDeviceOrientation.portraitUpsideDown)
        }
        .toast(isPresenting: $swapToast, duration: 0.5, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: vm.directConversion ? "Direct" : "Reversed")
        }
        .foregroundColor(vm.readColor).padding(.all).background(
            Image("wtf")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)
        )
    }
    
    @ViewBuilder var conversion: some View{
        if vm.directConversion{
            HStack{
                Text(vm.type1)
                Spacer()
                Text(vm.input)
                if vm.isPremium{
                    Divider()
                    VStack{
                        Button(action: {
                            vm.copyToPasteBoard()
                            copyToast.toggle()
                        }, label: {
                            Text("Copy")
                        })
                        Spacer()
                            .frame(height: 10)
                        Button(action: {
                            if(vm.insertPasteBoard()){
                                pasteToast.toggle()
                            }
                            else{
                                bullShitToast.toggle()
                            }
                        }, label: {
                            Text("Paste")
                        })
                    }
                }
            }.toast(isPresenting: $copyToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Copied!")
            }.toast(isPresenting: $pasteToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Pasted!")
            }.toast(isPresenting: $bullShitToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "You Pasting BullShit!")
            }
            Divider()
            HStack{
                Text(vm.type2)
                Spacer()
                Text(vm.output)
                if vm.isPremium{
                    Divider()
                    VStack{
                        Button(action: {
                            vm.pasteboard.string = vm.output
                            copyToast.toggle()
                        }, label: {
                            Text("Copy")
                        })
                    }
                }
            }
        }
        else{
            HStack{
                Text(vm.type2)
                Spacer()
                Text(vm.input)
                if vm.isPremium{
                    Divider()
                    VStack{
                        Button(action: {
                            vm.copyToPasteBoard()
                            copyToast.toggle()
                        }, label: {
                            Text("Copy")
                        })
                        Spacer()
                            .frame(height: 10)
                        Button(action: {
                            if(vm.insertPasteBoard()){
                                pasteToast.toggle()
                            }
                            else{
                                bullShitToast.toggle()
                            }
                        }, label: {
                            Text("Paste")
                        })
                    }
                }
            }.toast(isPresenting: $copyToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Copied!")
            }.toast(isPresenting: $pasteToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Pasted!")
            }.toast(isPresenting: $bullShitToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "You Pasting BullShit!")
            }
            Divider()
            HStack{
                Text(vm.type1)
                Spacer()
                Text(vm.output)
                if vm.isPremium{
                    Divider()
                    Button(action: {
                        vm.pasteboard.string = vm.output
                        copyToast.toggle()
                    }, label: {
                        Text("Copy")
                    })
                }
            }
        }
    }
    
    @ViewBuilder
    func imageForButton(_ name:String) -> some View{
        Image(systemName: name)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    var conversionButton: some View{
        if vm.isPremium{
            Button(action: {
                vm.directConversion.toggle()
                swapToast.toggle()
            }, label: {
                let image = Image(systemName: "arrow.2.squarepath")
                Text(vm.directConversion ? "Direct \(image)" : "Reversed \(image)")
            })
        }
    }
    
    @ViewBuilder
    var keyBoard: some View{
        HStack{
            Button(action: {
                vm.insertSymbol(inputVar: "7")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("7.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "8")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("8.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "9")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("9.square")
            })
        }.toast(isPresenting: $jopaToast, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Input Overflow")
        }
        HStack{
            Button(action: {
                vm.insertSymbol(inputVar: "4")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("4.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "5")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("5.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "6")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("6.square")
            })
        }.toast(isPresenting: $jopaToast, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Input Overflow")
        }
        HStack{
            Button(action: {
                vm.insertSymbol(inputVar: "1")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("1.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "2")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("2.square")
            })
            Button(action: {
                vm.insertSymbol(inputVar: "3")
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("3.square")
            })
        }.toast(isPresenting: $jopaToast, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Input Overflow")
        }
        HStack{
            Button(action: {
                if(vm.checkLeftPartForZeroInsert()){
                    vm.insertSymbol(inputVar: "0")
                    if(vm.output == "jopa"){
                        jopaToast.toggle()
                    }
                }
                else{
                    leadingZeroToast.toggle()
                }
            }, label: {
                imageForButton("0.square")
            })
            Button(action: {
                var dotsCounter = 0
                for char in vm.input{
                    if (char == "."){
                        dotsCounter += 1
                    }
                }
                if(dotsCounter == 0){
                    vm.insertSymbol(inputVar: ".")
                }
                else{
                    dotBullShit.toggle()
                }
                if(vm.output == "jopa"){
                    jopaToast.toggle()
                }
            }, label: {
                imageForButton("dot.square")
            })
            Button(action: {
                if(vm.currentCursorPosition > 0){
                    vm.removeSymbol()
                    
                    //let tmp = vm.currentCursorPosition
//                    vm.input.remove(at: vm.input.index(vm.input.startIndex, offsetBy: vm.currentCursorPosition - 1))
                    //if(tmp - vm.currentCursorPosition == 1){
                    //    vm.currentCursorPosition += 1
                    //}
                    //if(vm.currentCursorPosition > 0){
                    //    vm.currentCursorPosition -= 1
                    //}
                }
            }, label: {
                imageForButton("chevron.backward.square")
            })
        }.toast(isPresenting: $leadingZeroToast, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Leading Zero BullShit!")
        }.toast(isPresenting: $dotBullShit, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Dot Is Existing!")
        }.toast(isPresenting: $jopaToast, duration: 1, tapToDismiss: true){
            AlertToast(displayMode: .hud, type: .regular, title: "Input Overflow")
        }
        HStack{
            Button(action: {
                // move cursor left
                if(vm.currentCursorPosition != 0){
                    vm.moveCursorLeft()
//                    if(vm.currentCursorPosition != 0){
//                        vm.currentCursorPosition -= 1
//                    }
                }
            }, label: {
                imageForButton("arrowshape.left")
            })
            Button(action: {
                // move cursor right
                if(vm.currentCursorPosition + 1 < vm.input.count){
                    //vm.input = vm.swapCharacters(input: vm.input, index1: vm.currentCursorPosition, index2: vm.currentCursorPosition + 1)
                    vm.moveCursorRight()
//                    if(vm.currentCursorPosition == -1){
//                        vm.currentCursorPosition = 0
//                    }
//                    vm.currentCursorPosition += 1
                }
            }, label: {
                imageForButton("arrowshape.right")
            })
        }
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
