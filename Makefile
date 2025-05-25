SRC_DIR = fave
SRC = FaVe.sv InstrMem.sv Regfile.sv Extend.sv Alu.sv
SRC := $(addprefix $(SRC_DIR)/, $(SRC))

TEST_DIR = tb
TEST = TbMaster.sv TbRegfile.sv TbDataMem.sv TbInstrMem.sv TbAlu.sv
TEST := $(addprefix $(TEST_DIR)/, $(TEST))

TOP = TbMaster

INIT_REGM = init_regm.hex
INIT_DATM = init_datm.hex
INIT_INSM = init_insm.hex

BUILD_DIR = build
WAVEFRONT_FILE = wavefront.vcd
WAVEFRONT_DIR = waves
WAVEFRONT_PATH = \"$(WAVEFRONT_DIR)/$(WAVEFRONT_FILE)\"

all:
	python init_mem.py \
		--regm $(INIT_REGM) \
		--insm $(INIT_INSM) \
		--datm $(INIT_DATM)

	mkdir -p $(WAVEFRONT_DIR)

	verilator --trace-vcd --trace-structs --assert	\
		--binary -j 0								\
		--sv										\
		--top-module $(TOP) 						\
		$(SRC) $(TEST) 								\
		--Mdir $(BUILD_DIR) 						\
		-I$(SRC_DIR)								\
		-DWAVEFRONT_PATH=$(WAVEFRONT_PATH) 			\
		-DINIT_REGM=\"$(INIT_REGM)\"				\
		-DINIT_INSM=\"$(INIT_INSM)\"				\
		-DINIT_DATM=\"$(INIT_DATM)\"
	
	./$(BUILD_DIR)/V$(TOP)
