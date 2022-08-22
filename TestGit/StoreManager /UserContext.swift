import Foundation

final class UserContext {
    
    private (set) lazy var userContext = UserContext()
    private lazy var keyChainService = KeychainService()
    private lazy var queue = DispatchQueue(label: "soten.TestGit", qos: DispatchQoS.userInitiated, attributes: .concurrent)
    
    private enum SettingsKeys: String {
        case userName
        case password
        case isAuth
    }
    
    var login: String? {
        get {
            return queue.sync {
                return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue) }
        }
        set {
            queue.async(flags: .barrier) {
                UserDefaults.standard.setValue(newValue, forKey: SettingsKeys.userName.rawValue) }
        }
    }
    var password: String? {
        get {
            return queue.sync {
                return UserDefaults.standard.string(forKey: SettingsKeys.password.rawValue) }
        }
        set {
            queue.async(flags: .barrier) {
                UserDefaults.standard.setValue(newValue, forKey: SettingsKeys.userName.rawValue) }
        }
    }
    var isAuth: Bool {
        get { return UserDefaults.standard.bool(forKey: SettingsKeys.isAuth.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: SettingsKeys.isAuth.rawValue) }
    }
}
