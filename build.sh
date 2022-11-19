echo "compiling for architecture: $1"

NDK=$ANDROID_NDK_HOME

HOST_OS=linux-x86_64

cd ocaml

case "$1" in
    clean)
        make clean
        ;;
    armv7-a)
        export CFLAGS="-m32 -O2 -std=c17"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=armv7a-linux-androideabi
        export API=19
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --enable-debugger --enable-instrumented-runtime --enable-installing-source-artifacts --enable-installing-bytecode-programs --enable-flambda --enable-flambda-invariants --enable-cmm-invariants --disable-native-compiler=no
        make world.opt install
        ;;
    armv8-a)
        export CFLAGS="-O2 -std=c17"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=aarch64-linux-android
        export API=21
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --enable-debugger --enable-instrumented-runtime --enable-installing-source-artifacts --enable-installing-bytecode-programs --enable-flambda --enable-flambda-invariants --enable-cmm-invariants
        make world.opt install
        ;;
    *)
        echo "you didn't specify an architecture or specified invalid one (available options: armv7-a, armv8-a)"
        exit 1
        ;;
esac
