import Foundation

public enum RabbitHoleError: Error {
    case undefined
    case invalidURL
    case session(Error)
}

public protocol RabbitHoleServiceHolderProtocol {
    var rabbitHoleService: RabbitHoleServiceProtocol { get }
}

public protocol RabbitHoleServiceProtocol {
    func getStrings(completion: @escaping (Result<StringsResponseBody, NetworkServiceError>) -> Void)
}

public class RabbitHoleService: RabbitHoleServiceProtocol {

    private let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    public func getStrings(completion: @escaping (Result<StringsResponseBody, NetworkServiceError>) -> Void) {
        let request = StringsRequest()
        networkService.perform(request: request) { (result: Result<StringsResponseBody, NetworkServiceError>) in
            completion(result)
        }
    }
}


