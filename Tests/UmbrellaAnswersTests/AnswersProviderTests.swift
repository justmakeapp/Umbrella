import Answers
import Umbrella
import UmbrellaAnswers
import XCTest

final class AnswersProviderTests: XCTestCase {
    func testAnswersProvider() {
        let provider = AnswersProvider()
        XCTAssertTrue(provider.cls === Answers.self)
        XCTAssertNil(provider.instance)
        XCTAssertEqual(provider.selector, #selector(Answers.logCustomEvent(withName:customAttributes:)))
        XCTAssertTrue(provider.responds)
    }
}
