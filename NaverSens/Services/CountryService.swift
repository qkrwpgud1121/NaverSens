//
//  CountryService.swift
//  NaverSens
//
//  Created by 박제형 on 10/8/24.
//

import Foundation
import Alamofire
import CommonCrypto

class CountryService {
    
    private let baseURL: String = "https://sens.apigw.ntruss.com/sms/v2/services/"
    private let serviceId: String = "ncp:sms:kr:340377429506:hodu"
    private let fromNum: String = "024111151"
    private let accessKey: String = "ncp_iam_BPAMKR5rtUxxT7o8i7mB"
    private let timeStamp = String(Int(Date().timeIntervalSince1970 * 1000))
    private let secretKey: String = "ncp_iam_BPKMKRFppoxs86GGhanPcZmKxVmL71u5wY"
    
    
    func naverSensRequest(to: String, content: String, countryCode: String) {
        let signature: String = makeSignature()
        let urlString = baseURL + serviceId + "/messages"
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json; charset=utf-8",
            "x-ncp-apigw-timestamp": timeStamp,
            "x-ncp-iam-access-key": accessKey,
            "x-ncp-apigw-signature-v2": signature
        ]
        
        let smsRequest = Request(type: "SMS", countryCode: countryCode, from: fromNum, content: content, messages: [Messages(to: to)])
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.headers = headers
        request.httpBody = try? JSONEncoder().encode(smsRequest)
        print(request.headers)
        //AF.request(request).responseDecodable(of: Response.self) { response in
        AF.request(request).response { response in
            switch response.result {
            case .success(let value):
                print("1")
                print(String(value))
            case .failure(let error):
                print("2")
                print(error)
            }
        }
    }
    
    func makeSignature() -> String {
        let url = "/sms/v2/services/ncp:sms:kr:340377429506:hodu/messages"
        let message = "POST" + " " + url + " " + timeStamp + "\n" + accessKey
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
