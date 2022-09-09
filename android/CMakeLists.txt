# cat > android/CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.4.1)  # for example

add_library( trial_ffi

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             ../ios/Classes/trial_ffi.cpp )
# EOF