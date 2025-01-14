SRC_DIR := ./src
OBJ_DIR := ./obj
#punem .asm in src directory
SRC_FILES := $(wildcard $(SRC_DIR)/*.asm) 
#punem .o in obj directory
OBJ_FILES := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRC_FILES))

CREATE_DIR := $(shell mkdir -p obj)

#regula de compilare a programului
calculator: $(OBJ_FILES)
	gcc $^ -o $@ -no-pie
#regula de compilare a obiectelor
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	nasm -f elf64 -g -F dwarf $< -o $@ 