import XCTest
@testable import Services

class RabbitHoleServiceTests: XCTestCase {

    var networkService: NetworkServiceMock!

    override func setUpWithError() throws {
        networkService = NetworkServiceMock()
    }

    func testNetworkUsage() throws {
        let rabbitHoleService = RabbitHoleService(networkService: networkService)
        rabbitHoleService.getStrings { _ in }

        XCTAssertTrue(networkService.performCalled)
        XCTAssertNotNil(networkService.requestInputParameter)
        XCTAssertTrue(networkService.requestInputParameter is StringsRequest)
    }
}

class NetworkServiceMock: NetworkServiceProtocol {

    var performCalled: Bool = false
    var requestInputParameter: Any? = nil
    func perform<T, U>(request: T, completion: @escaping (Result<U, NetworkServiceError>) -> Void) {
        performCalled = true
        requestInputParameter = request
    }
}
