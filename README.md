# MunkiFacts-Swift
MunkiFacts-Swift is a Swift-based project designed to manage and update conditional items based on various facts. Admins can create multiple plugins to extend its functionality.

## Getting Started

### Building the Project
To build the project, clone the repo and run:

```bash
swift build -c release
```

### Running the Project
After building, to run the project, use (you must install at least one plugin):

```bash
.build/release/munkifacts
```

### Building for Multiple Architectures
To build for both x64 and arm64 architectures, you can use the following commands:

```bash
# Build for x86_64
arch -x86_64 swift build -c release

# Build for arm64
arch -arm64 swift build -c release

# Create a universal binary using lipo
lipo -create -output .build/release/munkifacts .build/x86_64-apple-macosx/release/munkifacts .build/arm64-apple-macosx/release/munkifacts
```

## Plugins

The project supports various plugins to extend its functionality. 

### Example Plugin

```swift
import Foundation
import IOKit.ps
import FactPlugin

let factPlugin = FactPlugin()

let isPluggedIn: Bool = IOPSCopyExternalPowerAdapterDetails()?.takeRetainedValue() != nil
factPlugin.addFact(key: "ac_power", value: isPluggedIn)

factPlugin.write()
```

### Plugin directory

Plugins should be built and placed in the `/usr/local/munki/conditions/plugins` directory. The project will automatically load all plugins in this directory.
