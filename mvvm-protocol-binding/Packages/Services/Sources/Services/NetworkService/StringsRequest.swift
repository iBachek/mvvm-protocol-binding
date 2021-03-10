import Foundation

/// **GET** www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new
///
/// Get a list of random strings
///
public struct StringsRequest {
    let url = "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
}

// MARK: Mapping
extension StringsRequest {
    public func responseBody(_ data: Data, response: URLResponse?) -> StringsResponseBody {
        StringsResponseBody(from: data)
    }
}

/// Parsed GET random.strings response
///
/// This struct is result of parsing the **GET www.random.org/strings** successfull response.
/// Response will be string with the next structure:
/// ```
/// "
/// string\n
/// string\n
/// string\n
/// string\n
/// string\n
/// "
/// ```
public struct StringsResponseBody {
    public let strings: [String]

    public init(strings: [String]) {
        self.strings = strings
    }

    public init(from data: Data) {
        let string = String(decoding: data, as: UTF8.self)
        strings = string.components(separatedBy: "\n")
            .filter { !$0.isEmpty }
    }
}





