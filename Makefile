SRC_DIR = fave
SRC = FaVe.sv InstrMem.sv Regfile.sv Extend.sv Alu.sv
SRC := $(addprefix $(SRC_DIR)/, $(SRC))

TEST_DIR = tb
TEST = TbRegfile.sv TbMaster.sv
TEST := $(addprefix $(TEST_DIR)/, $(TEST))

TOP = TbMaster
BUILD_DIR = build
WAVEFRONT_FILE = wavefront.vcd
WAVEFRONT_DIR = waves
WAVEFRONT_PATH = \"$(WAVEFRONT_DIR)/$(WAVEFRONT_FILE)\"
INIT_REGS = init_regs.hex

all:
	python init_mem.py --regs $(INIT_REGS)

	mkdir -p $(WAVEFRONT_DIR)

	verilator --trace-vcd --trace-structs --assert		\
		--binary -j 0							\
		--sv									\
		--top-module $(TOP) 					\
		$(SRC) $(TEST) 							\
		--Mdir $(BUILD_DIR) 					\
		-I$(SRC_DIR)							\
		-DWAVEFRONT_PATH=$(WAVEFRONT_PATH) 		\
		-DINIT_REGS=\"$(INIT_REGS)\"		
	
	./$(BUILD_DIR)/V$(TOP)
