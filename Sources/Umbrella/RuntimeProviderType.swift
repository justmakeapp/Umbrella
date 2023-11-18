import Foundation

public protocol RuntimeProviderType: ProviderType {
    var className: String { get }
    var instanceSelectorName: String? { get } // optional
    var selectorName: String { get }
}

public extension RuntimeProviderType {
    var cls: NSObject.Type? {
        return NSClassFromString(className) as? NSObject.Type
    }

    var instanceSelectorName: String? {
        return nil
    }

    var instance: AnyObject? {
        guard let cls else { return nil }
        guard let sel = instanceSelectorName.flatMap(NSSelectorFromString) else { return nil }
        guard cls.responds(to: sel) else { return nil }
        return cls.perform(sel)?.takeUnretainedValue()
    }

    var selector: Selector {
        return NSSelectorFromString(selectorName)
    }

    var responds: Bool {
        guard let cls else { return false }
        if let instance {
            return instance.responds(to: selector)
        } else {
            return cls.responds(to: selector)
        }
    }

    func log(_ eventName: String, parameters: [String: Any]?) {
        guard responds else { return }
        if let instance {
            _ = instance.perform(selector, with: eventName, with: parameters)
        } else {
            _ = cls?.perform(selector, with: eventName, with: parameters)
        }
    }
}
