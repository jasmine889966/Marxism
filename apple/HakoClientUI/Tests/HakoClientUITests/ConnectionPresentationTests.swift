import XCTest
@testable import HakoClientUI

final class ConnectionPresentationTests: XCTestCase {
    private func present(_ status: String, profile: String? = "Local test", error: String = "", switching: Bool = false, recovery: HakoHomeRecoveryMode = .none) -> HakoHomeConnectionPresentation {
        HakoHomeConnectionPresenter.presentation(for: .init(activeProfileName: profile, vpnStatus: status, errorMessage: error, isSwitchingProxy: switching, recoveryMode: recovery))
    }
    func testStateAndActionContractSurvivesTheme() {
        let cases: [(HakoHomeConnectionPresentation, HakoHomeConnectionPhase, HakoHomePrimaryAction)] = [
            (present("disconnected", profile: nil), .noProfile, .openProfiles),
            (present("disconnected"), .ready, .connect),
            (present("connecting"), .connecting, .cancel),
            (present("disconnecting"), .connecting, .none),
            (present("connected"), .connected, .disconnect),
            (present("reasserting"), .connected, .disconnect),
            (present("connected", switching: true), .switching, .cancel),
            (present("disconnected", error: "Test failure"), .recoverableError, .retry),
            (present("invalid"), .recoverableError, .retry),
            (present("connected", recovery: .direct), .directRecovery, .retryProxy)
        ]
        for (presentation, phase, action) in cases {
            XCTAssertEqual(presentation.phase, phase)
            XCTAssertEqual(presentation.primaryAction, action)
            XCTAssertEqual(presentation.primaryActionEnabled, action != .none)
        }
    }
    func testUnknownTrafficDurationIsNotInvented() {
        XCTAssertEqual(HakoHomeStatusLine.text(subtitle: "Ready", duration: nil, isConnected: false), "Ready")
        XCTAssertEqual(HakoHomeStatusLine.text(subtitle: "Ready", duration: "00:15", isConnected: false), "Ready")
        XCTAssertEqual(HakoHomeStatusLine.text(subtitle: "Connected", duration: "00:15"), "Connected · 00:15")
    }
    func testThemedCopyDistinguishesCancellationAndRecovery() {
        let cancelling = present("connecting")
        let disconnecting = present("disconnecting")
        XCTAssertNotEqual(SovietConnectionCopy.state(cancelling), SovietConnectionCopy.state(disconnecting))
        XCTAssertEqual(cancelling.primaryAction, .cancel)
        XCTAssertEqual(disconnecting.primaryAction, .none)
        let recovered = present("connected", recovery: .direct)
        XCTAssertEqual(SovietConnectionCopy.state(recovered), "Direct connection restored")
        XCTAssertNotEqual(SovietConnectionCopy.state(recovered), SovietConnectionCopy.state(present("connected")))
    }
}
