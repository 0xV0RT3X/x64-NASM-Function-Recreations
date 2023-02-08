# Compiler to be used
CC = nasm

# Compiler flags
CFLAGS = -f elf64

# Include paths for header files
INCLUDES =

# Output binary name
TARGET = bin/main

# Object files, generated from source files
OBJECTS = $(patsubst src/%.asm, obj/%.o, $(wildcard src/*.asm))

# Source files
SOURCES = $(wildcard src/*.asm)

# Default target
all: $(TARGET)

# Link object files to generate the target binary
$(TARGET): $(OBJECTS)
	ld $(OBJECTS) -o $(TARGET)

# Compile each source file into an object file
obj/%.o: src/%.asm $(INCLUDES)
	$(CC) $(CFLAGS) -o $@ $<

# Create object and bin directories if they don't exist
$(OBJECTS) $(TARGET): | bin obj
bin obj:
	mkdir $@

# Clean target
clean:
	rm -rf $(OBJECTS) $(TARGET) bin obj

run: $(TARGET)
	./$(TARGET)

# Phony targets
.PHONY: all clean

