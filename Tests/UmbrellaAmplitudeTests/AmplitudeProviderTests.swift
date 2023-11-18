import Amplitude_iOS
import Umbrella
import UmbrellaAmplitude
import XCTest

final class AmplitudeProviderTests: XCTestCase {
    func testAmplitudeProvider() {
        let provider = AmplitudeProvider()
        XCTAssertTrue(provider.cls === Amplitude.self)
        XCTAssertNotNil(provider.instance)
        XCTAssertEqual(provider.selector, #selector(Amplitude.logEvent(_:withEventProperties:)))
        XCTAssertTrue(provider.responds)
    }
}
