//
//  HowUse.swift
//  Ecliptica
//
//  Created by Someone on 30.11.2023.
//

import SwiftUI

struct HowToView: View {
    @State private var selection = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                VStack {
                    Image("ECLIP")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                    
                    Text("Что такое Ecliptica?")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.8))
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                    
                    Text("Приложение SMS-Bomber для атаки\nсмс сообщениями на номер телефона жертвы 💣")
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                }
                .tag(0)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)

                VStack {
                    Image("How2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                    
                    Text("Как правильно?")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.8))
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                    
                    Text("Вводите номер без +7 и 7\nсистема сама поставит +7 или 7\nесли это потребуется 😉")
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                }
                .tag(1)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                VStack {
                    Image("How3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                    
                    Text("Приложение бесплатное?")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.8))
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                    
                    Text("Да, Ecliptica является единственным и бесплатным\nSMS Bomber'ом на IOS")
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                }
                
                .tag(2)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 350)
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(height: 70)
                    .padding(.horizontal, 25)
                    .foregroundColor(Color(red: 0.0, green: 0.533, blue: 0.8).opacity(0.5))
                    .blur(radius: 40)

                Button(action: {
                    if let url = URL(string: "https://t.me/EclipticaBomber") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(height: 70)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.horizontal, 25)
                        .accentColor(Color(red: 0.0, green: 0.533, blue: 0.8).opacity(1.0))
                        .overlay(
                            Image(systemName: "paperplane.fill")
                                .imageScale(.medium)
                                .foregroundColor(.white)
                        )
                }
            }
            .padding(.bottom, 15)
        }
    }
}
