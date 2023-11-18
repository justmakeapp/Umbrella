import Flurry_iOS_SDK
import Umbrella
import UmbrellaFlurry
import XCTest

final class FlurryProviderTests: XCTestCase {
    func testFlurryProvider() {
        let provider = FlurryProvider()
        XCTAssertTrue(provider.cls === Flurry.self)
        XCTAssertNil(provider.instance)
        XCTAssertEqual(provider.selector, #selector(Flurry.logEvent(_:withParameters:)))
        XCTAssertTrue(provider.responds)
    }
}
