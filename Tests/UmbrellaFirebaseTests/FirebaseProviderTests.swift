import Firebase
import Umbrella
import UmbrellaFirebase
import XCTest

final class FirebaseProviderTests: XCTestCase {
    func testFirebaseProvider() {
        let provider = FirebaseProvider()
        XCTAssertTrue(provider.cls === Firebase.Analytics.self)
        XCTAssertNil(provider.instance)
        XCTAssertEqual(provider.selector, #selector(Firebase.Analytics.logEvent(_:parameters:)))
        XCTAssertTrue(provider.responds)
    }
}
