# Verilog Learn

這個 repository 用來記錄我的 **Verilog、數位電路、CPU 架構與 FPGA 系統設計**學習歷程。

目前已完成從基礎數位邏輯、RTL、FSM，到一顆簡化 8-bit CPU 的模組整合與 DE10-Lite FPGA 上板驗證。下一個長期目標，是在保留模組化與可驗證性的前提下，逐步擴充成具有下列元件的小型可程式化 FPGA 系統：

```text
通用 CPU
  ├─ Instruction Memory
  ├─ Data RAM
  ├─ System Bus / Address Decoder
  ├─ Memory-mapped UART
  ├─ 獨立 GPU / Display Controller
  ├─ VRAM / Framebuffer
  ├─ VGA Output
  └─ Keyboard Input（進階）
```

重點不是把 UART 或 VGA 寫死在 CPU 裡，而是讓 CPU 執行程式，並透過 System Bus 控制獨立周邊。

---

## 目前里程碑

### 已完成

- Level 0～2：數位邏輯、組合與時序電路、Verilog RTL 基礎
- FSM：Moore／Mealy、two-block FSM、binary／one-hot encoding
- FPGA 輸入處理：2FF synchronizer、debounce、edge detect
- 8-bit CPU v2 模組化整合
- 兩狀態控制流程：`FETCH`／`EXECUTE`
- 四條指令：`ADD`、`ADDI`、`BEQZ`、`CP`
- DE10-Lite 上板驗證
- 按鍵單步執行、LED 指令顯示、七段顯示器暫存器／PC 顯示
- FPGA 版本 Instruction Memory 使用 `$readmemb` 載入 `program.mem`

### 目前正在進行

**Phase 0：舊 CPU 復健、規格整理與完整驗證**

目前最重要的 checkpoint：

1. 統一模擬版與 FPGA 版 CPU 原始碼／記憶體載入方式。
2. 建立可同時驗證 `ADD`、`ADDI`、`BEQZ`、`CP` 的測試程式。
3. 將 `tb_cpu.v` 升級為 self-checking testbench。
4. 自動檢查 PC 與暫存器結果並輸出 `PASS`／`FAIL`。
5. 文件化 branch target 與每條指令的時序行為。

在這個 checkpoint 完成前，不把 CPU v2 宣稱為「完整驗證完成」。

---

## 文件用途

| 文件 | 用途 |
|---|---|
| [`README.md`](README.md) | 專案入口、架構方向、目前 checkpoint 與目錄說明 |
| [`學習進度.md`](學習進度.md) | 已完成能力、實作證據、待補基礎與下一階段 |
| [`AI教學規則.md`](AI教學規則.md) | 固定 AI 的讀檔、教學、除錯與驗證方式 |
| [`Verilog + 數位電路完整學習 + 實作整合清單.md`](Verilog%20+%20數位電路完整學習%20+%20實作整合清單.md) | 原始 Level 0～5 能力樹與未完成基礎清單 |

判定進度時，以以下順序為準：

1. 實際 RTL、testbench 與模擬／上板結果
2. `學習進度.md`
3. `README.md`
4. 長期規劃與舊 checklist

文件勾選不等於功能已驗證；只有程式與驗證證據能作為完成依據。

---

## Repository 結構

```text
verilog_learn/
├─ README.md
├─ 學習進度.md
├─ AI教學規則.md
├─ Verilog + 數位電路完整學習 + 實作整合清單.md
├─ practice/
│  ├─ 基礎元件與練習電路
│  ├─ 組合邏輯（mux、decoder、comparator、multiplier）
│  └─ 時序邏輯（DFF、FSM、shift_register）
├─ testvench_t/
│  ├─ 小型 testbench 練習
│  └─ 波形輸出（wave.vcd）
└─ _8bitscpu/
   ├─ v1/
   │  ├─ 第一版 CPU 架構與執行流程
   │  └─ test/（v1 專用測試）
   └─ v2/
      ├─ cpu/（CPU 核心 RTL）
      ├─ testbench/（CPU 整合模擬）
      └─ fpga/
         ├─ cpu/（FPGA 整合版本與 program.mem）
         └─ seven_segments/（七段顯示相關模組）
```

---

## 各目錄用途

- `practice/`：單一數位電路與 RTL 主題練習。
- `testvench_t/`：小型模組的最小 testbench 與波形練習。
- `_8bitscpu/v1/`：早期 CPU 實驗版本，保留設計演進紀錄。
- `_8bitscpu/v2/cpu/`：模組化 CPU 核心；後續擴充前應先完成統一與驗證。
- `_8bitscpu/v2/testbench/`：目前 CPU 整合 testbench；現階段仍以波形觀察為主。
- `_8bitscpu/v2/fpga/`：DE10-Lite 整合、按鍵輸入、七段顯示與 FPGA 測試程式。

目前 `_8bitscpu/v2/cpu/` 與 `_8bitscpu/v2/fpga/cpu/` 存在部分重複模組。後續應降低兩份版本分歧，避免模擬通過但上板使用不同 RTL。

---

## 長期學習方向

建議依序完成：

```text
Phase 0  舊 CPU 完整驗證
Phase 1  BRAM、同步記憶體、Timing、Handshake
Phase 2  CPU ISA v2 與 Multi-cycle Datapath
Phase 3  Data RAM、System Bus、Memory-mapped I/O
Phase 4  UART TX／RX 與 FIFO
Phase 5  CPU 程式控制 UART
Phase 6  VGA Timing 與低解析度 Framebuffer
Phase 7  CPU 寫入 VRAM 顯示任意畫面
Phase 8  獨立 2D GPU、繪圖命令與 Command FIFO
Phase 9  CPU＋UART＋GPU＋VGA 系統整合
Phase 10 鍵盤輸入與文字終端（進階）
```

原學習計畫尚未完成的 BRAM、memory interface、timing、FIFO、handshake 與 testbench 基礎，必須在相關階段同步補齊，不因最終目標改變而跳過。

---

## 新對話的建議啟動方式

```text
@GitHub 請先讀取 marsh8787/verilog_learn 的 master 分支，
依序檢查 README.md、學習進度.md、AI教學規則.md，
再讀取與本次主題相關的最新 RTL 與 testbench。

本次主題：＿＿＿＿＿＿
本次模式：觀念教學／引導練習／除錯／架構檢查
尚未 push 的本機修改：沒有／＿＿＿＿＿＿
```

AI 應先回報實際讀取的檔案、目前 checkpoint、需要的前置知識，以及文件與程式是否矛盾，再開始教學。

---

## 學習與更新流程

每次學習建議遵循：

```text
觀念
→ 電路結構
→ 訊號與時序
→ 手推行為
→ RTL
→ Testbench
→ 系統整合
→ 模擬／上板驗證
→ 更新進度文件
```

每完成一個 checkpoint：

1. 將 RTL、testbench、測試程式與必要結果 push 到 GitHub。
2. 更新 `學習進度.md`。
3. 記錄驗證方式與尚未完成的限制。
4. 未經驗證的功能不得標記為完成。
