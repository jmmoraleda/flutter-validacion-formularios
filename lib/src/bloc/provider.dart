import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';


class Provider extends InheritedWidget {

  // Implementamos el patrón Singleton para tener una sola instancia ...

  static Provider _instancia;

  factory Provider({ Key key, Widget child }) { // Aquí se decide si devolvemos una nueva instancia o una ya existente

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  final loginBloc = LoginBloc();

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; // Sobreescribimos esta función que dice que cada vez que haya un cambio debemos
                                                              // notificarlo a todos los hijos

  static LoginBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

}