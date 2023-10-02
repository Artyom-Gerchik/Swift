//
//  ContentView.swift
//  MMOD-LAB2
//
//  Created by Artyom on 25.09.23.
//

import SwiftUI
import Charts

struct MainView{
    @ObservedObject var vm: ViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var leftBorderTask1: String = "0"
    @State private var rightBorderTask1: String = "0"
    
    @State private var chartXLeft1: String = "0"
    @State private var chartXRight1: String = "0"
    
    @State private var showItems1: Bool = false
    
    @State private var arrayTask1: [Double] = []
    @State private var arrayPointEstimatesTask1: [Double] = []
    
    
    @State private var leftBorderTask2: String = "0"
    @State private var rightBorderTask2: String = "0"
    
    @State private var chartXLeft2: String = "0"
    @State private var chartXRight2: String = "0"
    
    @State private var showItems2: Bool = false
    
    @State private var arrayTask2: [Double] = []
    @State private var arrayPointEstimatesTask2: [Double] = []
    
    
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
}

extension MainView: View {
    var body: some View {
        VStack {
            if(vm.state == ViewModel.State.mainPage){
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.firstTaskPage
                    }
                }, label: {
                    Text("Task 1")
                        .font(.system(size:24, weight: .regular))
                })
                .buttonStyle(.borderedProminent)
                .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondTaskPage
                    }
                }, label: {
                    Text("Task 2")
                        .font(.system(size:24, weight: .regular))
                })
                .buttonStyle(.borderedProminent)
                .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                
                
                Spacer()
                
                
                
            }else if(vm.state == ViewModel.State.firstTaskPage){
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                }
                .padding()
                .padding(.bottom, 10)
                
                HStack{
                    TextField("", text: $leftBorderTask1)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    TextField("", text: $rightBorderTask1)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            if(leftBorderTask1 != "" && rightBorderTask1 != ""){
                                if(Int(leftBorderTask1)! > 0 && Int(rightBorderTask1)! > 0){
                                    if(Int(rightBorderTask1)! > Int(leftBorderTask1)!){
                                        hideKeyboard()
                                        chartXLeft1 = leftBorderTask1
                                        chartXRight1 = rightBorderTask1
                                        
                                        arrayTask1 = vm.firstTaskInitialChart(leftBorder: Int(leftBorderTask1)! , rightBorder: Int(rightBorderTask1)!)
                                        arrayPointEstimatesTask1 = vm.pointsEstimate(resArray: arrayTask1)
                                        
                                        showItems1 = true
                                    }
                                    else{
                                        leftBorderTask1 = "0"
                                        rightBorderTask1 = "0"
                                    }
                                }else{
                                    leftBorderTask1 = "0"
                                    rightBorderTask1 = "0"
                                }
                            }
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    Spacer()
                    
                }
                .padding(.bottom, 20)
                ScrollView {
                    VStack{
                        Chart {
                            
                            ForEach(0..<arrayTask1.count, id: \.self){ index in
                                BarMark(
                                    x: .value("Value", Int(arrayTask1[index])),
                                    y: .value("Total Drops", 1)
                                )
                            }
                        }
                        .padding()
                        .foregroundStyle(.green)
                        .chartYScale(domain: [0, 10000])
                        .onTapGesture(count: 2){
                            arrayTask1 = []
                        }
                        .chartXScale(domain: [Int(chartXLeft1)! - 1, Int(chartXRight1)! + 1])
                    }
                    if(showItems1){
                        VStack{
                            HStack{
                                VStack{
                                    Text("M: \(vm.calcM(leftBorder: Int(chartXLeft1)! , rightBorder: Int(chartXRight1)!))")
                                        .foregroundColor(.secondary)
                                    Text("D: \(vm.calcD(leftBorder: Int(chartXLeft1)! , rightBorder: Int(chartXRight1)!))")
                                        .foregroundColor(.secondary)
                                    Text("SC: \(vm.calcSC(leftBorder: Int(chartXLeft1)! , rightBorder: Int(chartXRight1)!))")
                                        .foregroundColor(.secondary)
                                }
                                VStack{
                                    Text("M_Point: \(arrayPointEstimatesTask1[0])")
                                        .foregroundColor(.secondary)
                                    Text("D_Point: \(arrayPointEstimatesTask1[1])")
                                        .foregroundColor(.secondary)
                                    Text("SC_Point: \(arrayPointEstimatesTask1[2])")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("left_Point: \(arrayPointEstimatesTask1[3])")
                                    .foregroundColor(.secondary)
                                Text("right_Point: \(arrayPointEstimatesTask1[4])")
                                    .foregroundColor(.secondary)
                                
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("confInterval: (\(arrayPointEstimatesTask1[5]), \(arrayPointEstimatesTask1[6]))")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("xhi2_emp: \(arrayPointEstimatesTask1[7])")
                                    .foregroundColor(.secondary)
                            }
                            HStack{
                                Text("xhi2_teor: 100 733,72514319631")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }else if(vm.state == ViewModel.State.secondTaskPage){
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                }
                .padding()
                .padding(.bottom, 10)
                
                HStack{
                    TextField("", text: $leftBorderTask2)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    TextField("", text: $rightBorderTask2)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            if(leftBorderTask2 != "" && rightBorderTask2 != ""){
                                if(Int(leftBorderTask2)! > 0 && Int(rightBorderTask2)! > 0){
                                    if(Int(rightBorderTask2)! > Int(leftBorderTask2)!){
                                        hideKeyboard()
                                        chartXLeft2 = leftBorderTask2
                                        chartXRight2 = rightBorderTask2
                                        
                                        arrayTask2 = vm.secondTaskInitialChart(leftBorder: Int(leftBorderTask2)! , rightBorder: Int(rightBorderTask2)!)
                                        arrayPointEstimatesTask2 = vm.pointsEstimateTask2()
                                        
                                        showItems2 = true
                                    }
                                    else{
                                        leftBorderTask2 = "0"
                                        rightBorderTask2 = "0"
                                    }
                                }else{
                                    leftBorderTask2 = "0"
                                    rightBorderTask2 = "0"
                                }
                            }
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    Spacer()
                    
                }
                .padding(.bottom, 20)
                ScrollView {
                    VStack{
                        Chart {
                            
                            ForEach(0..<arrayTask2.count, id: \.self){ index in
                                BarMark(
                                    x: .value("Value", arrayTask2[index]),
                                    y: .value("Total Drops", 1)
                                )
                            }
                        }
                        .padding()
                        .foregroundStyle(.green)
                        .chartYScale(domain: [0, 15000])
                        .onTapGesture(count: 2){
                            arrayTask2 = []
                        }
                        //.chartXScale(domain: [Int(chartXLeft2)! - 1, Int(chartXRight2)! + 1])
                    }
                    if(showItems2){
                        VStack{
                            HStack{
                                VStack{
                                    Text("M: \(vm.calcMTask2(leftBorder: Int(chartXLeft2)! , rightBorder: Int(chartXRight2)!))")
                                        .foregroundColor(.secondary)
                                    Text("D: \(vm.calcDTask2(leftBorder: Int(chartXLeft2)! , rightBorder: Int(chartXRight2)!))")
                                        .foregroundColor(.secondary)
                                    Text("SC: \(vm.calcSC(leftBorder: Int(chartXLeft2)! , rightBorder: Int(chartXRight2)!))")
                                        .foregroundColor(.secondary)
                                }
                                VStack{
                                    Text("M_Point: \(arrayPointEstimatesTask2[0])")
                                        .foregroundColor(.secondary)
                                    Text("D_Point: \(arrayPointEstimatesTask2[1])")
                                        .foregroundColor(.secondary)
                                    Text("SC_Point: \(arrayPointEstimatesTask2[2])")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("left_Point: \(arrayPointEstimatesTask2[3])")
                                    .foregroundColor(.secondary)
                                Text("right_Point: \(arrayPointEstimatesTask2[4])")
                                    .foregroundColor(.secondary)
                                
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("confInterval: (\(arrayPointEstimatesTask2[5]), \(arrayPointEstimatesTask2[6]))")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.bottom, 20)
                            HStack{
                                Text("xhi2_emp: \(arrayPointEstimatesTask2[7])")
                                    .foregroundColor(.secondary)
                            }
                            HStack{
                                Text("xhi2_teor: 100 733,72514319631")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .padding()
    }
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(vm: ViewModel(state: ViewModel.State.mainPage))
//    }
//}
