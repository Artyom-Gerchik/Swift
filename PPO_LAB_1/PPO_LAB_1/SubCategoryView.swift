//
//  SubCategoryView.swift
//  PPO_LAB_1
//
//  Created by Artyom on 3.09.22.
//

import SwiftUI

enum SubCategory{
    case distanceCategory
    case weightCategory
    case currencyCategory
    case testCategory
}

struct SubCategoryView: View {
    
    let subCategory: SubCategory
    
    var body: some View {
        
        switch subCategory {
        case .distanceCategory:
            bodyForDistance
        case .weightCategory:
            bodyForWeight
        case .currencyCategory:
            bodyForCurrency
        case .testCategory:
            bodyForTest
        }
    }
    
    
    @ViewBuilder
    var bodyForDistance: some View {
        List{
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1.609,
                                                    type1: "Kilometers",
                                                    type2: "Miles"))
            } label: {
                Label("Kilometers <-> Miles", systemImage: "ruler")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/10,
                                                    type1: "Centimeters",
                                                    type2: "Millimetres"))
            } label: {
                Label("Centimeters <-> Millimetres", systemImage: "ruler")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/3.281,
                                                    type1: "Meters",
                                                    type2: "Ft's"))
            } label: {
                Label("Meters <-> Ft's", systemImage: "ruler")
            }
        }
    }
    
    @ViewBuilder
    var bodyForWeight: some View {
        List{
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/2.205,
                                                    type1: "Kilogramms",
                                                    type2: "Pounds"))
            } label: {
                Label("Kilogramms <-> Pounds", systemImage: "scalemass")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/32000,
                                                    type1: "US tons",
                                                    type2: "Ounces"))
            } label: {
                Label("US ton <-> Ounce", systemImage: "scalemass")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/157.5,
                                                    type1: "Tonnes",
                                                    type2: "Stones"))
            } label: {
                Label("Tonnes <-> Stones", systemImage: "scalemass")
            }
        }
    }
    
    @ViewBuilder
    var bodyForCurrency: some View {
        List{
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 2.5741,
                                                    type1: "BYN",
                                                    type2: "USD"))
            } label: {
                Label("BYN <-> USD", systemImage: "bitcoinsign.square")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 2.5525,
                                                    type1: "BYN",
                                                    type2: "EUR"))
            } label: {
                Label("BYN <-> EUR", systemImage: "bitcoinsign.square")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 2.9633,
                                                    type1: "BYN",
                                                    type2: "GBP"))
            } label: {
                Label("BYN <-> GBP", systemImage: "bitcoinsign.square")
            }
        }
    }
    
    @ViewBuilder
    var bodyForTest: some View {
        List{
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1.0,
                                                    type1: "same",
                                                    type2: "same"))
            } label: {
                Label("same <-> same", systemImage: "")
            }
        }
    }
}

