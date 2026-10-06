// VENDORED PATCH (SPM registrant compatibility) — not part of upstream.
//
// Flutter's SwiftPM `GeneratedPluginRegistrant` is Swift and emits
// `GoogleCastPlugin.register(with:)` from the pubspec `pluginClass`
// (`GoogleCastPlugin`). The ObjC alias `@objc(GoogleCastPlugin)` on
// `SwiftGoogleCastPlugin` is invisible to the Swift compiler, which broke
// SPM builds with "cannot find 'GoogleCastPlugin' in scope".
//
// This typealias exposes the Swift-visible name. It is deliberately
// EXCLUDED from the CocoaPods sources (see flutter_chrome_cast.podspec
// exclude_files): under CocoaPods the ObjC bridge GoogleCastPlugin.m
// declares the real ObjC class of the same name, which would collide with
// a same-module typealias.
import Foundation

public typealias GoogleCastPlugin = SwiftGoogleCastPlugin
