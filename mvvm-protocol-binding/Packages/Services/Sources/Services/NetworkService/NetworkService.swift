import Foundation

public enum NetworkServiceError: Error {
    case undefined
    case invalidURL
    case session(Error)
}

public protocol NetworkServiceProtocol {
    func perform<T, U>(request: T, completion: @escaping (Result<U, NetworkServiceError>) -> Void)
}

public class NetworkService: NetworkServiceProtocol {

    public init() { }

    public func perform<T, U>(request: T, completion: @escaping (Result<U, NetworkServiceError>) -> Void) {

        // Sorry! Not enough time for Protocols
        let getStringsRequest = request as! StringsRequest // TODO, FIXME, USE Protocol

        let url = URL(string: getStringsRequest.url)!
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if let data = data {
                    let body = getStringsRequest.responseBody(data, response: response)
                    completion(.success(body as! U))
                } else if let error = error {
                    completion(.failure(.session(error)))
                } else {
                    completion(.failure(.undefined))
                }
            }
        }

        task.resume()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                let body = getStringsRequest.responseBody(data, response: response)
            } else if let error = error {
                completion(.failure(.session(error)))
            } else {
                completion(.failure(.undefined))
            }
        }.resume()
    }
}
