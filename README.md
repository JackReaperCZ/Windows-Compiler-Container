# WCC: Windows Compiler Container

**WCC** is a portable, containerized C++ build environment. It allows you to compile Windows executables (`.exe`) from any directory on your machine without ever installing a compiler, CMake, or MinGW on your actual Windows host.

## Features

* **Zero Host Pollution:** Keep your Windows install clean. All build tools stay inside Docker.
* **Global Command:** Run `wcc` from any project folder to trigger a build.
* **Static Linking:** Produces standalone `.exe` files that don't require extra DLLs.
* **Cross-Platform Engine:** Uses Linux-based high-performance tools to target Windows.

---

## Installation

1. **Requirement:** Ensure [Docker Desktop](https://www.docker.com/products/docker-desktop/) is installed and running.

2. **Download:** Place the `windows-compiler` folder anywhere on your PC.

3. **Setup:**

   * Open **Command Prompt (CMD)** as Administrator.
   * Navigate to the folder and run:

     ```batch
     setup.bat
     ```

4. **Restart:** Close and reopen your terminal to refresh the `PATH` variable.

---

## Usage

To compile any C++ project, navigate to your project folder (which must contain a `CMakeLists.txt`) and run:

```batch
wcc
```

### What happens?

1. Docker mounts your current directory to `/src` inside the container.
2. **CMake** configures the project using a hidden Windows toolchain.
3. **Make** compiles your source code.
4. A `build/` folder is created in your project directory containing the compiled `.exe`.

---

## Project Structure Example

To work with `wcc`, your project should look like this:

```text
my-project/
├── CMakeLists.txt
├── src/
│   └── main.cpp
└── include/
    └── my_header.h
```

**Note:** Your `CMakeLists.txt` should be standard. `wcc` handles the cross-compilation flags for you automatically.

---

## Uninstallation

To remove the global command, the Docker image, and clean your System PATH:

1. Open **Command Prompt (CMD)** as Administrator.
2. Navigate to the `windows-compiler` folder and run:

   ```batch
   uninstall.bat
   ```

---

## License

MIT — Feel free to use and modify!
