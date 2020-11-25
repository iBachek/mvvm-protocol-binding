import XCTest
@testable import mvvm_protocol_binding
@testable import Services

class LoginViewModelTests: XCTestCase {

    var authorizationService: AuthorizationServiceMock!
    var navigationDelegate: LoginNavigationDelegateMock!
    var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        authorizationService = AuthorizationServiceMock()
        navigationDelegate = LoginNavigationDelegateMock()
        let context = LoginFactoryContextMock(authorizationService: authorizationService)
        viewModel = LoginViewModel(context: context, navigationDelegate: navigationDelegate)
    }

    func testInitialState() throws {
        XCTAssertEqual(viewModel.title, "Neumorphism")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showAlert)

        XCTAssertTrue(viewModel.alertViewModel.title.isEmpty)
        XCTAssertTrue(viewModel.alertViewModel.message.isEmpty)

        XCTAssertEqual(viewModel.usernameModel.icon, "person.fill")
        XCTAssertEqual(viewModel.usernameModel.placeholder, "Username")
        XCTAssertFalse(viewModel.usernameModel.isSecureInput)
        XCTAssertTrue(viewModel.usernameModel.text.isEmpty)

        XCTAssertEqual(viewModel.passwordModel.icon, "lock.fill")
        XCTAssertEqual(viewModel.passwordModel.placeholder, "Password")
        XCTAssertTrue(viewModel.passwordModel.isSecureInput)
        XCTAssertTrue(viewModel.passwordModel.text.isEmpty)

        XCTAssertEqual(viewModel.loginButtonModel.title, "Login")
    }

    func testInvalidCredentials() throws {
        viewModel.loginButtonModel.action()
        XCTAssertTrue(authorizationService.authorizeWithCalled)
        XCTAssertTrue(authorizationService.authorizeWithParameters.username.isEmpty)
        XCTAssertTrue(authorizationService.authorizeWithParameters.password.isEmpty)

        authorizationService.authorizeWithCompletion(.failure(.invalidCredentials))
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertViewModel.title, "Error")
        XCTAssertEqual(viewModel.alertViewModel.message, "The operation could not be completed. You entered incorrect login details")
    }

    func testLoadingState() throws {
        viewModel.loginButtonModel.action()
        XCTAssertTrue(viewModel.isLoading)
        authorizationService.authorizeWithCompletion(.success(()))
        XCTAssertFalse(viewModel.isLoading)
    }

    func testAuthorizationParameters() throws {
        let username = "Username"
        let password = "Password"

        viewModel.usernameModel.text = username
        viewModel.passwordModel.text = password
        XCTAssertEqual(viewModel.username, username)
        XCTAssertEqual(viewModel.password, password)

        viewModel.loginButtonModel.action()
        XCTAssertEqual(authorizationService.authorizeWithParameters.username, username)
        XCTAssertEqual(authorizationService.authorizeWithParameters.password, password)
    }
}

struct LoginFactoryContextMock: LoginFactory.Context {
    var authorizationService: AuthorizationServiceProtocol
}

class AuthorizationServiceMock: AuthorizationServiceProtocol {
    var authorizeWithCalled: Bool = false
    var authorizeWithParameters: (username: String, password: String) = (username: String(), password: String())
    var authorizeWithCompletion: (Result<Void, AuthorizationError>) -> Void = { _ in }
    func authorizeWith(username: String, password: String, completion: @escaping (Result<Void, AuthorizationError>) -> Void) {
        authorizeWithCalled = true
        authorizeWithParameters = (username: username, password: password)
        authorizeWithCompletion = completion
    }
}
