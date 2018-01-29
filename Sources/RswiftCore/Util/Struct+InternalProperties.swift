//
//  Struct+InternalProperties.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 06-10-16.
//  Copyright © 2016 Mathijs Kadijk. All rights reserved.
//

import Foundation

extension Struct {
  func addingInternalProperties(forBundleIdentifier bundleIdentifier: String) -> Struct {

    let internalProperties = [
      Let(
        comments: [],
        accessModifier: .filePrivate,
        isStatic: true,
        name: "hostingBundle",
        typeDefinition: .inferred(Type._Bundle),
        value: "Bundle(path: Bundle.main.path(forResource: hostingBundleLanguage, ofType: \"lproj\") ?? "") ?? Bundle(for: R.Class.self)"),
      Let(
        comments: [],
        accessModifier: .filePrivate,
        isStatic: true,
        name: "applicationLocale",
        typeDefinition: .inferred(Type._Locale),
        value: "hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current"),
      Let(
        comments: [],
        accessModifier: .filePrivate,
        isStatic: true,
        name: "hostingBundleLanguage",
        typeDefinition: .inferred(Type._String),
        value: "UserDefaults.standard.string(forKey: \"Rswfit.hostingBundle.language\")")
    ]

    let internalClasses = [
      Class(accessModifier: .filePrivate, type: Type(module: .host, name: "Class"))
    ]

    var externalStruct = self
    externalStruct.properties.append(contentsOf: internalProperties)
    externalStruct.classes.append(contentsOf: internalClasses)

    return externalStruct
  }
}
