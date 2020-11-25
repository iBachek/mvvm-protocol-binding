import Foundation

//// MARK: - RequestProtocol
//
///// Represents CAS requests. Every request must specify its parameters and
///// its response type (can also be `Void` in case there is no response).
/////
///// - note: `parameters` are currently defined as a read-write property because
///// `APIClient` modifies `loginType` when `send` is called [tech debt].
//public protocol RequestProtocol: AnyObject {
//    typealias JSONDictionary<T, V> = Dictionary<T, V> where T: Hashable
//    associatedtype Parameters: RequestParametersProtocol
//    associatedtype Response
//
//    var parameters: Parameters { get set }
//    var httpMethod: APIHTTPMethod { get }
//    var cacheRule: CacheRule { get }
//    var isHMACRequired: Bool { get }
//    var processorRule: ErrorProcessorRule { get set }
//
//    var headers: [String: String] { get }
//    var body: JSONDictionary<String, Any>? { get }
//    var query: Array<URLQueryItem> { get }
//    func response(_ body: Data, headers: [String: String]?, statusCode: APIHttpStatusCode) throws -> Response
//
//    //TODO: https://jira.lgi.io/browse/CAPDEV-68987 this is temporary solution, will be changed during CAPDEV-68987 implementation
//    var isTestMode: Bool { get }
//}
//
//public extension RequestProtocol {
//    var headers: [String: String] {
//        return (try? parameters.headers?.convertToDictionary()?.mapValues({ "\($0)" })) ?? [:]
//    }
//
//    var body: JSONDictionary<String, Any>? {
//        return try? parameters.body?.convertToDictionary()
//    }
//
//    var query: Array<URLQueryItem> {
//        return (try? parameters.query?.convertToDictionary()?.mapQueryItems()) ?? []
//    }
//}
//
//public extension RequestProtocol {
//    var isTestMode: Bool {
//        return false
//    }
//}
//
//public extension RequestProtocol {
//    typealias Completion = (Result<APIResponse<Response>, APIError>) -> Void
//}
//
//public protocol UnknownCaseRepresentable: RawRepresentable {
//    static var unknownCase: Self { get }
//}
//
//public extension UnknownCaseRepresentable where RawValue: Decodable {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let rawValue = try container.decode(RawValue.self)
//        guard let extractedRawValue = Self(rawValue: rawValue) else {
//            self = Self.unknownCase
//            logError(.decrypting, "Unknown enum case detected with raw value: \(rawValue)")
//            return
//        }
//        self = extractedRawValue
//    }
//}
//
//public struct FailableDecodable<Base: Decodable & Equatable>: Decodable, Equatable {
//    public let base: Base?
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        self.base = try? container.decode(Base.self)
//    }
//
//    public init(_ value: Base) {
//        self.base = value
//    }
//
//    public static func == (lhs: FailableDecodable<Base>, rhs: FailableDecodable<Base>) -> Bool {
//        return lhs.base == rhs.base
//    }
//}
//
//public protocol RequestParametersProtocol: Hashable {
//    associatedtype RequestHeaderParameters: DictionaryConvertible
//    associatedtype RequestQueryParameters: DictionaryConvertible
//    associatedtype RequestBodyParameters: DictionaryConvertible
//
//    var headers: RequestHeaderParameters? { get }
//    var query: RequestQueryParameters? { get }
//    var body: RequestBodyParameters? { get }
//    var loginType: CASLoginType? { get set }
//}
//
///// In the case when no need to process headers, query or body use this class
//public struct EmptyRequestParameters: Encodable, Hashable, Equatable, DictionaryConvertible {
//
//}
//
//// swiftlint:disable unused_setter_value
//public extension RequestProtocol {
//    var isHMACRequired: Bool {
//        get {
//            return false
//        }
//        set {
//
//        }
//    }
//}
//// swiftlint:enable unused_setter_value
