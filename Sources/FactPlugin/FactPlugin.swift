import Foundation

public class FactPlugin {
    private var facts: [String: (type: String, value: Any)]
    
    public init() {
        self.facts = [:]
    }
    
    // Single method that automatically determines the type
    public func addFact(key: String, value: Any) {
        let type = Swift.type(of: value)
        let typeString = String(describing: type)
        facts[key] = (type: typeString, value: value)
    }
    
    // Get both type and value
    public func getFact(key: String) -> (type: String, value: Any)? {
        return facts[key]
    }
    
    // Get just the value with type casting
    public func getValue<T>(key: String) -> T? {
        return facts[key]?.value as? T
    }
    
    // Get the type string for a key
    public func getType(key: String) -> String? {
        return facts[key]?.type
    }
    
    // Write facts to stdout as property list XML
    public func write() {
        let simplifiedFacts = facts.mapValues { $0.value }
        guard let plistData = try? PropertyListSerialization.data(
            fromPropertyList: simplifiedFacts,
            format: .xml,
            options: 0
        ) else {
            return
        }
        FileHandle.standardOutput.write(plistData)
    }
    
    // Print facts in a readable format
    public func printFacts() {
        for (key, fact) in facts {
            print("Key: \(key), Type: \(fact.type), Value: \(fact.value)")
        }
    }
}