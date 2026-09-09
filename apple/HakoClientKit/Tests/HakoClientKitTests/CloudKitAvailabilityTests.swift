import XCTest
@testable import HakoClientKit

final class CloudKitAvailabilityTests: XCTestCase {
    func testRequiresCloudKitAndExactContainer() {
        let id = "iCloud.io.github.jasmine889966.marxism"
        XCTAssertFalse(CloudKitAvailability.permitsContainer(id, services: nil, containers: nil))
        XCTAssertFalse(CloudKitAvailability.permitsContainer(id, services: ["CloudDocuments"], containers: [id]))
        XCTAssertFalse(CloudKitAvailability.permitsContainer(id, services: ["CloudKit"], containers: ["iCloud.someone.else"]))
        XCTAssertTrue(CloudKitAvailability.permitsContainer(id, services: ["CloudKit"], containers: [id]))
    }

    #if os(macOS)
    func testUnentitledConstructionAndOperationsDoNotTrap() async throws {
        let id = "iCloud.io.github.jasmine889966.marxism"
        guard !CloudKitAvailability.permitsContainer(id) else { throw XCTSkip("Requires unentitled test process") }
        let sink = CloudKitBackupRecordSink(containerIdentifier: id)
        let source = CloudKitBackupRecordSource(containerIdentifier: id)
        do {
            try await sink.deleteOwn(installID: "test-only-never-uploaded")
            XCTFail("Must report unavailable")
        } catch { XCTAssertEqual(error as? BackupRecordSinkError, .unavailable(CloudKitAvailability.unavailableMessage)) }
        do {
            _ = try await source.listBackups()
            XCTFail("Must report unavailable")
        } catch { XCTAssertEqual(error as? BackupRecordSourceError, .unavailable(CloudKitAvailability.unavailableMessage)) }
    }
    #endif
}
