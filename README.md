# Data Repository for Chip-Chat: Challenges and Opportunities in Conversational Hardware Design

(Due to blind review, we did a find/replace on author names.)

This repository accompanies the manuscript submitted to ICCAD 2023, titled "Chip-Chat: Challenges and Opportunities in Conversational Hardware Design". 

It contains the following:

- `scripted-benchmarks` - this contains the data used for Section III in the paper, which examines a more rigid process when exploring the potential applications for LLMs in hardware design. Here, each model chats are separated by subdirectory.

- `scripted-benchmarks-gpt4-tt03` - this contains just the benchmarks from Section III made by the first run of GPT-4, which were used for tapeout in Tiny Tapeout 3.

- `free-chat-gpt4-tt03` - this contains the data used for Section IV in the paper, which examines a more free-form process when exploring the potential applications for LLMs in hardware design. The task here was to generate the Verilog for a full (albeit small) processor design. Here, the chats are presented (and annotated) in the `/chats` subdirectory, which also includes a python script for extracting metadata (presented in table IV in the manuscript). Note that this directory also includes `/assembler` which provides a basic assembler (also written in Python) to make it easier to write demo programs (examples included) for the processor.

The two tt03 directories contain the GitHub action scripts required to invoke OpenLane and produce synthesis files, as well as used to perform simulation tests.