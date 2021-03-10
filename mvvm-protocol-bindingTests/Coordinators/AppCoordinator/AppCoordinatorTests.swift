import XCTest
@testable import mvvm_protocol_binding

class AppCoordinatorTests: XCTestCase {

    var screenFactory: AppCoordinatorScreenFactoryMock!
    var coordinator: AppCoordinator!

    override func setUpWithError() throws {
        screenFactory = AppCoordinatorScreenFactoryMock()
        coordinator = AppCoordinator(screenFactory: screenFactory)
    }

    func testMakeLoginScene() throws {
        XCTAssertFalse(screenFactory.makeLoginSceneCalled)
        XCTAssertNil(screenFactory.makeLoginSceneNavigationDelegate)
        coordinator.start()
        XCTAssertTrue(screenFactory.makeLoginSceneCalled)
        XCTAssertNotNil(screenFactory.makeLoginSceneNavigationDelegate)
    }

    func testMakeStringsScene() throws {
        coordinator.start()
        XCTAssertFalse(screenFactory.makeStringsSceneCalled)
        coordinator.loginCompletedSuccessfully()
        XCTAssertTrue(screenFactory.makeStringsSceneCalled)
    }
}
