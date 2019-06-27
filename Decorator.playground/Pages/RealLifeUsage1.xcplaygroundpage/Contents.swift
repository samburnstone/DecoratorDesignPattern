//: [Previous](@previous)

//: # Real Life Intro

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

let onCompletion = { (status: Int) in print("Request completed with http status: \(status)") }
let baseRequest = BaseRequest()
baseRequest.sendRequest(onCompletion: onCompletion)

//: [Next](@next)
