//
//  CategoryCalculateView.swift
//  PPO_LAB_1
//
//  Created by Artyom on 3.09.22.
//

import SwiftUI

struct CalculateView {
    @ObservedObject var vm: CalculateViewModel
    
}

extension CalculateView: View {
    var body: some View {
        VStack{
            conversionButton
            conversion.padding(.horizontal)
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
            .padding(.horizontal, 12)
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
            .padding(.horizontal, 12)
            
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
            .padding(.horizontal, 12)
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
            .padding(.horizontal, 12)
            
        }.foregroundColor(vm.readColor)
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
                        
                    }, label: {
                        Text("Copy")
                    })
                }
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
                        
                    }, label: {
                        Text("Copy")
                    })
                }
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
        // .aspectRatio(contentMode: .fit)
    }
    
    @ViewBuilder
    var conversionButton: some View{
        if vm.isPremium{
            Button(action: {
                vm.directConversion.toggle()
            }, label: {
                Text(vm.directConversion ? "Direct" : "Reversed")
            })
        }
    }
}

//struct CategoryCalculateView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCalculateView(vm:CalculateViewModel(coefficient: 1.609,
//                                                    type1: "Kilometers",
//                                                    type2: "Miles",
//                                                    configColor: .black))
//    }
//}
