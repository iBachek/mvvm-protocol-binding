import SwiftUI
import Services

// MARK: - Protocol
protocol StringsViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var showAlert: Bool { get set }
    var alertViewModel: AlertViewModel { get }
    var items: [StringItem] { get }

    func viewOnAppear()
}

// MARK: - Implementation
final class StringsViewModel: StringsViewModelProtocol {

    @Published var isLoading = true
    @Published var showAlert = false
    var alertViewModel = AlertViewModel.empty()
    @Published var items = [StringItem]()

    private let context: StringsFactory.Context

    init(context: StringsFactory.Context) {
        self.context = context

        items = [
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
            StringItem(icon: "questionmark.square.dashed", string: ". . ."),
        ]
    }

    func viewOnAppear() {
        context.rabbitHoleService.getStrings() { [weak self] (result: Result<StringsResponseBody, NetworkServiceError>) in
            self?.isLoading = false

            switch result {
            case let .success(body):
                self?.items = body.strings
                    .map {
                        StringItem(icon: "terminal.fill", string: $0)
                    }

            case let .failure(error):
                self?.alertViewModel = AlertViewModel(
                    title: "Error",
                    message: "Unfortunately .\(error) occured, please try again later",
                    dismissButton: ButtonViewModel(title: "Ok"))
                self?.showAlert = true
            }
        }
    }
}

// MARK: - Mock
final class StringsViewModelMock: StringsViewModelProtocol {

    @Published var isLoading = true
    @Published var showAlert = false
    var alertViewModel = AlertViewModel.empty()
    @Published var items = [StringItem]()

    static let mockItems = [
        StringItem(icon: "terminal.fill", string: "sdfsdfsdfsdf"),
        StringItem(icon: "terminal.fill", string: "sdfsdfsdfsdf"),
        StringItem(icon: "terminal.fill", string: "sdfsdfsdfsdf"),
        StringItem(icon: "terminal.fill", string: "sdfsdfsdfsdf"),
    ]

    static func mock(isLoading: Bool = true,
                     showAlert: Bool = false,
                     alertViewModel: AlertViewModel = .mock(),
                     items: [StringItem] = mockItems) -> StringsViewModelMock {
        return StringsViewModelMock(isLoading: isLoading,
                                    items: items)
    }

    init(isLoading: Bool, items: [StringItem]) {
        self.isLoading = isLoading
        self.items = items
    }

    lazy var viewOnAppearCalled = false
    func viewOnAppear() {
        viewOnAppearCalled = true
    }
}
