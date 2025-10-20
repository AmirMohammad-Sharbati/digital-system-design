# 💻 Digital System Design Coursework - SUT

![Language](https://img.shields.io/badge/Verilog-HDL-orange)
![License](https://img.shields.io/badge/License-MIT-blue)
![Simulator](https://img.shields.io/badge/Simulator-Icarus_Verilog-green)
![Waveform](https://img.shields.io/badge/Waveform_Viewer-GTKWave-lightgrey)

This repository contains my coursework for the **Digital System Design (DSD)** course taken during the Spring 2025 (Semester 4) at **Sharif University of Technology (SUT)**.  
All implementations are written in **Verilog HDL**, accompanied by appropriate **testbenches** for simulation and verification.



## 📁 Repository Structure 
The repository is organized into three main directories, each corresponding to one of the course exercises.  
Each exercise folder contains **Verilog source codes**, **testbenches**, and supporting materials such as reports or scripts.

1. `exercise_1/`   
    - `verilog_codes_1/`  
    - `verilog_codes_2/`  
    - `verilog_codes_3/`  

2. `exercise_2/`  
    - `verilog_codes/`  
    - `diagram.py`  
  
3. `exercise_3/`  
    - `verilog_codes/`  

Each exercise directory (or subdirectory) includes:  
- `description_X.pdf` — the official problem statement and task definitions provided by the course
- `explanations.pdf` — a detailed report containing circuit design explanations, Verilog implementation details, simulation results, and discussion of challenges


## 📘 Content Overview 
The codebase includes Verilog module implementations and corresponding testbenches for **three main exercises**, progressively increasing in complexity and design scope.

### Exercise 1: Fundamental Logic Blocks
This exercise covered the design and implementation of basic digital logic components. It consisted of three independent questions:
1. Implementation of a **3-to-8 decoder** using a hierarchical structure built from 2-to-4 decoders.
1. Description and verification of an **SR flip-flop** (Set-Reset) circuit in Verilog.
1. Debugging, testing, and verification of a provided **8-bit multiplication** algorithm.

### Exercise 2: Bus Architecture Implementation and Analysis
This exercise explored the design of **shared data bus architectures**, emphasizing multiple implementation strategies and delay analysis.  
Unlike the previous exercise, the three parts of this assignment were interrelated.  
- The goal was to design an **N-bit shared bus** using two different methods:  
    1. **Tri-state buffer approach**
    1. **Multiplexer-based approach**
- The implementations were compared by introducing explicit signal delays in Verilog and analyzing the resulting timing differences.
- A **Python script** was used to generate and visualize the final timing and structural diagrams, illustrating propagation delay and signal control across the two bus architectures.

### Exercise 3: 16-bit Simple Processor Design
This was the main project of the course, involving the architectural design and Verilog implementation of a simplified **16-bit processor**.  
It combined **gate-level modeling** for fundamental arithmetic modules with **behavioral modeling** for higher-level system components.  
**Main components implemented:**  
- **Adder/Subtractor** (`csa_16.v`) — Designed using gate-level modeling for precise logic-level representation.  
- **Multiplier** (`mul_16.v`) and **Divider** (`div_16.v`) — Implemented behaviorally to extend the arithmetic unit capabilities.  
- **ALU** (`alu_16.v`) — Integrates adder, subtractor, multiplier, and divider modules into a single arithmetic logic unit.  
- **Register File** (`register_file.v`) and **Memory** (`memory.v`) — Modeled for data storage and instruction handling.  
- **Controller** (`controller.v` - **Top-Level Module**) — Coordinates the datapath and control signals to implement basic processor operations.  

Each module was tested using dedicated Verilog testbenches, ensuring correctness.   
The processor implementation is fully synthesizable, meaning it follows structural and behavioral conventions suitable for hardware realization on FPGA or ASIC platforms.



## 🛠️ Tools and Technologies
The projects are implemented using **Verilog HDL**. The simulations are primarily performed using **Icarus Verilog** and analyzed with **GTKWave**.

- Hardware Description Language (HDL): **Verilog**
- Simulation Tool: **Icarus Verilog**
- Waveform viewer: **GTKWave** 
- Synthesis Tool: **Quartus** (Used in exercise 3)
- Scripting: **Python** (Used in exercise 2 for delay analysis)



## 🧩 How to Install
Before running simulations or synthesizing designs, make sure the following tools are installed on your system.
All are free and cross-platform (Linux, Windows, macOS).

### 1. Verilog
Verilog itself is a hardware description language - you only need a **compiler/simulator** to work with it (such as Icarus Verilog or ModelSim).  
If you're editing Verilog code, you can use **VS Code** with extensions.

### 2. Icarus
Icarus Verilog (iverilog) is an open-source Verilog simulator used in this course for all experiments and testbenches:  
#### 🐧 Linux / macOS
```bash
sudo apt update
sudo apt install iverilog
```  
#### 🪟 Windows
1. Download the latest stable release from: 
  🔗 https://bleyer.org/icarus/
1. Run the installer and make sure to add `iverilog` and `vvp` to PATH.
1. Verify installation:  
```bash
iverilog -V
vvp -V
```

### 3. GTKWave
GTKWave is a waveform viewer used to visualize `.vcd` files generated by your Verilog simulations.
#### 🐧 Linux
```bash
sudo apt install gtkwave
```
#### 🪟 Windows
1. Download from:
  🔗 https://sourceforge.net/projects/gtkwave/
1. Install and add it to PATH
#### 🧠 Tip
Use `$dumpfile` and `$dumpvars` in your testbenches to create `.vcd` waveforms:  
```
initial begin
  $dumpfile("module_name.vcd");
  $dumpvars(0, module_name_tb);
end
```
### 4. Quartus (Optional - for synthesis)
Although not required for simulation in this course, Intel Quartus Prime can be used to synthesize and analyze your Verilog designs from exercise 3.

- **Download** app from Official Intel link:  
  🔗 https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/download.html  
- **Recommended edition**: Quartus Prime Lite Edition (free version)  

⚠️ **Note**: Quartus Prime is a large software suite (several GB).  
Installation may take considerable time and disk space, so it’s recommended only if you intend to perform actual synthesis or FPGA implementation.

✅ **Summary**:
You don’t need Quartus for running the provided testbenches — **Icarus Verilog** + **GTKWave** is sufficient for all functional simulations in this repository.


## ⚙️ How to run / simulate 
Follow the workflow below to **compile, run, and visualize your simulations**.

### Recommended simulation workflow:  

#### 1. Clone the repository 
```bash
git clone https://github.com/AmirMohammad-Sharbati/digital-system-design.git
cd digital-system-design
```  

#### 2. Compile
Use **Icarus Verilog (iverilog)** to compile all relevant Verilog source files (`.v`) and the corresponding testbench (`_TB.v`) into a single executable file (`vvp`):
```bash
iverilog -o <simulation_name>.vvp <list-of-source-files> <testbench_file>.v
```

#### 3. Run
Execute the compiled file using vvp to generate the output waveform file (`.vcd`):
```bash
vvp <simulation_name>.vvp
```

#### 4. View Results
Open the generated `.vcd` file in **GTKWave** for waveform inspection:
```bash
gtkwave <simulation_name>.vcd
```

### Example
Here is a practical example for simulating:
```bash
iverilog -o shift_rotate_2.vvp SR_FF.v shift_rotate_2.v shift_rotate_TB_2.v
vvp shift_rotate_2.vvp
gtkwave shift_rotate_2.vcd
```


### Synthesizable Processor (Exercise 3)
The designs in `exercise_3/verilog_codes/` follow synthesizable Verilog conventions and can be tested using Icarus Verilog or synthesized in tools like **Intel Quartus Prime**.

#### Synthesis Workflow (Quartus Example)
1. Open Quartus.
1. Create a new project and add all Verilog source files (`.v`) from `exercise_3/verilog_codes/`.
1. Set the **top-level entity** to main controller module (`controller.v`).
1. Run the following processes:
    - Analysis & Synthesis
    - Compilation
    - Optionally RTL Viewer to visualize your synthesized logic.

### Python Script (Exercise 2)
The Python script in `exercise_2/` generates diagrams (requires Python 3.x). To run:  
```bash
cd exercise_2
python diagram.py
```  
Ensure Python 3.x and matplotlib are installed: 
```bash
pip install matplotlib 
```


## 📜 License
This repository is licensed under the **MIT License**. See `LICENSE` file for the full text.



## 📝 About the Author
This repository was developed by **Amir Mohammad Sharbati** as part of the **Digital System Design (DSD)** course at **Sharif University of Technology (SUT).** 

**Note on Contributors:**  
You may see another contributor listed as `github-classroom[bot]`.  
This account belongs to **GitHub Classroom**, which was used by the university to share assignment templates.  
Only the very first commit was uploaded automatically by this bot — **all other code, implementations, and documentation were written entirely by Amir Mohammad Sharbati.**