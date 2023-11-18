import StoreKit

public protocol AnalyticsType {
    associatedtype Event: EventType
    func register(provider: ProviderType)
    func log(_ event: Event)
}

public protocol ProviderType {
    func log(_ eventName: String, parameters: [String: Any]?)

    /// Logs in-app purchase events in Google Analytics for Firebase after a `Product` purchase
    /// is successful.
    ///
    /// Call this method after Product.purchase() succeeds and before calling Transaction.finish().
    ///
    /// - Parameter transaction: The Transaction returned from StoreKit 2.
    @available(iOS 15.0, *)
    func logTransaction(_ transaction: Transaction)
}

public protocol EventType {
    func name(for provider: ProviderType) -> String?
    func parameters(for provider: ProviderType) -> [String: Any]?
}

open class Analytics<Event: EventType>: AnalyticsType {
    open private(set) var providers: [ProviderType] = []

    public init() {
        // I'm Analytics 👋
    }

    open func register(provider: ProviderType) {
        providers.append(provider)
    }

    open func log(_ event: Event) {
        for provider in providers {
            guard let eventName = event.name(for: provider) else { continue }
            let parameters = event.parameters(for: provider)
            provider.log(eventName, parameters: parameters)
        }
    }
}
