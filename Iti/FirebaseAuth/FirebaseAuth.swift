import Foundation
import Firebase

class FirebaseAuth {
    
    static var userIsLogged = false
    
    func register(authentication: Auth?) {
        
        guard let authentication = authentication else { print("Objeto de autenticação inválido!") }
        
        Auth.auth().createUser(withEmail: authentication.email, password: authentication.password) { authResult, error in
         
            if let error = error {
                print("Erro ao realizar o registro!", error)
            }
            
            if let authResult = authResult {
                print("Registrado com sucesso", authResult)
            }
            
        }
    }
    
    func signIn(authentication: Auth?) {
        
        guard let authentication = authentication else { print("Objeto de autenticação inválido!") }
        
        Auth.auth().signIn(withEmail: authentication.email, password: authentication.password) { [weak self] authResult, error in
            
          guard let strongSelf = self else { return }
          
            if let error = error {
                print("Erro ao realizar o login!", error)
            }
            
            if let authResult = authResult {
                print("Login com sucesso", authResult)
                FirebaseAuth.userIsLogged = true
            }
            
          
        }
        
    }
    
    func signOut() {
        
        let firebaseAuth = Auth.auth()
        
        do {
          try firebaseAuth.signOut()
          FirebaseAuth.userIsLogged = false
          print ("Logout realizado")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
    
}
