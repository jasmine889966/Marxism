import Foundation
#if os(macOS)
import Security
#endif

/// CloudKit traps (rather than throwing) when an unentitled macOS process
/// initializes CKContainer. Check before construction; signed builds are unchanged.
public enum CloudKitAvailability {
    public static let unavailableMessage = "This build does not have the iCloud capability. Sign it with an Apple Developer team and enable its iCloud container."

    public static func permitsContainer(_ identifier: String) -> Bool {
        // configure.py records the actual build setting; never call CKContainer
        // in a deliberately unsigned simulator/UI build either.
        if Bundle.main.object(forInfoDictionaryKey: "MarxismCodeSigningAllowed") as? String == "NO" {
            return false
        }
        #if os(macOS)
        guard let task = SecTaskCreateFromSelf(nil) else { return false }
        let services = SecTaskCopyValueForEntitlement(task, "com.apple.developer.icloud-services" as CFString, nil) as? [String]
        let containers = SecTaskCopyValueForEntitlement(task, "com.apple.developer.icloud-container-identifiers" as CFString, nil) as? [String]
        return permitsContainer(identifier, services: services, containers: containers)
        #else
        return true
        #endif
    }

    static func permitsContainer(_ identifier: String, services: [String]?, containers: [String]?) -> Bool {
        services?.contains("CloudKit") == true && containers?.contains(identifier) == true
    }
}
