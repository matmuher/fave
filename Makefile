SRC = FaVe.sv InstrMem.sv Regfile.sv Extend.sv Alu.sv
HEADERS = Defs.svh
TOP = FaVe
BUILD_DIR = build
WAVEFRONT_FILE = wavefront.vcd
WAVEFRONT_DIR = waves
WAVEFRONT_PATH = \"$(WAVEFRONT_DIR)/$(WAVEFRONT_FILE)\"
INIT_REGS = init_regs.hex

all:
	python init_mem.py --regs $(INIT_REGS)

	mkdir -p $(WAVEFRONT_DIR)

	verilator --trace-vcd --trace-structs		\
		--binary -j 0							\
		--sv									\
		--top-module $(TOP) 					\
		$(SRC) 									\
		--Mdir $(BUILD_DIR) 					\
		-I $(HEADERS)							\
		-DWAVEFRONT_PATH=$(WAVEFRONT_PATH) 		\
		-DINIT_REGS=\"$(INIT_REGS)\"		
	
	./$(BUILD_DIR)/V$(TOP)
