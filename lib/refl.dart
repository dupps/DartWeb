library refl;

import 'dart:mirrors' as mirrors;

class Reflector {
  static ClassMirror stringClass = mirrors.reflectClass(String);
  static ClassMirror intClass = mirrors.reflectClass(int);
  static ClassMirror doubleClass = mirrors.reflectClass(double);
  static ClassMirror boolClass = mirrors.reflectClass(bool);
  static ClassMirror dateTimeClass = mirrors.reflectClass(DateTime);

  static Map<Symbol, DeclarationMirror> getFieldsOfClassOnly(ClassMirror clazz) {
    Map<Symbol, DeclarationMirror> result = new Map<Symbol, DeclarationMirror>();
    clazz.declarations.forEach((key, value) {
      if (value is mirrors.VariableMirror && !(value as mirrors.VariableMirror).isFinal
        && !(value as mirrors.VariableMirror).isStatic) {
        result[key] = value;
      }
    });
    return result;
  }

  static Map<Symbol, DeclarationMirror> getFieldMirrors(ClassMirror clazz) {
    Map<Symbol, DeclarationMirror> result = new Map<Symbol, DeclarationMirror>();
    result = getFieldsOfClassOnly(clazz);
    if (clazz.superclass != null) {
      result.addAll(getFieldMirrors(clazz.superclass));
    }
    return result;
  }

  static String getSymbolName(Symbol symbol) {
    return mirrors.MirrorSystem.getName(symbol);
  }

  static ClassMirror getFieldClass(VariableMirror variable) {
    return variable.type;
  }

  static bool isDBPrimitive(VariableMirror variable) {
    ClassMirror cm = getFieldClass(variable);
    return (cm == stringClass || cm == intClass ||
      cm == doubleClass || cm == boolClass || cm == dateTimeClass);
  }
}