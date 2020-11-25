import UIKit

protocol AppCoordinatorScreenFactoryProtocol {
    func makeLoginScene(navigationDelegate: LoginNavigationDelegateProtocol) -> UIViewController
    func makeStringsScene() -> UIViewController
}

final class AppCoordinatorScreenFactory: AppCoordinatorScreenFactoryProtocol {
    func makeLoginScene(navigationDelegate: LoginNavigationDelegateProtocol) -> UIViewController {
        LoginFactory().make(navigationDelegate: navigationDelegate)
    }

    func makeStringsScene() -> UIViewController {
        StringsFactory().make()
    }
}

class AppCoordinatorScreenFactoryMock: AppCoordinatorScreenFactoryProtocol {
    var makeLoginSceneCalled: Bool = false
    var makeLoginSceneNavigationDelegate: LoginNavigationDelegateProtocol?
    func makeLoginScene(navigationDelegate: LoginNavigationDelegateProtocol) -> UIViewController {
        makeLoginSceneCalled = true
        makeLoginSceneNavigationDelegate = navigationDelegate

        return UIViewController()
    }

    var makeStringsSceneCalled: Bool = false
    func makeStringsScene() -> UIViewController {
        makeStringsSceneCalled = true

        return UIViewController()
    }
}
