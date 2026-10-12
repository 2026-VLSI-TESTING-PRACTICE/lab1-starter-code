# Lab 1: Sequential Multiplier - Controller & Datapath
**Course:** EC5034 - VLSI Testing & DFT Practice  
**Instructor / TA:** 2026-VLSI-TESTING-PRACTICE

---

## 📌 Objective
Design, simulate, and verify a 4-bit by 4-bit sequential multiplier using a dedicated **Controller FSM** and **Datapath**.

## 📂 Repository Contents
- `LAB_1.pdf`: Detailed lab manual, state diagram, and specifications.
- `top.v`: Top-level wrapper interconnecting Controller and Datapath.
- `datapath.v`: 4-bit accumulator, decrementer, and loop-counter datapath.
- `controller.v`: **Your assignment** - Implement the FSM control unit here.
- `tb_top.v`: Verification testbench.
- `wave.do`: ModelSim / QuestaSim waveform setup script.
- `Makefile`: Simulation shortcuts (`make compile`, `make sim`).

---

## 🚀 How to Run with QuestaSim / ModelSim
```bash
make sim
```
Or interactively:
```bash
vlib work
vlog top.v datapath.v controller.v tb_top.v
vsim -do wave.do tb_top
```

## 📥 Submission Instructions
1. Implement your FSM in `controller.v`.
2. Verify all test cases pass in QuestaSim without latches.
3. Commit and push your changes to your designated private repository:
   ```bash
   git add controller.v
   git commit -m "Complete Lab 1 controller implementation"
   git push origin main
   ```
