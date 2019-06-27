//: [Previous](@previous)

//: # Demoing order can matter

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

class RequestCounter: DecoratedRequesting {
    let wrappedRequest: Requesting
    var counter = 0

    init(wrappedRequest: Requesting) {
        self.wrappedRequest = wrappedRequest
    }

    func sendRequest(onCompletion: @escaping (Int) -> Void) {
        counter += 1
        wrappedRequest.sendRequest(onCompletion: onCompletion)
    }

    func printRequestCount() {
        print("\"sendRequest\" was called \(counter) time\(counter == 1 ? "" : "s")")
    }
}

// Request count wrapping both the retry and base request
let onCompletion = { (status: Int) in print("Request completed with http status: \(status)") }
let baseRequest = BaseRequest()
let retryRequest = AutoRetryFailedRequest(wrappedRequest: baseRequest)

let countedRequest = RequestCounter(wrappedRequest: retryRequest)
countedRequest.sendRequest(onCompletion: onCompletion)
countedRequest.printRequestCount()

//: [Next](@next)


