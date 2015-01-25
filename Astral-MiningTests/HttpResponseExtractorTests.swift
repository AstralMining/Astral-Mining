import UIKit
import XCTest

class HttpResponseExtractorTests: XCTestCase {
    
    var foo: HttpResponseExtractor?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCorrectStatusCodeShallBeExtracted() {
        let extractor = mkHttpResponseExtractor(nil)
        
        XCTAssertEqual(200, extractor.statusCode(), "Status codes shall be equal")
    }
    
    func testExtractSessionCookieForEmptyHeaders() {
       let extractor = mkHttpResponseExtractor(nil)
        
        XCTAssertNil(extractor.sessionCookie(), "Shall be nil session cookie")
    }
    
    func testExtractSessionCookieFromHeaders() {
        var headers = Dictionary<String, String>()
        headers["Set-Cookie"] = "foo=bar; session=123; baz=baaz"
        let extractor = mkHttpResponseExtractor(headers)

        if let sessionCookie = extractor.sessionCookie() {
            XCTAssertEqual("session=123", sessionCookie, "Shall be equal cookies")
        } else {
            XCTAssertTrue(false, "Shall not be nil")
        }
    }
    
    private func mkHttpResponseExtractor(headerFields: [String: String]?) -> HttpResponseExtractor {
        let response = NSHTTPURLResponse(URL: NSURL(string: "/anything")!, statusCode: 200,
                HTTPVersion: "HTTP/1.1", headerFields: headerFields)!
        let extractor = HttpResponseExtractor(response: response)
        
        return extractor
    }
}
