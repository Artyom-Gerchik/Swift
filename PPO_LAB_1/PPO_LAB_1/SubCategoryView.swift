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
}

struct SubCategoryView: View {
    
    let subCategory: SubCategory
    
    var body: some View {
        
        switch subCategory {
        case .distanceCategory:
            bodyForDistance
        case .weightCategory:
            Text("Weight")
        case .currencyCategory:
            Text("Currency")
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
                CalculateView(vm:CalculateViewModel(coefficient: 100,
                                                            type1: "Centimeter",
                                                            type2: "Meter"))
            } label: {
                Label("Centimeter <-> Meter", systemImage: "ruler")
            }
            NavigationLink {
                CalculateView(vm:CalculateViewModel(coefficient: 1/3.281,
                                                            type1: "Meters",
                                                            type2: "Ft's"))
            } label: {
                Label("Meters <-> Ft's. ", systemImage: "ruler")
            }
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SubCategoryView(subCategory: .distanceCategory)
    }
}
