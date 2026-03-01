# Verilog + 數位電路完整學習 + 實作整合清單

> 此 Markdown 整合了：
> - Level 0~5 學習能力樹  
> - 小模塊 / Mini Project / 專案  
> - 12 週學習 roadmap  
> - HackMD 勾選追蹤框  

---

## 🟢 Level 0：邏輯概念入門

- [x] 二進制 / 十進制 / 十六進制轉換
- [x] 有號數 / 無號數範例計算
- [x] 2’s complement 加減法題
- [x] AND / OR / XOR / NOT 手算題
- [x] 真值表設計 (2~4 inputs)
- [x] 布林代數簡化 (K-map)
- [x] 德摩根定律驗證題

**Mini Project / 練習建議**
- [x] 設計 3-bit parity checker
- [ ] 用真值表算 Tic-Tac-Toe 勝負判斷

---

## 🟢 Level 1：數位電路基礎

### 組合邏輯
- [x] 半加器 + 全加器
- [x] 4-bit Ripple Carry Adder
- [x] 2-to-1 / 4-to-1 MUX
- [x] 1-to-2 / 1-to-4 Demux
- [x] 3-to-8 Decoder
- [x] 8-to-3 Encoder
- [x] 2-bit / 4-bit Comparator
- [x] Priority Comparator

### 時序邏輯
- [x] D Flip-Flop
- [x] SR / JK Flip-Flop
- [x] 同步 / 非同步 Reset
- [x] 4-bit Up / Down Enable Mod-10 Loadable Counter
- [x] Right Shift Register(補0)
- [x] Ring counter(one hot)
- [x] Johnson Counter
- [x] Serial-in Counter

**Mini Project / 練習建議**
- [ ] LED 流水燈 (shift register + counter)
- [ ] 4-bit binary counter 顯示 7-segment
- [ ] 按鈕控制 LED Pattern

---

## 🟢 Level 2：Verilog RTL 入門

### 語法基礎
- [x] module, input/output, wire/reg
- [x] assign / always @(*) / always @(posedge clk)
- [x] blocking (=) vs non-blocking (<=)
- [x] case / if-else / nested if
- [ ] parameter / 可調整模組大小
- [ ] 多模組連接練習


### RTL 概念
- [x] 組合邏輯寫法
- [x] 時序邏輯寫法
- [x] latch 產生原因與修正
- [x] 同步 reset counter
- [ ] 4-bit ALU (AND, OR, ADD, SUB)

# RTL 理論補充（已完成）
- [x] always @(*) 電路本質理解
- [x] latch 推導條件（未完整指定）
- [x] default assignment pattern
- [x] nested if latch 風險辨識
- [x] priority vs parallel 結構差異
- [x] @(*) vs @(posedge clk) 硬體語意差異

**Mini Project / 練習建議**
- [ ] 4-bit Calculator 模組
- [ ] Traffic Light Controller (FSM)
- [ ] 可調整長度 Shift Register
- [ ] priority encoder
---

## 🟢 Level 3：RTL 設計能力

### FSM 設計
- [ ] Moore / Mealy FSM
- [ ] 2~4 state FSM
- [ ] One-hot / Binary encoding
- [ ] LED Pattern / 音調 / Keypad Controller

### 資料路徑設計
- [ ] 8-bit Register File (4~8 reg)
- [ ] ALU 支援 ADD/SUB/AND/OR/XOR
- [ ] Pipeline Register (1~2 stage)
- [ ] Simple Memory Interface

### FPGA 概念
- [ ] LUT + Flip-Flop 推斷
- [ ] BRAM 推斷
- [ ] DSP Block 推斷 (乘法)
- [ ] IO constraint 練習 (LED/Button/VGA)
- [ ] Timing violation 模擬

**Mini Project / 練習建議**
- [ ] UART TX/RX 模組
- [ ] VGA Controller 顯示簡單圖形
- [ ] 8-bit CPU Datapath (ALU + RegFile + PC)

---

## 🟢 Level 4：系統設計能力

### Pipeline / System Design
- [ ] 2~3 stage Pipeline
- [ ] Data / Control hazard 處理
- [ ] Forwarding / Multi-cycle instruction
- [ ] Handshake protocol / ready-valid
- [ ] Simple bus / AXI-lite interface

**Mini Project / 練習建議**
- [ ] 16-bit CPU Datapath (部分 pipeline)
- [ ] UART + memory interface + simple IO
- [ ] VGA + keyboard input system

---

