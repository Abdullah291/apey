

class SignUp_Validation{
  String emailValidator(String value)
  {
    Pattern pattern= r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp reg=new RegExp(pattern);
    if(value.isEmpty)
    {
      return "Email is empty";
    }

    else if(!reg.hasMatch(value))
    {
      return 'Email Not valid';
    }
    else
    {
      return null;
    }
  }



  String passValidator(String value)
  {
    final hasUppercase = value.contains(new RegExp(r'[A-Z]'));
    final hasDigits = value.contains(new RegExp(r'[0-9]'));
    final hasLowercase = value.contains(new RegExp(r'[a-z]'));
    // bool hasSpecialCharacters = value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if(value.isEmpty)
    {
      return 'Password invalid';
    }
    else if(value.length<6)
    {
      return 'passwrod must be enter the 6 digits';
    }
    // ignore: unrelated_type_equality_checks
    // else if(value.toString()[0]!=hasUppercase)
    // {
    //   return "First character must be capital letter";
    // }
    else if(!hasUppercase)
    {
      return 'One character must be uppercase';
    }
    else if(!hasLowercase)
    {
      return 'One character must be lower case';
    }
    else if(!hasDigits)
    {
      return 'Atleast one digit must be number';
    }
    else
    {
      return null;
    }
  }


  String nameValidator(String value)
  {
    if(value.isEmpty)
    {
      return 'Please enter the name';
    }
    else if(value.length<2)
    {
      return 'Name must be at least three letter';
    }
    else
    {
      return null;
    }
  }
  String surNameValidator(String value)
  {
    if(value.isEmpty)
    {
      return 'Please enter the name';
    }
    else if(value.length<2)
    {
      return 'Name must be at least three letter';
    }
    else
    {
      return null;
    }
  }



}