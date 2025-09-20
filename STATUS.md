# Project Status

## Legend
- ✅ Done
- 🔄 In Progress
- ⬜ To Do
- ⏸️ On Hold

## Hardware

### Design
| Task              | Status | Result Link |
|-------------------|--------|-------------|
| Initial schematic | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/hardware/design) |

### Simulations
| Module            | Status | Result Link |
|-------------------|--------|-------------|
| Cascaded 74xx165  | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Cascaded_74xx165/result/tb_cascaded_74xx165.png) |
| Cascaded 74xx595  | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Cascaded_74xx595/result/tb_cascaded_74xx595.png) |
| Setter_Getter     | ✅     | [Result 1](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Setter_Getter/result/Setter_Getter_Board-to-Controller.png), [Result 2](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Setter_Getter/result/Setter_Getter_Controller-to-Board.png) |
| Window_Comparator | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Window_Comparator/result/Window_Comparator.png) |

### Quality assessment
| Module                    | Status | Result Link |
|---------------------------|--------|-------------|
| Cascaded 74xx165          | ✅     | No change |
| Cascaded 74xx595          | ✅     | No change |
| Design                    | ✅     | Changed controller schematic |
| Setter_Getter             | ✅     | Replaced SSR with EMR since DUT has unknown current usage |
| Window_Comparator         | ✅     | Added extra test-inputs |

### Proof of Concept (PoC)
| Module                    | Status | Result Link |
|---------------------------|--------|-------------|
| Cascaded 74xx165  (165)   | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Cascaded_74xx165/result/Cascaded_74xx165_output.png) |
| Cascaded 74xx595  (595)   | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Cascaded_74xx595/result/Cascaded_74xx595_output.png) |
| Relay_Driver      (ReDr)  | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Relay_Driver/result/Relay_Driver_output.png) |
| Setter_Getter     (SeGe)  | ✅     | [Result 1](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Setter_Getter/result/Getter_output.png), [Result 2](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Setter_Getter/result/Setter_output.png), [Result 3](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Setter_Getter/result/Inverter_output.png) |
| Window_Comparator (WiCo)  | ✅     | [Result 1](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Window_Comparator/result/Window_Comparator_output_input.png), [Result 2](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Window_Comparator/result/Window_Comparator_output_floating.png) |
| Integration WiCo & 165    | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Window_Comparator/result/Window_Comparator_74xx165_output.txt) |
| Integration SeGe & 165    | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Setter_Getter/result/Getter_74xx165_output.txt) |
| Integration SeGe & 595    | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Setter_Getter/result/Setter_74xx595_output.png) |

### Next
| Task                       | Status | Result Link |
|----------------------------|--------|-------------|
| Final schematic            | ✅    | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/hardware/design) |
| PCB design                 | ⏸️    | Depends on the use of the device |

## Software

### Structure
| Task                        | Status | Result Link |
|-----------------------------|--------|-------------|
| Initial development setup   | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/software/design) |

### Proof of Concept (PoC)
| Module           | Status | Result Link |
|------------------|--------|-------------|
| Cascaded 74xx165 | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Cascaded_74xx165/result/Cascaded_74xx165_output.png) |
| Cascaded 74xx595 | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/proofs_of_concept/Cascaded_74xx595/result/Cascaded_74xx595_output.png) |
| Final modules    | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/software/design) |

### Next
| Task                                     | Status | Result Link |
|------------------------------------------|--------|-------------|
| Controller software for Versalogic board | ⏸️     | Depends on the use of the device |

