//
//  SoonLogs.swift
//  Ecliptica
//
//  Created by Someone on 30.11.2023.
//

import Foundation
import SwiftUI

struct LogsSoon: View {
    @State private var selection = 0
    
    var body: some View {
        VStack {
                VStack {
                    Image("LOGS")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
               
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 190)

            .padding(.bottom, 5)
        }
    }
}
