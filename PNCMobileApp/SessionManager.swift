import SwiftUI
internal import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    let threshold: TimeInterval = 300
    var backgroundTimestamp: Date?
    var isSessionExpired: Bool = false
    @Environment(\.scenePhase) private var scenePhase

    func recordBackgroundTimestamp() {
        self.backgroundTimestamp = Date()
    }

    func evaluateSessionTimeout() {
        let totalSec = backgroundTimestamp?.timeIntervalSinceNow
        guard let totalSec else{
            print("No value")
            return
        }
        guard abs(totalSec) <= threshold else {
            isSessionExpired = true
            print("session is no longer valid")
            return
        }
        print(abs(totalSec))
        print(threshold)
        print("session is still valid")
        
    }

}
