# Verilog Learn

這個專案用來記錄 Verilog 與數位電路的學習、練習與 8-bit CPU 實作。

## 文件結構

```text
verilog_learn/
├─ README.md
├─ 學習進度.md
├─ Verilog + 數位電路完整學習 + 實作整合清單.md
├─ practice/
│  ├─ 基礎元件與練習電路
│  ├─ 組合邏輯（mux、decoder、comparator、multiplier）
│  └─ 循序邏輯（DFF、FSM、shift_register）
├─ testvench_t/
│  ├─ 小型 testbench 練習
│  └─ 波形輸出（wave.vcd）
└─ _8bitscpu/
	├─ v1/
	│  ├─ 第一版 CPU 架構與執行流程
	│  └─ test/（v1 專用測試）
	└─ v2/
		├─ cpu/（核心模組：ALU、控制器、暫存器、PC 等）
		├─ testbench/（v2 模擬驗證）
		└─ fpga/
			├─ cpu/（FPGA 版本整合）
			└─ seven_segments/（七段顯示相關模組）
```

## 各目錄用途

- 根目錄文件：學習記錄與整理清單，方便回顧進度與主題。
- practice：以單一主題為主的 Verilog 練習檔，適合快速驗證語法與電路概念。
- testvench_t：簡單模組搭配 testbench 的最小測試環境。
- _8bitscpu/v1：8-bit CPU 的早期版本，著重基本執行流程。
- _8bitscpu/v2/cpu：模組化後的 CPU 核心設計，便於維護與擴充。
- _8bitscpu/v2/testbench：v2 核心整合測試與波形觀察。

