

class ResgisterModel{

  String firstName;
  String lastName;
  int cin;
  String address;
  int phone;
  String email;
  String password;

    ResgisterModel({
     this.firstName="",
     this.lastName="",
     this.cin=0,
     this.address="",
     this.phone=0,
     this.email="",
     this.password="",

  });
  get getFirstName => this.firstName;

 set setFirstName( firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

 set setLastName( lastName) => this.lastName = lastName;

  get getCin => this.cin;

 set setCin( cin) => this.cin = cin;

  get getAddress => this.address;

 set setAddress( address) => this.address = address;

  get getPhone => this.phone;

 set setPhone( phone) => this.phone = phone;

  get getEmail => this.email;

 set setEmail( email) => this.email = email;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;


@override
String toString() =>'Register object :(firstName :$firstName ,lastName:$lastName, Cin: $cin, addresss: $address ,phone :$phone ,email:$email ,password: $password)';

}