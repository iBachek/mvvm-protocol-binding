import UIKit
import Services

final class AppCoordinator: CoordinatorProtocol {

    typealias Context = AuthorizationServiceHolderProtocol &
                        RabbitHoleServiceHolderProtocol

    private let context: Context = AppDelegate.shared.context
    let navigationController: UINavigationController
    private let screenFactory: AppCoordinatorScreenFactoryProtocol
//    private var navigator: AppCoordinatorNavigatorProtocol

    private enum Scene {
        case login
        case strings
    }

    init(navigationController: UINavigationController = UINavigationController(),
         screenFactory: AppCoordinatorScreenFactoryProtocol = AppCoordinatorScreenFactory()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = UIColor.darkGray
        self.screenFactory = screenFactory
    }

    func start() {
        route(to: .login)
    }
}

// MARK: - Route
fileprivate extension AppCoordinator {

    private func route(to scene: Scene) {
        switch scene {
        case .login:
            diplayLoginScene()

        case .strings:
            diplayStringsScene()
        }
    }
}

// MARK: - .login Navigation
extension AppCoordinator: LoginNavigationDelegateProtocol {

    func diplayLoginScene() {
        let viewController = screenFactory.makeLoginScene(navigationDelegate: self)
        push(viewController: viewController)
    }

    func loginCompletedSuccessfully() {
        route(to: .strings)
    }
}

// MARK: - .strings Navigation
extension AppCoordinator {

    func diplayStringsScene() {
        let viewController = screenFactory.makeStringsScene()
        push(viewController: viewController)
    }
}

// MARK: - Navigation
fileprivate extension AppCoordinator {

    func push(viewController: UIViewController) {
        if navigationController.viewControllers.isEmpty {
            navigationController.viewControllers = [viewController]
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
