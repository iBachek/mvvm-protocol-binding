import XCTest
@testable import Services

class StringsRequestTests: XCTestCase {

    func testStringsRequestParameters() throws {
        let stringsRequest = StringsRequest()

        XCTAssertEqual(
            stringsRequest.url,
            "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
        )
    }

    func testStringsRequestMapping() throws {
        let stringsRequest = StringsRequest()
        let string = "string\nstring\nstring\nstring\nstring\n"
        let data: Data? = string.data(using: .utf8)
        let body = stringsRequest.responseBody(data!, response: nil)

        XCTAssertFalse(body.strings.isEmpty)
        XCTAssertTrue(body.strings.count == 5)
        body.strings.forEach {
            XCTAssertTrue($0 == "string")
        }
    }
}
