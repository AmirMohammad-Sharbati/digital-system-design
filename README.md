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
│   ├── Q1_Decoder/

├── `exercise_2/`
│   ├── `verilog_codes/`
│   ├── `docs/`

└── `exercise_3/`
    ├── `syn/`
    ├── `verilog_codes/`


## Content Overview 
The codebase includes module implementations and testbenches for **three exercises**.  
### Exercise 1: Fundamental Logic Blocks
This exercise covered the design and implementation of basic digital logic components.

### Exercise 2: Bus Architecture Implementation and Analysis
This exercise focused on the design and analysis of data bus structures, emphasizing different implementation methods and timing considerations. A Python script was utilized for generating input stimuli and/or delay analysis.

### Exercise 3: 8-bit Simple Processor Design (Project)
This was the main project, involving the architectural design and implementation of a simplified 8-bit processor. The design utilizes a mix of gate-level and behavioral modeling.



## 🛠️ Tools and Technologies
The projects are implemented using **Verilog HDL** and cover fundamental concepts. The simulations are primarily performed using **Icarus Verilog** and analyzed with **GTKWave**.

- Hardware Description Language (HDL): Verilog
- Simulation Tool: Icarus Verilog
- Synthesis Tool: Quartus
- Waveform viewer: GTKWave 
- Scripting: Python (Used in Exercise 2 for delay analysis)

## How to Install
### 1. Verilog

### 2. Icarus

### 3. GTKWave

### 4. Quartus


## How to run / simulate 
his project uses **Icarus Verilog** for compilation/simulation and **GTKWave** for waveform viewing.
Recommended simulation workflow:

1. **Compile**: Compile all design files (`.v`) and the corresponding testbench (`_TB.v`) into an executable file (`.vvp`).
1. **Run**: Execute the compiled file using vvp to generate the output waveform file (.vcd).
1. **View**: Open the generated waveform file in GTKWave for analysis.

At first you should clone repository:
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

For example 
```bash
iverilog -o shift_rotate_2.vvp SR_FF.v shift_rotate_2.v shift_rotate_TB_2.v
vvp shift_rotate_2.vvp
gtkwave shift_rotate_2.vcd
```


#### Synthesizable Processor (Exercise 3)
The code in the `exercise_3/verilog_codes` directory is designed to be synthesizable. While Icarus Verilog is used for functional simulation, tools like **Quartus** would be used for actual synthesis into a gate-level netlist. The simulation commands remain the same, but the code structure emphasizes synthesizable constructs.


The Python script in `exercise_2/diagram.py` generates diagrams (requires Python 3.x). Example:

```bash
cd exercise_2
python3 diagram.py
```

Ensure required packages are installed: pip install matplotlib


## License
This repository is licensed under the **MIT License**. See `LICENSE` for the full text.


## 📝 About the Author
This repository was created by **Amir Mohammad Sharbati** as part of the academic requirements for the DSD course at SUT.  
- University: Sharif University of Technology (SUT)
- Semester: Spring 2025  
- **Note about GitHub Classroom bot**: The repository shows two contributors in GitHub UI because the course setup uploaded initial skeleton files via github-classroom[bot]. That bot is not a contributor to the code content. Only the author of first commit (just one commit) is github-classroom which is because of course skeleton upload