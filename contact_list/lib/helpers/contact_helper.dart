import 'package:sqflite/sqflite.dart';

class ContactHelper{

}

class Contact{

  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact(this.id, {this.name, this.email, this.phone, this.img});
}