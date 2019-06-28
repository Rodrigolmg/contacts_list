import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  Contact _editedContact;
  bool _contactEdited = false;


  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.redAccent,
            title: Text(_editedContact.name ?? "New Contact"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(_editedContact.name != null && _editedContact.name.isNotEmpty){
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.redAccent,
          ),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: _editedContact.img != null ?
                              FileImage(File(_editedContact.img)) :
                              AssetImage("images/contact_user.png")
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: TextField(
                      focusNode: _nameFocus,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                              color: Colors.redAccent
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)
                          )
                      ),
                      onChanged: (text){
                        _contactEdited = true;
                        setState(() {
                          _editedContact.name = text;
                          if(text.isEmpty)
                            _editedContact.name = "New Contact";
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.redAccent
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)
                          )
                      ),
                      onChanged: (text){
                        _contactEdited = true;
                        _editedContact.email = text;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                              color: Colors.redAccent
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)
                          )
                      ),
                      onChanged: (text){
                        _contactEdited = true;
                        _editedContact.phone = text;
                      },
                    ),
                  )
                ],
              )
          ),
        ),
        onWillPop: _requestPop
    );
  }

  Future<bool> _requestPop() async{
    if(_contactEdited){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Discard changes?"),
            content: Text("Returning will lost the changes!"),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Yes",
                  style: TextStyle(
                    color: Colors.redAccent
                  ),
                ),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.redAccent
                  ),
                ),
              ),
            ],
          );
        }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}





