import XCTest
import SwiftUI
@testable import mvvm_protocol_binding

class LoginFactoryTests: XCTestCase {
    
    func testFactory() throws {
        let controller = LoginFactory().make(navigationDelegate: LoginNavigationDelegateMock())
        XCTAssertTrue(controller is UIHostingController<LoginView<LoginViewModel>>)
    }
}

class LoginNavigationDelegateMock: LoginNavigationDelegateProtocol {
    var loginCompletedSuccessfullyCalled: Bool = false
    func loginCompletedSuccessfully() {
        loginCompletedSuccessfullyCalled = true
    }
}
