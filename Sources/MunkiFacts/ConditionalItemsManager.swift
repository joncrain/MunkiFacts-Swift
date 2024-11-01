import Foundation
import CoreFoundation

class ConditionalItemsManager {
    private func getManagedInstallDir() -> String? {
        let bundleId = "ManagedInstalls"
        let prefName = "ManagedInstallDir"
        return CFPreferencesCopyAppValue(prefName as CFString, bundleId as CFString) as? String
    }
    
    private func loadConditionalItems(at path: String) -> [String: Any] {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let items = try? PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
              ) as? [String: Any] else {
            return [:]
        }
        return items
    }

    private func saveConditionalItems(_ items: [String: Any], to path: String) throws {
        guard let data = try? PropertyListSerialization.data(
            fromPropertyList: items,
            format: .xml,
            options: 0
        ) else {
            throw NSError(
                domain: "MunkiFacts",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Could not serialize conditional items"]
            )
        }
        
        try data.write(to: URL(fileURLWithPath: path))
    }
    
    func updateConditionalItems(with facts: [String: Any]) throws {
        guard let managedInstallDir = getManagedInstallDir() else {
            throw NSError(
                domain: "MunkiFacts",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Could not determine ManagedInstallDir"]
            )
        }

        let conditionalItemsPath = (managedInstallDir as NSString)
            .appendingPathComponent("ConditionalItems.plist")

        var conditionalItems = loadConditionalItems(at: conditionalItemsPath)
        
        conditionalItems.merge(facts) { (_, new) in new }

        try saveConditionalItems(conditionalItems, to: conditionalItemsPath)
    }
}