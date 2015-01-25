import Foundation

class UserRecord {
    var loginName: String!
    var displayName: String!
    var resourceUrl: String!
    var sessionCookie: String?
    
    init(loginName: String!, displayName: String!,
        resourceUrl: String!, sessionCookie: String?) {
        self.loginName = loginName
        self.displayName = displayName
        self.resourceUrl = resourceUrl
        self.sessionCookie = sessionCookie
    }
}