## 🟢 Level 5：架構設計 / CPU 等級

### 深層能力
- [ ] Branch prediction 思路 / 實作
- [ ] Cache 設計 (簡化 L1)
- [ ] Memory hierarchy 思路
- [ ] Timing closure / Floorplanning
- [ ] 完整 pipelined CPU 8~16-bit
- [ ] 支援 load/store + branch 指令
- [ ] 多模組整合：CPU + VGA + UART + BRAM

---

## 🔹 12 週 Roadmap 練習清單

| 週 | 模組 / 專案 | 建議天數 | 勾選 |
|---|-------------|----------|------|
| 1 | 二進制/十進制/十六進制轉換 | 1 | [x] |
| 1 | 有號數 / 無號數計算 | 1 | [x] |
| 1 | 2’s complement 加減法 | 1 | [x] |
| 1 | AND/OR/XOR/NOT 手算 | 1 | [x] |
| 2 | 真值表設計 (2~4 inputs) | 1 | [x] |
| 2 | 布林代數簡化 (K-map) | 1 | [x] |
| 2 | 德摩根定律驗證 | 1 | [x] |
| 3 | 半加器 + 全加器 | 2 | [x] |
| 3 | 4-bit Ripple Carry Adder | 2 | [x] |
| 3 | 2-to-1 / 4-to-1 MUX | 1 | [x] |
| 4 | 1-to-2 / 1-to-4 Demux | 1 | [x] |
| 4 | 3-to-8 Decoder | 1 | [x] |
| 4 | 8-to-3 Encoder | 1 | [x] |
| 4 | 2-bit / 4-bit Comparator | 1 | [x] |
| 5 | D / SR / JK Flip-Flop | 2 | [ ] |
| 5 | 同步 / 非同步 Reset Counter | 2 | [x] |
| 5 | Shift Register 左/右移 | 2 | [x] |
| 6 | Ring / Johnson Counter | 1 | [x] |
| 6 | LED 流水燈 | 1 | [ ] |
| 6 | module / input/output / wire/reg 練習 | 1 | [x] |
| 7 | assign & always @(*) 組合邏輯 | 1 | [ ] |
| 7 | always @(posedge clk) 時序邏輯 | 1 | [x] |
| 7 | blocking vs non-blocking | 1 | [x] |
| 7 | case / if-else / nested if | 1 | [ ] |
| 8 | parameter 可調整模組 | 1 | [ ] |
| 8 | N-bit Adder 模組 | 2 | [ ] |
| 8 | 可重用 MUX 模組 | 1 | [ ] |
| 8 | Latch 錯誤示範 & 修正 | 1 | [ ] |
| 9 | 可同步 reset Counter | 1 | [ ] |
| 9 | 4-bit ALU | 2 | [ ] |
| 9 | 4-bit Calculator 模組 | 2 | [ ] |
| 10 | Traffic Light Controller (FSM) | 2 | [ ] |
| 10 | Shift Register 可調整長度 | 1 | [ ] |
| 10 | Moore / Mealy FSM 寫法 | 2 | [ ] |
| 11 | 2~4 state FSM 練習 | 1 | [ ] |
| 11 | One-hot / Binary encoding | 1 | [ ] |
| 11 | LED Pattern / 音調 / Keypad Controller | 2 | [ ] |
| 11 | 8-bit Register File | 2 | [ ] |
| 12 | ALU 支援 ADD/SUB/AND/OR/XOR | 2 | [ ] |
| 12 | Pipeline Register | 2 | [ ] |
| 12 | Simple Memory Interface | 2 | [ ] |
| 12 | LUT + Flip-Flop 推斷 | 1 | [ ] |
| 12 | BRAM 推斷 | 1 | [ ] |
| 12 | DSP Block 推斷 | 1 | [ ] |
| 12 | IO Constraint 練習 | 1 | [ ] |
| 12 | Timing Violation 模擬 | 1 | [ ] |
| 12 | UART TX/RX 模組 | 3 | [ ] |
| 12 | VGA Controller | 3 | [ ] |
| 12 | 8-bit CPU Datapath | 4 | [ ] |

---

## 🔹 使用建議
1. 每天安排 2~3 個小模組練習  
2. 週末合併完成 mini project  
3. Level 0~2 可用筆算或模擬器驗證（Vivado / EDA Playground）  
4. Level 3 以上可用 FPGA 上板實作 (LED / VGA / UART)  
5. 每週完成後勾選 `[ ]`，整理筆記