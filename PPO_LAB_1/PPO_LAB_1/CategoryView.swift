//
//  ContentView.swift
//  PPO_LAB_1
//
//  Created by Artyom on 3.09.22.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView{
            List{
                NavigationLink {
                    SubCategoryView(subCategory: .distanceCategory)
                } label: {
                    Label("Distance", systemImage: "folder")
                }
                NavigationLink {
                    SubCategoryView(subCategory: .weightCategory)
                } label: {
                    Label("Weight", systemImage: "folder")
                }
                NavigationLink {
                    SubCategoryView(subCategory: .currencyCategory)
                } label: {
                    Label("Currency", systemImage: "folder")
                }
                NavigationLink {
                    SubCategoryView(subCategory: .testCategory)
                } label: {
                    Label("Test", systemImage: "testtube.2")
                }
            }
        }
    }
}
