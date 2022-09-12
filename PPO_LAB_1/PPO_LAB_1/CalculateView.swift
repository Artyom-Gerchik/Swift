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
    @State var swapToast = false
    
    @State private var orientation = UIDevice.current.orientation
    //@State private var orientation = UIApplication.shared.statusBarOrientation
    
    //    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    //    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
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
                    
                    Button(action: {
                        vm.pasteboard.string = vm.input
                        copyToast.toggle()
                    }, label: {
                        Text("Copy")
                    })
                }
            }.toast(isPresenting: $copyToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Copied!")
            }
            
            Divider()
            HStack{
                Text(vm.type2)
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
        else{
            
            HStack{
                Text(vm.type2)
                Spacer()
                Text(vm.input)
                if vm.isPremium{
                    Divider()
                    
                    Button(action: {
                        vm.pasteboard.string = vm.input
                        copyToast.toggle()
                        
                    }, label: {
                        Text("Copy")
                    })
                }
            }.toast(isPresenting: $copyToast, duration: 1, tapToDismiss: true){
                AlertToast(displayMode: .hud, type: .regular, title: "Copied!")
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
                vm.input.append("7")
            }, label: {
                imageForButton("7.square")
            })
            Button(action: {
                vm.input.append("8")
            }, label: {
                imageForButton("8.square")
            })
            Button(action: {
                vm.input.append("9")
            }, label: {
                imageForButton("9.square")
            })
        }
        //.padding(.horizontal, 12)
        HStack{
            Button(action: {
                vm.input.append("4")
            }, label: {
                imageForButton("4.square")
            })
            Button(action: {
                vm.input.append("5")
            }, label: {
                imageForButton("5.square")
            })
            Button(action: {
                vm.input.append("6")
            }, label: {
                imageForButton("6.square")
            })
        }
        //.padding(.horizontal, 12)
        
        HStack{
            Button(action: {
                vm.input.append("1")
            }, label: {
                imageForButton("1.square")
            })
            Button(action: {
                vm.input.append("2")
            }, label: {
                imageForButton("2.square")
            })
            Button(action: {
                vm.input.append("3")
            }, label: {
                imageForButton("3.square")
            })
        }
        //.padding(.horizontal, 12)
        HStack{
            Button(action: {
                vm.input.append("0")
            }, label: {
                imageForButton("0.square")
            })
            Button(action: {
                vm.input.append(".")
            }, label: {
                imageForButton("dot.square")
            })
            Button(action: {
                vm.input = String(vm.input.dropLast())
            }, label: {
                imageForButton("chevron.backward.square")
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
