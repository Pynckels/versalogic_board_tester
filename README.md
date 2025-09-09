# Data620 Testing Device - Project Overview

The **Data620 computer** is a unique machine built entirely with analog electronic circuitry. It uses a **VersaLOGIC signaling scheme**, where a logical **0** is represented by **0 V**, and a logical **1** is represented by **-12 V**. This unconventional voltage scheme distinguishes it from modern digital systems and makes troubleshooting its boards particularly challenging.

The Data620 is constructed from standard electronic components—resistors, capacitors, diodes, and transistors—across a large number of printed circuit boards (PCBs). Some of these boards may include faulty components, and currently, there is **no dedicated testing device** to verify their functionality.

This project aims to develop such a testing device, enabling systematic diagnostics and repair of Data620 PCBs.

---

## Current Status

The **conceptual design** of the VersaLOGIC board tester is now **complete, simulated, and validated** through multiple proofs of concept. All the heavy lifting on the theoretical side is done.

A more detailed status report can be found on the [status page](https://github.com/Pynckels/versalogic_board_tester/blob/main/STATUS.md).

The remaining work primarily focuses on:

* **PCB design** – to enable practical testing of Data620 boards.
* **Software development** – implementing the testing logic for the board tester.

In short, the foundation is solid, and we are now entering the **“making it real” phase**.

---

## Project Scope

* **Hardware:** Preliminary designs and SPICE simulations are complete, showing that the concept is viable.
* **Software:** Development will proceed now that a stable hardware design exists.
* **Independence:** This project is an independent effort, not affiliated with Usagi Electric or other existing Data620 projects. That said, collaboration opportunities are welcome.

---

## Community & Feedback

As this project is still evolving, **constructive feedback and suggestions** from the community are highly appreciated.

For more context about the Data620 computer:

* [Retrocomputing Forum: Data-620 Transistor Minicomputer](https://retrocomputingforum.com/t/data-620-transistor-minicomputer/3847)
* [GitHub: Nakazoto/Data620](https://github.com/Nakazoto/Data620)
* [YouTube: Data620 Overview](https://www.youtube.com/watch?v=YR9E9ZvHkQE)

We thank **Usagi Electric** and the community for their ongoing dedication to preserving this remarkable piece of computing history.
