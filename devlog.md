# Development Log

## Milestone 0

- 04/01/2021
  - Updated the test directory and cocotb test environment
  - Wrote tests for the load/store instruction
  - Major design updates and bug fixes
    - Updated the data memory model to include byte enable
    - Added missing logic for the load/store instruction.
    - Fixed a major bug on the forwarding logic.
    - Re-designed the logic on how the rs2 register and immediate value are handled.
      - The original design combines them in the ID stage, which create a severe bug after introducing forwarding logic
  - TODO: Need to implement the stall logic for load dependence

- 03/31/2021
  - Implemented the forwarding logic and wrote cocotb test
  - Implemented the load/store instruction.
    - Designed a memory controller to handle memory related logic

- 03/30/2021
  - Built the instruction/data memory and soc top.
    - Designed the instruction and data ram module
    - Designed cpu soc top that connects the cpu core with the memory.
  - Build the cocotb test environment.
    - Setup the test directory and the cocotb environemt.
    - Wrote some basic tests for the existing function.
  - Implemented all the logic and arithmetic instruction and wrote cocotb test

- 03/29/2021
  - Built the cpu core logic:
    - Register files, instruction decoder, ALU
    - Built the cpu core top level and the pipeline stages in the top level

- 03/27/2021
  - Setup the repo and spinalHDL sbt environment.
  - Added documents
  - Wrote some components
