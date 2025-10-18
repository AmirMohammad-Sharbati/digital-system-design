# 💻 Digital System Design Coursework - Sharif University of Technology

https://img.shields.io/badge/Verilog-HDL-orange.svg
https://img.shields.io/badge/License-MIT-blue.svg
https://img.shields.io/badge/Simulator-Icarus_Verilog-green.svg
https://img.shields.io/badge/Waveform_Viewer-GTKWave-lightgrey.svg

This repository contains my coursework for the **Digital System Design (DSD)** course taken during the Spring 2025 (Semester 4) at **Sharif University of Technology (SUT)**.  
All implementations are written in **Verilog HDL**, accompanied by appropriate **testbenches** for simulation and verification.



## 📁 Repository Structure 
The repository is organized by exercise number:
.
├── `exercise_1/`
│   ├── `images_1/`
│   ├── `images_2/`
│   ├── `images_3/`
│   ├── `verilog_codes_1/`
│   ├── `verilog_codes_2/`
│   ├── `verilog_codes_3/`
|   ├── `description_1.pdf`
|   ├── `explanation.pdf`

├── `exercise_2/`
│   ├── `verilog_codes/`
│   ├── `docs/`
│   ├── `description_2.pdf`
│   ├── `diagram.py`

└── `exercise_3/`
|    ├── `syn/`
|    ├── `verilog_codes/`
|    ├── `description_3.pdf`
|    ├── `explanation.pdf`



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

### Exercise 3: 8-bit Simple Processor Design
This was the main project of the course, involving the architectural design and Verilog implementation of a simplified **8-bit processor**.  
It combined **gate-level modeling** for fundamental arithmetic modules with **behavioral modeling** for higher-level system components.  
**Main components implemented:**  
- **Adder/Subtractor** (`csa_16.v`) — Designed using gate-level modeling for precise logic-level representation.  
- **Multiplier** and **Divider** — Implemented behaviorally to extend the arithmetic unit capabilities.  
- **ALU** (`alu.v`) — Integrates adder, subtractor, multiplier, and divider modules into a single arithmetic logic unit.  
- **Register File** and **Memory** — Modeled for data storage and instruction handling.  
- **Controller (Top-Level Module)** — Coordinates the datapath and control signals to implement basic processor operations.  
Each module was tested using dedicated Verilog testbenches, ensuring correctness.  
The `syn/` directory contains the synthesized results of this design.  
The processor implementation is fully synthesizable, meaning it follows structural and behavioral conventions suitable for hardware realization on FPGA or ASIC platforms.


## 🛠️ Tools and Technologies
The projects are implemented using **Verilog HDL** and cover fundamental concepts. The simulations are primarily performed using **Icarus Verilog** and analyzed with **GTKWave**.

- Hardware Description Language (HDL): Verilog
- Simulation Tool: Icarus Verilog
- Synthesis Tool: Quartus (Used in exercise 3)
- Waveform viewer: GTKWave 
- Scripting: Python (Used in exercise 2 for delay analysis)



## How to Install
Before running simulations or synthesizing designs, make sure the following tools are installed on your system.
All are free and cross-platform (Linux, Windows, macOS).
### 1. Verilog
Verilog itself is a hardware description language - you only need a **compiler/simulator** to work with it (such as Icarus Verilog or ModelSim).
If you're editing Verilog code, you can use **VS Code** with extensions
You don't install Verilog as a separate tool - you just use it through simulators or synthesis software like Icarus or Quartus.

### 2. Icarus
Icarus Verilog (iverilog) is an open-source Verilog simulator used in this course for all experiments and testbenches.
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
Although not required for simulation in this course, Intel Quartus Prime can be used to synthesize and analyze your Verilog designs from Exercise 3.

**Download** app from Official Intel link:
🔗 https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/download.html
**Recommended edition**: Quartus Prime Lite Edition (free version) -> Works on Windows and Linux
**Installation Notes**  
During installation, you can choose the FPGA family (e.g., Cyclone V) - any basic family works for functional synthesis.  
Add Quartus binary folder to your PATH if you want to run it from terminal.



## How to run / simulate 
Recommended simulation workflow:  
1. **Compile**: Compile all design files (`.v`) and the corresponding testbench (`_TB.v`) into an executable file (`.vvp`).
1. **Run**: Execute the compiled file using vvp to generate the output waveform file (`.vcd`).
1. **View**: Open the generated waveform file in GTKWave for analysis.

For running this codes you should clone repository:
```bash
git clone https://github.com/AmirMohammad-Sharbati/digital-system-design.git
```

Example commands (adapt filenames as needed):  
```bash
# compile sources + testbench into a vvp file
iverilog -o <simulation_name>.vvp <list-of-source-files> <testbench_file>.v

# run simulation
vvp <simulation_name>.vvp

# open generated VCD in GTKWave
gtkwave <simulation_name>.vcd
```

For example:   
```bash
iverilog -o shift_rotate_2.vvp SR_FF.v shift_rotate_2.v shift_rotate_TB_2.v
vvp shift_rotate_2.vvp
gtkwave shift_rotate_2.vcd
```


### Synthesizable Processor (Exercise 3)
The code in the `exercise_3/verilog_codes` directory is designed to be synthesizable. While Icarus Verilog is used for functional simulation, tools like **Quartus** would be used for actual synthesis into a gate-level netlist. The simulation commands remain the same, but the code structure emphasizes synthesizable constructs.

#### 🧪 How to use for this project
1. Open Quartus.
1. Create a new project and add your Verilog source files (`.v`).
1. Set the **top-level entity** to main module (`controller.v`).
1. Run:
    - Analysis & Synthesis
    - Compilation
    - Optionally RTL Viewer to visualize your synthesized logic.

### Python Script
The Python script in `exercise_2` generates diagrams (requires Python 3.x). Example:

```bash
cd exercise_2
python diagram.py
```  
Before running ensure required package is installed: 
```bash
pip install matplotlib 
```


## License
This repository is licensed under the **MIT License**. See `LICENSE` for the full text.


## 📝 About the Author
This repository was created by **Amir Mohammad Sharbati** as part of the academic requirements for the DSD course at SUT.  
- University: Sharif University of Technology (SUT)
- Semester: Spring 2025  
- **Note about GitHub Classroom bot**: The repository shows two contributors in GitHub UI because the course setup uploaded initial skeleton files via github-classroom[bot]. That bot is not a contributor to the code content. Only the author of first commit (just one commit) is github-classroom which is because of course skeleton upload.