//
//  CountryService.swift
//  NaverSens
//
//  Created by 박제형 on 10/8/24.
//

import Foundation
import Alamofire
import CommonCrypto

class CountryViewModel {
    
    private var accessKey: String = ""
    private var secretKey: String = ""
    private var serviceId: String = ""
    private var senderPhone: String = ""
    
    init(accessKey: String, secretKey: String, serviceId: String, senderPhone: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.serviceId = serviceId
        self.senderPhone = senderPhone
    }
    
    func sendSMS(message: SMSMessages, completion: @escaping(SMSResponse) -> ()) {
        let url = URL(string: )
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let timestamp = String(Int(Date().timeIntervalSince1970 * 1000))
        let signature = generateSignature(timestamp: timestamp)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        request.setValue(timestamp, forHTTPHeaderField: "x-ncp-apigw-timestamp")
        request.setValue(accessKey, forHTTPHeaderField: "x-ncp-iam-access-key")
        request.setValue(signature, forHTTPHeaderField: "x-ncp-apigw-signature-v2")
        
        let body: [String: Any] = [
            "type": "SMS",
            "contentType": "COMM",
            "contryCode": "82",
            "from": senderPhone,
            "content": message.content,
            "messages": [
                ["to": message.to]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let response = try JSONDecoder().decode(SMSResponse.self, from: data)
                completion(response)
            } catch {
                
            }
        }.resume()
    }
    
    func generateSignature(timestamp: String) -> String {
        let url =
        let message = "POST" + " " + url + " " + timestamp + "\n" + accessKey
        let keyData = secretKey.data(using: .utf8)!
        var macOut = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        keyData.withUnsafeBytes { keyBytes in
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes.baseAddress!, keyBytes.count, message, message.utf8.count, &macOut)
        }

        let hmacData = Data(bytes: macOut, count: Int(CC_SHA256_DIGEST_LENGTH))
        let base64Encoded = hmacData.base64EncodedString()

        return base64Encoded
    }

}
