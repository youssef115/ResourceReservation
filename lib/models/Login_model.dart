

class LoginModel{

  String email;
  String password;
  get getEmail => this.email;

 set setEmail(email) => this.email = email;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;

LoginModel({
  this.email ="",
  this.password = ""
});
    
    @override
    String toString() => 'LoginModel(email:$email, password:$password)';

}