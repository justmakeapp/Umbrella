import Umbrella
import XCTest

class UmbrellaTests: XCTestCase {
    var analytics: Analytics<TestEvent>!
    var firebaseProvider: MockFirebaseProvider!
    var fabricProvider: MockFabricProvider!

    override func setUp() {
        super.setUp()
        analytics = Analytics()
        firebaseProvider = MockFirebaseProvider()
        fabricProvider = MockFabricProvider()
    }

    func testAnalytics_singleProvider() {
        analytics.register(provider: firebaseProvider)
        analytics.log(.login(username: "devxoul"))
        XCTAssertEqual(firebaseProvider.events.count, 1)
        XCTAssertEqual(firebaseProvider.events[0].name, "login")
        XCTAssertEqual(firebaseProvider.events[0].parameters!.count, 1)
        XCTAssertEqual(firebaseProvider.events[0].parameters!["username"] as! String, "devxoul")
    }

    func testAnalytics_singleProvider_nilName() {
        analytics.register(provider: fabricProvider)
        analytics.log(.purchase(productID: 123, price: 99.9))
        XCTAssertEqual(fabricProvider.events.count, 0)
    }

    func testAnalytics_multipleProvider() {
        analytics.register(provider: firebaseProvider)
        analytics.register(provider: fabricProvider)
        analytics.log(.login(username: "devxoul"))
        analytics.log(.purchase(productID: 123, price: 99.9))

        XCTAssertEqual(firebaseProvider.events.count, 2)
        XCTAssertEqual(firebaseProvider.events[0].name, "login")
        XCTAssertEqual(firebaseProvider.events[0].parameters!.count, 1)
        XCTAssertEqual(firebaseProvider.events[0].parameters!["username"] as! String, "devxoul")
        XCTAssertEqual(firebaseProvider.events[1].name, "purchase")
        XCTAssertEqual(firebaseProvider.events[1].parameters!.count, 2)
        XCTAssertEqual(firebaseProvider.events[1].parameters!["product_id"] as! Int, 123)
        XCTAssertEqual(firebaseProvider.events[1].parameters!["price"] as! Float, 99.9)

        XCTAssertEqual(fabricProvider.events.count, 1)
        XCTAssertEqual(fabricProvider.events[0].name, "Login")
        XCTAssertEqual(fabricProvider.events[0].parameters!.count, 1)
        XCTAssertEqual(fabricProvider.events[0].parameters!["Username"] as! String, "devxoul")
    }
}
