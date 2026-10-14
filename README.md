# Lab 1: Sequential Multiplier (Controller FSM & Datapath)
**Course:** EC5034 — VLSI Testing & DFT Practice  
**Academic Term:** 2026  
**Organization:** [2026-VLSI-TESTING-PRACTICE](https://github.com/2026-VLSI-TESTING-PRACTICE)  
**Starter Repository:** [`2026-VLSI-TESTING-PRACTICE/lab1-starter-code`](https://github.com/2026-VLSI-TESTING-PRACTICE/lab1-starter-code)

---

## 🎯 1. Lab Overview & Objectives

In this lab, you will design, model in Verilog HDL, and verify a **4-bit by 4-bit unsigned sequential multiplier** based on repeated addition. 

### Core Concepts Tested:
1. **RTL Partitioning:** Clean separation between Datapath and Control Unit (FSM).
2. **FSM Design:** Multi-state Mealy / Moore FSM avoiding unintended latch inference.
3. **Control Handshaking:** Synchronous coordination using `start`, `load_inputs`, `clear_prod`, `enable_prod`, `enable_cnt_dec`, `loops_zero_flag`, and `mult_complete`.
4. **Verification:** Cycle-accurate latency matching (`B + 2` clock cycles) and waveform analysis.

---

## 📁 2. Repository Contents & Architecture

| File | Type | Description | Evaluation Scope |
| :--- | :--- | :--- | :--- |
| [`controller.v`](controller.v) | Verilog RTL | Finite State Machine (FSM) control unit | **Mandatory Submission** (Scanned for AI & Plagiarism) |
| [`datapath.v`](datapath.v) | Verilog RTL | 4-bit accumulator, decrementer, and loop-counter datapath | **Mandatory Submission** (Scanned for AI & Plagiarism) |
| [`top.v`](top.v) | Verilog RTL | Top-level structural wrapper interconnecting Datapath and Controller | **Mandatory Submission** (Scanned for AI & Plagiarism) |
| [`tb_top.v`](tb_top.v) | Testbench | Verification suite covering edge cases & cycle counting | **Mandatory Submission** (Scanned for AI & Plagiarism) |
| [`LAB_1.pdf`](LAB_1.pdf) | Reference | Full lab manual, architectural block diagram, and state transition specifications | Reference Documentation |
| [`wave.do`](wave.do) | Script | Waveform configuration for QuestaSim / ModelSim | Waveform setup script |
| [`Makefile`](Makefile) | Automation | Compilation, simulation, and cleanup commands | Build helper |

---

## ⚙️ 3. Multiplier Architecture & Specifications

### 3.1 Datapath Interface
The Datapath (`datapath.v`) provides:
- **`working_multiplicand` (4-bit register):** Loaded when `load_inputs = 1'b1`.
- **`loop_counter` (4-bit register):** Loaded with `multiplier_in` when `load_inputs = 1'b1`; decremented by 1 when `enable_cnt_dec = 1'b1`.
- **`accumulated_prod` (8-bit register):** Cleared to `0` when `clear_prod = 1'b1`; adds `working_multiplicand` when `enable_prod = 1'b1`.
- **`loops_zero_flag` (wire output):** Asserted high whenever `loop_counter == 4'd0`.

### 3.2 Expected FSM Behavior (`controller.v`)
Your FSM must implement:
1. **`IDLE` (State 0):** Waits for `start == 1'b1`.
2. **`LOAD` / Initialization:** Generates `load_inputs = 1` and `clear_prod = 1`. 
   - If the multiplier is `0` (`loops_zero_flag == 1`), immediately transition to complete without looping.
3. **`PROG` / Accumulation Loop:** Asserts `enable_prod = 1` and `enable_cnt_dec = 1` each cycle until `loops_zero_flag == 1`.
4. **`DONE`:** Asserts `mult_complete = 1` and outputs valid product before returning to `IDLE`.

> ⚠️ **Timing Requirement:** Total latency from assertion of `start` to `mult_complete` must strictly equal **`B + 2` clock cycles** (where `B` is the multiplier value).

---

## 💻 4. Simulation & Verification

You can verify your code using **ModelSim / QuestaSim** or open-source **Icarus Verilog (`iverilog`)**.

### Option A: Using QuestaSim / ModelSim (Recommended for Lab Submissions)
Run from the repository root:
```bash
# Compile and run testbench in batch mode
make sim
```
Or interactively with waveforms:
```bash
vlib work
vlog top.v datapath.v controller.v tb_top.v
vsim -do wave.do tb_top
```

### Option B: Using Icarus Verilog (`iverilog` & `vvp`)
If working on personal laptops without QuestaSim:
```bash
iverilog -g2001 -o sim.out top.v datapath.v controller.v tb_top.v
vvp sim.out
```

### Expected Output:
When your design passes, all 10 test vectors will print `[ PASS ]`:
```text
Test:  0 x  0 | Exp Prod:   0, Act Prod:   0 | Exp Cycles:  2, Act Cycles:  2 | [ PASS ]
Test:  0 x  5 | Exp Prod:   0, Act Prod:   0 | Exp Cycles:  7, Act Cycles:  7 | [ PASS ]
Test:  5 x  0 | Exp Prod:   0, Act Prod:   0 | Exp Cycles:  2, Act Cycles:  2 | [ PASS ]
Test:  1 x  1 | Exp Prod:   1, Act Prod:   1 | Exp Cycles:  3, Act Cycles:  3 | [ PASS ]
Test:  1 x 15 | Exp Prod:  15, Act Prod:  15 | Exp Cycles: 17, Act Cycles: 17 | [ PASS ]
Test: 15 x  1 | Exp Prod:  15, Act Prod:  15 | Exp Cycles:  3, Act Cycles:  3 | [ PASS ]
Test:  3 x  4 | Exp Prod:  12, Act Prod:  12 | Exp Cycles:  6, Act Cycles:  6 | [ PASS ]
Test: 15 x 15 | Exp Prod: 225, Act Prod: 225 | Exp Cycles: 17, Act Cycles: 17 | [ PASS ]
Test:  3 x 12 | Exp Prod:  36, Act Prod:  36 | Exp Cycles: 14, Act Cycles: 14 | [ PASS ]
Test: 12 x  3 | Exp Prod:  36, Act Prod:  36 | Exp Cycles:  5, Act Cycles:  5 | [ PASS ]
```

---

## 📤 5. Submission Procedure

Follow these exact steps to complete and submit your lab:

### Step 1: Fork or Clone Your Assigned Repository
- If GitHub Classroom or assigned private repository links are provided:
  ```bash
  git clone https://github.com/2026-VLSI-TESTING-PRACTICE/lab1-submission-<your_roll_no>.git
  cd lab1-submission-<your_roll_no>
  ```
- Or clone the starter code directly into your local workspace:
  ```bash
  git clone https://github.com/2026-VLSI-TESTING-PRACTICE/lab1-starter-code.git
  cd lab1-starter-code
  ```

### Step 2: Implement Your Design
1. Open [`controller.v`](controller.v) in your editor.
2. Complete the state parameters, sequential state registers, and combinational next-state/output logic.
3. Test your implementation against [`tb_top.v`](tb_top.v). Ensure 0 latch warnings in simulation.

### Step 3: Required Deliverables
You must submit the following files directly in your repository:
- `controller.v` *(Your completed FSM control logic)*
- `datapath.v` *(Accumulator and counter datapath)*
- `top.v` *(Structural top-level)*
- `tb_top.v` *(Self-checking testbench)*
- `Makefile` *(QuestaSim build and simulation targets)*
- `questa_transcript.txt` *(Console simulation transcript proving all 10 tests pass)*
- `report.pdf` *(Your lab report containing waveform screenshots, state diagram, and analysis)*

> ⚠️ **Important:** All four Verilog files will be audited for syntax and structural duplication across submissions. Your `report.pdf` will also be analyzed for peer-to-peer duplication.

### Step 4: Commit & Push Your Work
Stage all deliverables and push:
```bash
git add controller.v datapath.v top.v tb_top.v Makefile questa_transcript.txt report.pdf
git commit -m "Submit Lab 1: RTL, testbench, QuestaSim transcript and report"
git push origin main
```

---

## 📋 6. Evaluation Criteria & Academic Integrity

Submissions will be automatically evaluated using the course automated test harness:

1. **Functional Correctness (40%):** All 10 baseline test cases pass with correct arithmetic products.
2. **Cycle-Accurate Latency (20%):** Accurate state transitions satisfying the `B + 2` cycle latency specification.
3. **Synthesizability & Clean RTL (20%):** Synchronous reset handling, fully specified sensitivity lists, no combinational feedback loops, and zero inferred latches.
4. **Deliverables & Transcripts (20%):** Valid simulation transcripts and clear waveform verification captures.

### 🛡️ Automated Academic Integrity & Viva Verification:
- **Full-Suite Structural Plagiarism Audit:** All four Verilog files (`controller.v`, `datapath.v`, `top.v`, and `tb_top.v`) are tokenized at the Abstract Syntax Tree (AST) level. The engine detects identifier renaming, block rearrangement, and whitespace obfuscation across all submissions.
- **Multi-File AI Code Generation Detection:** Each file is evaluated for automated LLM signatures, unnatural comment density, non-idiomatic named procedural blocks, and spec hallucinations.
- **Oral Defense / Viva Examination:** Each student will be asked **3 targeted architecture and state-transition defense questions** based directly on their submitted Verilog implementations. You must be able to justify every line of code submitted under your name.
