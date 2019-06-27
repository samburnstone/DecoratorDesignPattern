//: [Previous](@previous)

//: # Let's get decorating

import Foundation

protocol Requesting {
    func sendRequest(onCompletion: @escaping (Int) -> Void )
}

protocol DecoratedRequesting: Requesting {
    var wrappedRequest: Requesting { get }
}

struct BaseRequest: Requesting {
    func sendRequest(onCompletion: @escaping (Int) -> Void) {
        onCompletion(500)
    }
}

struct AutoRetryFailedRequest: DecoratedRequesting {
    let wrappedRequest: Requesting

    func sendRequest(onCompletion: @escaping (Int) -> Void) {
        let wrappedOnCompletion = { (httpStatus: Int) in
            if httpStatus == 500 {
                print("Request failed. Retrying...")
                self.wrappedRequest.sendRequest(onCompletion: onCompletion)
            } else {
                onCompletion(httpStatus)
            }
        }
        wrappedRequest.sendRequest(onCompletion: wrappedOnCompletion)
    }
}

let onCompletion = { (status: Int) in print("Request completed with http status: \(status)") }
let baseRequest = BaseRequest()
let retryRequest = AutoRetryFailedRequest(wrappedRequest: baseRequest)
retryRequest.sendRequest(onCompletion: onCompletion)

//: [Next](@next)

