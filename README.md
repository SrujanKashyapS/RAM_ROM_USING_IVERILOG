
# Verilog Simulation with Icarus Verilog and GTKWave

This guide provides instructions for simulating Verilog code using Icarus Verilog (`iverilog`) and viewing the resulting waveforms in GTKWave.

## Prerequisites

Make sure `iverilog` and `gtkwave` are installed.

### Installation

#### On Ubuntu/Debian
```bash
sudo apt update
sudo apt install iverilog gtkwave
```

#### On macOS
If you’re using Homebrew:
```bash
brew install icarus-verilog gtkwave
```

## Running the Simulation

Follow these steps to compile, simulate, and view your Verilog code in GTKWave.

### Step 1: Set Up Your Verilog Code

Create your Verilog files. You’ll typically need:
- A **design file** (e.g., `my_design.v`) containing the main code.
- A **testbench file** (e.g., `my_testbench.v`) for testing the design.

**Sample Testbench Code**:
This example testbench generates a `dump.vcd` file (Value Change Dump) for waveform viewing.

```verilog
module my_testbench;
    reg clk;
    reg rst;

    // Instantiate your design here
    // my_design uut (.clk(clk), .rst(rst));

    initial begin
        $dumpfile("dump.vcd");       // Specify the output VCD file
        $dumpvars(0, my_testbench);   // Dump all variables in this testbench
        #100 $finish;
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock signal with 10-time-unit period
    end
endmodule
```

### Step 2: Compile the Verilog Code

Compile your Verilog files with `iverilog`, specifying an output filename for the compiled simulation.

```bash
iverilog -o simulation_output my_testbench.v my_design.v
```

- `simulation_output`: The name of the compiled output file.
- `my_testbench.v`: The testbench file with test scenarios.
- `my_design.v`: The Verilog design file.

### Step 3: Run the Simulation

Run the compiled file using `vvp`. This will generate a `dump.vcd` file if you included `$dumpfile` and `$dumpvars` in your testbench.

```bash
vvp simulation_output
```

### Step 4: View the Waveform with GTKWave

Use GTKWave to view the `dump.vcd` file generated by the simulation.

```bash
gtkwave dump.vcd
```

## Summary of Commands

1. **Compile the Verilog code**:
   ```bash
   iverilog -o simulation_output my_testbench.v my_design.v
   ```

2. **Run the simulation**:
   ```bash
   vvp simulation_output
   ```

3. **Open the waveform in GTKWave**:
   ```bash
   gtkwave dump.vcd
   ```

## Example Project Structure

Here’s a sample project layout:

```
project/
├── my_design.v         # Verilog design file
├── my_testbench.v      # Verilog testbench file
└── README.md           # Instructions file
```

After running the commands, you should see `dump.vcd` in your directory, which you can open with GTKWave to visualize your signals.

---

That’s it! You should now be able to compile, simulate, and view Verilog code using Icarus Verilog and GTKWave.
