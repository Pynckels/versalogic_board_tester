# Project Status

## Legend
- ✅ Done
- 🔄 In Progress
- ⬜ To Do

## Hardware

### Design
| Task              | Status | Result Link |
|-------------------|--------|-------------|
| Initial schematic | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/hardware/design) |

### Simulations
| Module            | Status | Result Link |
|-------------------|--------|-------------|
| Setter_Getter     | ✅     | [Result 1](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Setter_Getter/result/Setter_Getter_Board-to-Controller.png), [Result 2](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Setter_Getter/result/Setter_Getter_Controller-to-Board.png) |
| Window_Comparator | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Window_Comparator/result/Window_Comparator.png) |
| Cascaded 74xx165  | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Cascaded_74xx165/result/tb_cascaded_74xx165.png) |
| Cascaded 74xx595  | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/blob/main/hardware/simulations/Cascaded_74xx595/result/tb_cascaded_74xx595.png) |

### Quality assessment
| Module                    | Status | Result Link |
|---------------------------|--------|-------------|
| Design                    | ✅     | Changed controller schematic |
| Setter_Getter             | ✅     | Replaced SSR with EMR since DUT has unknown current usage |
| Window_Comparator         | ✅     | Added extra test-inputs |
| Cascaded 74xx165          | ✅     | No change |
| Cascaded 74xx595          | ✅     | No change |

### Proof of Concept (PoC)
| Module                    | Status | Result Link |
|---------------------------|--------|-------------|
|                           | ✅     | Parts for POC boards are ordered  |
|                           | ✅     | Parts for POC boards are received |
| Setter_Getter             | ⬜     | - |
| Window_Comparator         | 🔄     | Breadboard in preparation |
| Cascaded 74xx165          | 🔄     | Breadboard in preparation |
| Cascaded 74xx595          | 🔄     | Breadboard in preparation |
| Integration of all modules| ⬜     | - |

### Next
| Task                       | Status | Result Link |
|----------------------------|--------|-------------|
| Final schematic & PCB design | ⬜   | - |

## Software

### Structure
| Task                        | Status | Result Link |
|-----------------------------|--------|-------------|
| Initial development setup   | ✅     | [Result](https://github.com/Pynckels/versalogic_board_tester/tree/main/software/design) |

### Proof of Concept (PoC)
| Module                   | Status | Result Link |
|---------------------------|--------|-------------|
| Cascaded 74xx165          | 🔄     | - |
| Cascaded 74xx595          | ⬜     | - |
| Integration of all modules| ⬜     | - |

### Next
| Task                                  | Status | Result Link |
|---------------------------------------|--------|-------------|
| Controller software for Versalogic board | ⬜   | - |
