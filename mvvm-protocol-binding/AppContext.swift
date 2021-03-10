import Services

typealias AppContextProtocol = AuthorizationServiceHolderProtocol &
                                RabbitHoleServiceHolderProtocol

struct AppContext: AppContextProtocol {

    let authorizationService: AuthorizationServiceProtocol
    let rabbitHoleService: RabbitHoleServiceProtocol

    static func makeContext() -> AppContextProtocol {
        let authorizationService = AuthorizationService()
        let networkService = NetworkService()
        let rabbitHoleService = RabbitHoleService(networkService: networkService)

        // AppContext
        let context = AppContext(
            authorizationService: authorizationService,
            rabbitHoleService: rabbitHoleService
        )

        return context
    }
}

public func SS(_ str: String? ...) -> String {
    return str.compactMap { $0 }.joined(separator: " ")
}
