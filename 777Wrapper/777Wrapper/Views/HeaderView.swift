//
//  HeaderView.swift
//  777Wrapper
//
//  Created by Artyom on 16.06.23.
//

import SwiftUI

struct HeaderView{
    @ObservedObject var vm: ViewModel
}

extension HeaderView: View {
    var body: some View {
        
        if(vm.state == ViewModel.State.mainPage){
            
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)){
                        vm.state = ViewModel.State.mainPage
                        vm.parseHTML();
                    }
                }, label: {
                    Text("To Minsk")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.white)
                })
                .accentColor(Color.gray)
                .buttonStyle(.borderedProminent)
                .cornerRadius(30)
                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)){
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Text("To Slutsk")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.black)
                })
                .accentColor(Color.white)
                .buttonStyle(.borderedProminent)
                .cornerRadius(30)
                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                    }
                }, label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 24, weight: .regular))
                }).accentColor(Color.primary)
                
            }.padding()
        }
        else if(vm.state == ViewModel.State.secondPage){
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)){
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Text("To Minsk")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.black)
                })
                .accentColor(Color.white)
                .buttonStyle(.borderedProminent)
                .cornerRadius(30)
                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)){
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Text("To Slutsk")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color.white)
                })
                .accentColor(Color.gray)
                .buttonStyle(.borderedProminent)
                .cornerRadius(30)
                .background(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                    }
                }, label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 24, weight: .regular))
                }).accentColor(Color.primary)
                
            }.padding()
        }
    }
}



struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(vm: ViewModel(state: ViewModel.State.mainPage))
    }
}
