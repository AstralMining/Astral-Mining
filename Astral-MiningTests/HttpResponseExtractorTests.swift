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
        let response = NSHTTPURLResponse(URL: NSURL(string: "/anything")!, statusCode: 200,
            HTTPVersion: "1.1", headerFields: nil)!
        let extractor = HttpResponseExtractor(response: response)
        
        XCTAssertEqual(200, extractor.statusCode(), "Status codes shall be equal")
    }
    
    func testExtractSessionCookieForEmptyHeaders() {
        let response = NSHTTPURLResponse(URL: NSURL(string: "/anything")!, statusCode: 200,
            HTTPVersion: "1.1", headerFields: nil)!
        let extractor = HttpResponseExtractor(response: response)
        
        XCTAssertNil(extractor.sessionCookie(), "Shall be nil session cookie")
    }
}
