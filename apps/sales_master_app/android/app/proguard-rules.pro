# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep C++ JNI bindings
-keepclasseswithmembers class * {
    native <methods>;
}

# Keep annotations
-keepattributes *Annotation*

# Keep Firebase/GMS (if used)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.protobuf.** { *; }

# Keep Kotlin (if project has Kotlin code)
-keep class kotlin.Metadata { *; }

# Suppress warnings
-dontwarn io.flutter.embedding.**
-dontwarn io.flutter.plugin.**

