

 class User{

  
  String? token;
  String? email;
  String? firstname;
  String? lastname;
  int? cin;
  String? role;

 User({ this.token="",
    this.email="",
   this.firstname="",
   this.lastname="",
   this.cin=0,
   this.role=""

   }); 
   
  get getToken => this.token;

 set setToken( token) => this.token = token;

  get getEmail => this.email;

 set setEmail( email) => this.email = email;

  get getFirstname => this.firstname;

 set setFirstname( firstname) => this.firstname = firstname;

  get getLastname => this.lastname;

 set setLastname( lastname) => this.lastname = lastname;

  get getCin => this.cin;

 set setCin( cin) => this.cin = cin;

  get getRole => this.role;

 set setRole( role) => this.role = role;

  
 



  }