//
//  SessionHandler.swift
//  DealDash
//
//  Created by Daniel Waiguru on 20/02/2024.
//

import Foundation

enum Session {
    case loggedOut
    case loggedIn(username: String)
}
class SessionHandler: ObservableObject {
    @Published var session: Session = (UserDefaults.standard.string(forKey: Constants.ACCESS_TOKEN_KEY) != nil) ? .loggedIn(username: UserDefaults.standard.string(forKey: Constants.USERNAME_KEY) ?? "") : .loggedOut
    
    func updateSession(as session: Session) {
        self.session = session
    }
}
