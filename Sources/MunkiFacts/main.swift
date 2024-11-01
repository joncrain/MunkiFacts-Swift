import Foundation

do {
    let pluginManager = PluginManager()
    let facts = try pluginManager.loadAndExecutePlugins()
    
    let conditionalItemsManager = ConditionalItemsManager()
    try conditionalItemsManager.updateConditionalItems(with: facts)
} catch {
    print("Error: \(error)")
    exit(1)
}