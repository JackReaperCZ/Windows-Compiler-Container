FROM ubuntu:22.04

# Install build tools
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++-mingw-w64-x86-64 \
    && rm -rf /var/lib/apt/lists/*

# Copy the toolchain into a global location inside the image
COPY windows-toolchain.cmake /opt/windows-toolchain.cmake

# Set workdir to where your project will be mounted
WORKDIR /src

# Set the command to automatically run CMake and Build
# It will look for source in /src and put output in /src/build
CMD ["sh", "-c", "cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=/opt/windows-toolchain.cmake && cmake --build build"]