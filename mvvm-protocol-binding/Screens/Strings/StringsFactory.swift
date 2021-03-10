import SwiftUI
import Services

final class StringsFactory {
    
    typealias Context = RabbitHoleServiceHolderProtocol

    func make() -> UIViewController {
        let context: StringsFactory.Context = AppDelegate.shared.context
        let viewModel = StringsViewModel(context: context)
        let view = StringsView(viewModel: viewModel)

        return UIHostingController(rootView: view)
    }
}
