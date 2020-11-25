import SwiftUI
import Services

protocol LoginNavigationDelegateProtocol {
    func loginCompletedSuccessfully()
}

final class LoginFactory {

    typealias Context = AuthorizationServiceHolderProtocol

    func make(navigationDelegate: LoginNavigationDelegateProtocol) -> UIViewController {
        let context: LoginFactory.Context = AppDelegate.shared.context
        let viewModel = LoginViewModel(context: context, navigationDelegate: navigationDelegate)
        let view = LoginView(viewModel: viewModel)
        
        return UIHostingController(rootView: view)
    }
}
