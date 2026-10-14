# Flutter Engine ProGuard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }
-keep class io.flutter.classloader.** { *; }
-keep class io.flutter.FlutterInjector { *; }

# Preserve native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve standard attributes
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Suppress non-critical optimization warnings
-dontwarn io.flutter.**
