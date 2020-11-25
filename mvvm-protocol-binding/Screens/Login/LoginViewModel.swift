import SwiftUI
import Services

// MARK: - Protocol
protocol LoginViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var showAlert: Bool { get set }
    var alertViewModel: AlertViewModel { get }
    var title: String { get }
    var usernameModel: TextInputViewModel { get }
    var passwordModel: TextInputViewModel { get }
    var loginButtonModel: ButtonViewModel { get }
}

// MARK: - Implementation
final class LoginViewModel: LoginViewModelProtocol {

    private let context: LoginFactory.Context
    private let navigationDelegate: LoginNavigationDelegateProtocol

    @Published var isLoading = false
    @Published var showAlert = false
    var alertViewModel = AlertViewModel.empty()
    let title = "Neumorphism"

    var username: String = ""
    lazy var usernameModel = TextInputViewModel(
        icon: "person.fill",
        placeholder: "Username",
        isSecureInput: false,
        text: Binding<String>(
            get: {  [weak self] () -> String in
                SS(self?.username)
            },
            set: { [weak self] (value: String) in
                self?.username = value
            }
        )
    )

    var password: String = ""
    lazy var passwordModel = TextInputViewModel(
        icon: "lock.fill",
        placeholder: "Password",
        isSecureInput: true,
        text: Binding<String>(
            get: { [weak self] () -> String in
                SS(self?.password)
            },
            set: { [weak self] (value: String) in
                self?.password = value
            }
        )
    )

    lazy var loginButtonModel = ButtonViewModel(title: "Login") { [weak self] in
        self?.loginButtonAction()
    }

    init(context: LoginFactory.Context, navigationDelegate: LoginNavigationDelegateProtocol) {
        self.context = context
        self.navigationDelegate = navigationDelegate
    }
}

// MARK: - Action
fileprivate extension LoginViewModel {

    func loginButtonAction() {
        isLoading = true
        context.authorizationService.authorizeWith(
            username: username,
            password: password,
            completion: { [weak self] (result: Result<Void, AuthorizationError>) in
                self?.isLoading = false
                switch result {
                case .success:
                    self?.navigationDelegate.loginCompletedSuccessfully()

                case .failure:
                    self?.alertViewModel = AlertViewModel(
                        title: "Error",
                        message: "The operation could not be completed. You entered incorrect login details",
                        dismissButton: ButtonViewModel(title: "Ok"))
                    self?.showAlert = true
                }
            }
        )
    }
}

// MARK: - Mock
final class LoginViewModelMock: LoginViewModelProtocol {

    @Published var isLoading = false
    @Published var showAlert = false
    var alertViewModel = AlertViewModel.empty()
    let title = "Neumorphism"
    var usernameModel: TextInputViewModel
    var passwordModel: TextInputViewModel
    var loginButtonModel: ButtonViewModel

    static func mock(isLoading: Bool = false,
                     usernameModel: TextInputViewModel = .mock(),
                     passwordModel: TextInputViewModel = .mock(icon: "lock.fill", placeholder: "Password", isSecureInput: true),
                     loginButtonModel: ButtonViewModel = .mock()) -> LoginViewModelMock {
        return LoginViewModelMock(isLoading: isLoading,
                                  usernameModel: usernameModel,
                                  passwordModel: passwordModel,
                                  loginButtonModel: loginButtonModel)
    }

    init(isLoading: Bool, usernameModel: TextInputViewModel, passwordModel: TextInputViewModel, loginButtonModel: ButtonViewModel) {
        self.isLoading = isLoading
        self.usernameModel = usernameModel
        self.passwordModel = passwordModel
        self.loginButtonModel = loginButtonModel
    }
}
