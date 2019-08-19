import 'dart:async';
import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart'; // Extensiones reactivas. En este caso la usamos para combinar los stream para habilitar el botón de "Ingresar"

class LoginBloc with Validators {


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );

  Stream<bool> get formValidStream => // Combinando los stream podemos saber si el formulario es o no válido
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );



  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add; // Al no poner paréntesis a la función no la ejecuto sólo la mando como referencia
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  dispose() { // Método para cerrar los streams cuando ya no los necesito
    _emailController?.close(); // La interrogación nos dice que sólo lo ejecuta si exite
    _passwordController?.close();
  }

}

