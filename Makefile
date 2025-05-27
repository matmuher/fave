SRC_DIR = fave
SRC = FaVe.sv InstrMem.sv Regfile.sv \
	Extend.sv Alu.sv PcPlus4.sv Pc.sv CtlUnit.sv Mxr1Bit.sv
SRC := $(addprefix $(SRC_DIR)/, $(SRC))

TEST_DIR = tb
TEST = TbMaster.sv TbRegfile.sv TbDataMem.sv TbInstrMem.sv TbAlu.sv TbFaVe.sv
TEST := $(addprefix $(TEST_DIR)/, $(TEST))

TOP = TbMaster

INIT_REGM = init_regm.hex
REGM_SIZE = 32 

INIT_DATM = init_datm.hex
DATM_SIZE = 16384

INIT_INSM = init_insm.hex
INSM_SIZE = 256

BUILD_DIR = build
WAVEFRONT_FILE = wavefront.vcd
WAVEFRONT_DIR = waves
WAVEFRONT_PATH = \"$(WAVEFRONT_DIR)/$(WAVEFRONT_FILE)\"

all:
	python init_mem.py 				\
		--regm $(INIT_REGM) 		\
		--regm_size $(REGM_SIZE) 	\
									\
		--insm $(INIT_INSM) 		\
		--insm_size $(INSM_SIZE)	\
									\
		--datm $(INIT_DATM)			\
		--datm_size $(DATM_SIZE)

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
		-DINIT_DATM=\"$(INIT_DATM)\"				\
		-DREGM_SIZE=$(REGM_SIZE)					\
		-DINSM_SIZE=$(INSM_SIZE)					\
		-DDATM_SIZE=$(DATM_SIZE)
	
	./$(BUILD_DIR)/V$(TOP)
