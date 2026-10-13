# Makefile for Sequential Multiplier (EC5034 - Lab 1)

# Simulator executables
VLIB = vlib
VMAP = vmap
VLOG = vlog
VSIM = vsim
IVERILOG = iverilog
VVP = vvp

RTL_SRCS = datapath.v controller.v top.v
TB_SRC   = tb_top.v
TOP_TB   = tb_top

all: compile sim

# --- QuestaSim / ModelSim targets ---
lib:
	$(VLIB) work
	$(VMAP) work work

compile: lib
	$(VLOG) +acc $(RTL_SRCS) $(TB_SRC)

sim: compile
	$(VSIM) -c -do "run -all; exit" $(TOP_TB)

gui: compile
	$(VSIM) -gui -do wave.do $(TOP_TB) &

# --- Open-source Icarus Verilog targets ---
sim-icarus:
	$(IVERILOG) -g2001 -o sim.out $(RTL_SRCS) $(TB_SRC)
	$(VVP) sim.out
	rm -f sim.out

clean:
	rm -rf work transcript vsim.wlf *.log sim.out

.PHONY: all lib compile sim gui sim-icarus clean
