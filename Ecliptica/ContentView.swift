//
//  ContentView.swift
//  Ecliptica
//
//  Created by Someone on 06.10.2023.
//

import SwiftUI
import CoreMotion
import UIKit
import Combine
import PartialSheet

struct ContentView: View {
    @State private var phone = ""
    @State private var numberOfThreads = ""
    @State private var errorText = ""
    @State private var isBlurred = false
    @State private var message = "Ecliptica"
    @State private var isAttacking = false
    @State var isSheetPresented = false
    @State var isSheet12Presented = false
    @State var isSheet123Presented = false
    @State private var selectedBackground = "ecliptica"
    @State private var showAlert = false
    @State private var isClearButtonVisible = false
    @State private var sliderValue: Double = 1
    @State private var isAgreeWithTOS = false
    
    let iPhoneStyle = PSIphoneStyle(
        background: .blur(.ultraThinMaterial),
        handleBarStyle: .solid(.secondary),
        cover: .enabled(Color.black.opacity(0.4)),
        cornerRadius: 20
    )
    
    var isPhoneValid: Bool {
        return phone.count == 10
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        PSButton(
                            isPresenting: $isSheet12Presented,
                            label: {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                                    .cornerRadius(50)
                                    .overlay(
                                        Image(systemName: "info.circle.fill")
                                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                                    )
                            })
                        Rectangle()
                            .frame(width: 120, height: 40)
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                            .cornerRadius(50)
                            .overlay(
                                Text("BETA")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                        PSButton(
                            isPresenting: $isSheet123Presented,
                            label: {
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                                    .cornerRadius(50)
                                    .overlay(
                                        Image(systemName: "terminal.fill")
                                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                                    )
                            })
                        Spacer()
                    }
                }
                Spacer()
                Text("")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                
                Text(errorText)
                    .foregroundColor(.red)
                    .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Без +7", text: $phone)
                            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                            .disabled(isAttacking)
                            .onReceive(Just(phone)) { newPhone in
                                let filteredPhone = newPhone.filter { "0123456789".contains($0) }
                                if filteredPhone.count > 10 {
                                    phone = String(filteredPhone.prefix(10))
                                } else {
                                    phone = filteredPhone
                                }
                                isClearButtonVisible = phone.count == 10
                            }
                        
                        if isClearButtonVisible {
                            Button(action: {
                                withAnimation {
                                    phone = ""
                                    isClearButtonVisible = false
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                                   
                            }
                            .disabled(isAttacking)
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 1.2)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                        .cornerRadius(111)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 34)
                
                VStack(alignment: .leading) {
                    Text("Кол-во повторов: \(Int(sliderValue))")
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                    
                    Rectangle()
                        .frame(height: 1.2)
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                        .cornerRadius(111)
                    
                    CustomSlider(value: $sliderValue)
                        .frame(height: 10)
                        .disabled(isAttacking)
                        .padding(.vertical, 10)
                    
                    HStack {
                               CheckBoxView(isChecked: $isAgreeWithTOS)
                               Text("Я согласен с TOS")
                                   .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.5))
                                   .padding(.vertical, 9)
                           }
                }
                .padding(.vertical, 9)
                .padding(.horizontal, 34)
                
                Button(action: {
                    withAnimation {
                        isBlurred.toggle()
                    }
                    if !isAttacking && isPhoneValid {
                        isAttacking = true
                        message = "Запускаю"
                        animateTextChange(isAttackFinished: false)
                        sendRequests()
                    } else {
                        isAttacking = false
                        message = "Атака отменена"
                    }
                }) {
                    
                    if isAgreeWithTOS {
                        RoundedRectangleView2(isAttacking: $isAttacking)
                    }
                }
                .disabled(!isPhoneValid)
                if isBlurred {
                    RoundedRectangleView(message: $message)
                }
                Spacer()
                PSButton(
                    isPresenting: $isSheetPresented,
                    label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 70)
                                .padding(.horizontal, 25)
                                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                                .blur(radius: 40)
                            
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 70)
                                .padding(.horizontal, 25)
                                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                                .overlay(
                                    Text("Настройки")
                                        .foregroundColor(.white)
                                        .bold()
                                )
                        }
                    })
                
                .partialSheet(isPresented: $isSheetPresented, iPhoneStyle: iPhoneStyle) {
                    BlurredSheetView(selectedBackground: $selectedBackground, isSheet12Presented: $isSheet12Presented)
                }
                .partialSheet(isPresented: $isSheet12Presented, iPhoneStyle: iPhoneStyle) {
                    HowToView()
                }
                .partialSheet(isPresented: $isSheet123Presented, iPhoneStyle: iPhoneStyle) {
                    LogsSoon()
                }
                .padding()
            }
            .background(
                Image(selectedBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            .attachPartialSheetToRoot()
            .onAppear {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Следите за новостями в канале Ecliptica!"),
                    primaryButton: .default(Text("Канал")) {
                        if let url = URL(string: "https://t.me/EclipticaBomber") {
                            UIApplication.shared.open(url)
                        }
                    },
                    secondaryButton: .cancel(Text("Отменить"))
                )
            }
        }
    }
        func animateTextChange(isAttackFinished: Bool) {
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    switch message {
                    case "Ecliptica!":
                        message = "Запускаю"
                        timer.fireDate = Date().addingTimeInterval(3)
                    case "Запускаю":
                        message = "Меняю UserAgent"
                        timer.fireDate = Date().addingTimeInterval(4)
                    case "Меняю UserAgent":
                        message = "Отправляю запрос на сервер"
                        timer.fireDate = Date().addingTimeInterval(2)
                    case "Отправляю запрос на сервер":
                        message = isAttackFinished ? "Атака успешно закончилась" : "t.me/EclipticaBomber"
                    default:
                        break
                    }
                }
            }
        }
        
        func sendRequests() {
            let numberOfThreadsInt = Int(round(sliderValue))
            if numberOfThreadsInt > 0 {
                let services = ["RaiffeisenSite", "secondSite", "akbarsa", "yota", "rek", "bet", "dom", "kit", "rig", "rig1", "sok"]
                
                DispatchQueue.global().async {
                    for i in 0..<numberOfThreadsInt {
                        for service in services {
                            NetworkManager.shared.startSpam(phone: phone, numberOfThreads: String(numberOfThreadsInt), service: service) { error in
                                errorText = error.localizedDescription
                            }
                            
                            if i < numberOfThreadsInt - 1 {
                                Thread.sleep(forTimeInterval: 1)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        animateTextChange(isAttackFinished: true)
                    }
                }
            }
        }
    }

struct RoundedRectangleView2: View {
    @Binding var isAttacking: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .frame(height: 50)
            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
            .overlay(
                Text(isAttacking ? "Отменить" : "Начать")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            )
            .padding(.horizontal, 34)
    }
}
struct CheckBoxView: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .foregroundColor(isChecked ? (Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7)) : (Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1)))
        }
    }
}
struct CustomSlider: View {
    @Binding var value: Double
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(15)
                Rectangle()
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.7))
                    .frame(width: min(CGFloat(self.value / 20) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .cornerRadius(15)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let newValue = Double(gesture.location.x / geometry.size.width) * 20
                        self.value = max(min(newValue, 20), 0)
                    }
            )
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

