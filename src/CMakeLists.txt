option(BUILD_WEB "build for web environment")


   include_directories("../extern/libjpeg-turbo" "../build/extern/libjpeg-turbo")

   add_executable(libjpegturbojs jslib.cpp)

   target_link_libraries(libjpegturbojs PRIVATE turbojpeg-static)
   
   target_compile_features(libjpegturbojs PUBLIC cxx_std_11)
   
   if (CMAKE_BUILD_TYPE STREQUAL Debug)
     SET(linkFlags "-g4")
   else() # Either MinSizeRel, RelWithDebInfo or Release, all which run with optimizations enabled.
     SET(linkFlags "-O3")
   endif()
   
   set(CMAKE_CXX_FLAGS_RELEASE "-O3")
   
   if(BUILD_WEB)
    set_target_properties(
      libjpegturbojs 
      PROPERTIES 
      LINK_FLAGS "\
        --bind \
        -s MODULARIZE=1 \
        -s EXPORT_ES6=1 \
        -s EXPORT_NAME=libjpegturbowasm \
        -s DISABLE_EXCEPTION_CATCHING=1 \
        -s ASSERTIONS=0 \
        -s NO_EXIT_RUNTIME=1 \
        -s MALLOC=emmalloc \
        -s ALLOW_MEMORY_GROWTH=1 \
        -s TOTAL_MEMORY=1073741824 \
        -s FILESYSTEM=0 \
        -s EXPORTED_FUNCTIONS=[] \
        -s EXPORTED_RUNTIME_METHODS=[ccall] \
        -s ENVIRONMENT=web \
    ")
  else()
    set_target_properties(
      libjpegturbojs 
      PROPERTIES 
      LINK_FLAGS "\
        --bind \
        -s MODULARIZE=1 \
        -s EXPORT_NAME=libjpegturbowasm \
        -s DISABLE_EXCEPTION_CATCHING=1 \
        -s ASSERTIONS=0 \
        -s NO_EXIT_RUNTIME=1 \
        -s MALLOC=emmalloc \
        -s ALLOW_MEMORY_GROWTH=1 \
        -s TOTAL_MEMORY=1073741824 \
        -s FILESYSTEM=0 \
        -s EXPORTED_FUNCTIONS=[] \
        -s EXPORTED_RUNTIME_METHODS=[ccall] \
    ")
  endif()
   