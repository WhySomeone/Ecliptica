//
//  Walls.swift
//  Ecliptica
//
//  Created by Someone on 30.11.2023.
//

import Foundation
import SwiftUI
import PartialSheet

struct BlurredSheetView: View {
    @Binding var selectedBackground: String
    @State private var selection = 0
    @Binding var isSheet12Presented: Bool
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                Button(action: {
                    selectedBackground = "ecliptica"
                }) {
                    Image("ECLIP")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                .tag(0)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                
                Button(action: {
                    selectedBackground = "ecliptica1"
                }) {
                    Image("ECLIP1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                .tag(1)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                
                Button(action: {
                    selectedBackground = "HOT1"
                }) {
                    Image("HOTS1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                .tag(2)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                
                Button(action: {
                    selectedBackground = "HOT2"
                }) {
                    Image("HOTS2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                .tag(3)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .onAppear {
                switch selectedBackground {
                case "ecliptica":
                    selection = 0
                case "ecliptica1":
                    selection = 1
                case "HOT1":
                    selection = 2
                case "HOT2":
                    selection = 3
                default:
                    selection = 0
                }
            }
            
            .padding(.bottom, 10)
        }
    }
}

struct RoundedRectangleView: View {
    @Binding var message: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .frame(height: 50)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            .overlay(
                Text(message)
                    .foregroundColor(.white)
                    .font(.headline)
            )
            .padding(.horizontal, 34)
    }
}
