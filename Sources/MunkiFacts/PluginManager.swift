import Foundation
import CoreFoundation

class PluginManager {
    private let pluginPath: String
    
    init(pluginPath: String = "/usr/local/munki/conditions/plugins") {
        self.pluginPath = pluginPath
    }
    
    func loadAndExecutePlugins() throws -> [String: Any] {
        var allFacts: [String: Any] = [:]
        
        let fileManager = FileManager.default
        guard let plugins = try? fileManager.contentsOfDirectory(
            atPath: pluginPath
        ) else {
            return [:]
        }
        
        for plugin in plugins {
            let pluginURL = URL(fileURLWithPath: "\(pluginPath)/\(plugin)")
            guard fileManager.isExecutableFile(atPath: pluginURL.path) else {
                continue
            }
            
            let process = Process()
            let pipe = Pipe()
            
            process.executableURL = pluginURL
            process.standardOutput = pipe
            
            try process.run()
            process.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let plist = try? PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil
            ) as? [String: Any] {
                allFacts.merge(plist) { _, new in new }
            }
        }
        
        return allFacts
    }
}