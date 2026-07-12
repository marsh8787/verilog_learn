# 通用 8-bit CPU＋UART＋獨立 2D GPU／VGA FPGA 系統
## 學習與實作整合路線

> 適用平台：DE10-Lite／MAX 10
>
> 本計畫承接既有的「Verilog＋數位電路完整學習計畫」與第一版 8-bit CPU 專題。
>
> 核心目標不是做一組固定功能的 UART 或 VGA 電路，而是建立一台可由程式控制、可擴充周邊、CPU 與顯示系統分離的小型 FPGA 電腦。

---

# 一、最終系統目標

完成以下架構：

```text
                     ┌────────────────────┐
                     │  Instruction ROM   │
                     └─────────┬──────────┘
                               │
                     ┌─────────▼──────────┐
                     │  通用 8-bit CPU v2 │
                     │ PC / RegFile / ALU │
                     │ Multi-cycle Control│
                     │ LOAD / STORE / JMP │
                     └─────────┬──────────┘
                               │ System Bus
             address / wdata / rdata / read / write / ready
                               │
                     ┌─────────▼──────────┐
                     │  Address Decoder   │
                     └─┬────────┬────────┬┘
                       │        │        │
                       ▼        ▼        ▼
                   Data RAM   UART     GPU Registers
                                           │
                                           ▼
                                     Command FIFO
                                           │
                                           ▼
                                      2D GPU Core
                                           │
                                           ▼
                         CPU/GPU write ──► VRAM ◄── VGA read
                                           │
                                           ▼
                                  VGA Timing / Pixel
                                           │
                                           ▼
                                      VGA Display
```

進階輸入路徑：

```text
USB Keyboard
    │
    ▼
外部 USB Host／MCU Bridge
    │ UART 或 SPI
    ▼
Keyboard Controller／Key FIFO
    │ Memory-mapped I/O
    ▼
CPU 程式處理按鍵
```

---

# 二、完成後應具備的能力

## CPU 與系統架構

- [ ] 能重新設計一套可擴充的 ISA，而不是只支援固定四條指令
- [ ] 能區分 instruction memory、data memory 與 memory-mapped I/O
- [ ] 能設計 multi-cycle CPU control FSM
- [ ] 能實作 LOAD、STORE、JMP、條件分支、邏輯及位移指令
- [ ] 能設計具 `ready`／等待能力的簡易 System Bus
- [ ] 能讓 CPU 透過程式控制 UART、GPU、Timer 與鍵盤等周邊

## UART 與資料傳輸

- [ ] 能從 baud rate 推導 clock divider／baud tick
- [ ] 能獨立實作 UART TX、UART RX
- [ ] 能處理 `busy`、`done`、`valid`、framing error
- [ ] 能實作小型同步 FIFO
- [ ] 能將 UART 封裝成 memory-mapped peripheral
- [ ] 能由 CPU 程式完成文字收發，而非硬體直接 loopback

## VGA 與 GPU

- [ ] 能推導 VGA horizontal／vertical timing
- [ ] 能產生 pixel coordinate、display enable、HSYNC、VSYNC
- [ ] 能從 BRAM 建立 framebuffer／VRAM
- [ ] 能處理 VGA 連續讀取與 CPU／GPU 寫入
- [ ] 能建立 CPU 與 VGA 顯示分離的架構
- [ ] 能實作基礎 2D GPU 命令：CLEAR、PIXEL、FILL_RECT
- [ ] 能逐步增加 LINE、CHAR、BLIT、Sprite 或 Tile 功能

## FPGA 工程能力

- [ ] 能辨識 LUT、Flip-Flop、BRAM、PLL、DSP 的推斷結果
- [ ] 能閱讀 Quartus Compilation Report
- [ ] 能理解 synchronous RAM 的讀取延遲
- [ ] 能設定時脈與基本 timing constraint
- [ ] 能分析 critical path 與 timing violation
- [ ] 能處理不同 clock／clock-enable 下的資料跨域問題

## 驗證與工具

- [ ] 每個模組都有獨立 testbench
- [ ] 系統整合測試使用 self-checking testbench
- [ ] 能使用 `$readmemh` 載入 CPU 程式及圖像資料
- [ ] 能用 Python／簡易 assembler 產生 machine code
- [ ] 能以 Git commit 保留每個 milestone 的可運作版本

---

# 三、目前起點

## 已完成能力

- [x] 二進位、十六進位、二補數、真值表、K-map
- [x] 基本組合邏輯與時序邏輯
- [x] MUX、Decoder、Encoder、Adder、Comparator
- [x] Flip-Flop、Counter、Shift Register、Ring／Johnson Counter
- [x] 組合與時序 RTL 寫法
- [x] blocking／non-blocking、latch、default assignment
- [x] Parameterized MUX／Adder／ALU
- [x] C／Z／N／V flags 的基礎
- [x] Moore／Mealy、two-block FSM、one-hot／binary encoding
- [x] 2FF Synchronizer、Debounce、Edge Detect
- [x] Datapath／Control 分離概念
- [x] 第一版 8-bit CPU：PC、IR、RegFile、ALU、Immediate、Branch、Control
- [x] 第一版 CPU 支援 ADD、ADDI、BEQZ、CP
- [x] DE10-Lite CPU 上板與七段顯示器驗證

## 需要先修正的舊紀錄

舊進度文件中仍把 Full CPU Integration 標成未完成，但實際上第一版 CPU 已完成上板驗證。新的起點應定義為：

> 第一版 CPU 已能運作；下一步先補齊完整驗證與規格，再設計 CPU v2。

---

# 四、教學與實作原則

1. **先補前置知識再實作**：若新階段涉及尚未學過的 memory timing、bus、FIFO、VGA timing 或組合語言，先完成觀念教學。
2. **先手推，再畫結構，再寫 RTL**：每個模組都要先說清楚暫存器、MUX、counter、FSM 與資料流。
3. **練習只給必要提示**：除非主動要求完整答案，否則先讓學習者自行完成 RTL。
4. **規格先於程式碼**：先定義輸入、輸出、時序、狀態、錯誤條件及驗證方式。
5. **模組驗證先於系統整合**：單元 testbench 通過後才能進入下一層。
6. **每個 milestone 都要留下可運作版本**：使用 Git tag／branch 保留穩定節點。
7. **先使用簡單、可理解的架構**：初版不急著導入 pipeline、cache、AXI 或完整 USB Host。
8. **CPU 與周邊分離**：UART、VGA、GPU、Keyboard 都以 peripheral 形式接到 bus，不把功能寫死在 CPU control 中。
9. **CPU 與 GPU 分離**：CPU 下命令；GPU 執行繪圖；VGA controller 持續掃描顯示。
10. **完成條件必須可觀察**：每一階段都要有 waveform、PASS／FAIL 或 FPGA 實體輸出。

---

# 五、整體階段與解鎖順序

```text
Phase 0  第一版 CPU 復健與驗證收斂
   ↓
Phase 1  FPGA Memory／Timing／Handshake 基礎
   ↓
Phase 2  CPU v2 ISA 與微架構規格
   ↓
Phase 3  CPU v2 Multi-cycle Datapath／Control
   ↓
Phase 4  Data RAM＋System Bus＋Memory-mapped I/O
   ↓
Phase 5  UART TX／RX／FIFO Peripheral
   ↓
Phase 6  CPU 程式控制 UART
   ↓
Phase 7  VGA Timing 與固定圖形
   ↓
Phase 8  BRAM Framebuffer／VRAM 顯示控制器
   ↓
Phase 9  CPU 寫 VRAM 與基本畫面輸出
   ↓
Phase 10 獨立 2D GPU Core＋Command FIFO
   ↓
Phase 11 UART＋CPU＋GPU 完整系統
   ↓
Phase 12 鍵盤輸入與進階系統功能
```

---

# Phase 0：第一版 CPU 復健與驗證收斂

## 目的

重新熟悉既有 CPU，先把舊專案中尚未完成的驗證與文件補齊，避免在不確定舊架構行為的情況下直接升級。

## 觀念複習

- [ ] 逐條手推 ADD、ADDI、BEQZ、CP 的 datapath
- [ ] 重新確認 FETCH／EXECUTE 的 clock-edge 行為
- [ ] 重新確認 PC 在 branch 時使用哪一個基準位址
- [ ] 重新確認 immediate sign extension
- [ ] 重新確認 R0 的讀寫規則
- [ ] 重新確認 `cpu_en` 對 state、PC、IR、RegFile 的影響

## 實作

- [ ] 撰寫第一版 CPU ISA 規格表
- [ ] 補上 instruction encoding 表
- [ ] 補上 branch target 的正式定義
- [ ] Instruction Memory 改用 `$readmemh`
- [ ] 建立至少一個 `.mem`／`.hex` 測試程式
- [ ] 建立完整 CPU testbench
- [ ] 自動檢查 R0～R7、PC 與執行週期
- [ ] 測試正向與負向 branch offset
- [ ] 測試 R0 不可寫入

## 同步補舊計畫基礎

- [ ] Full CPU datapath integration：以正式 testbench 補完紀錄
- [ ] Instruction Memory 初始化
- [ ] Branch target 規格文件化
- [ ] 4-bit Calculator：可用既有 ALU 作快速復健，不要求上板
- [ ] Traffic Light FSM：可用小型練習恢復 FSM 手感

## 通關條件

- [ ] 模擬終端輸出 `CPU V1 TEST PASS`
- [ ] 所有四種指令至少各測一次
- [ ] branch taken／not taken 都通過
- [ ] 規格文件與 RTL 行為一致
- [ ] 建立 Git tag：`cpu-v1-verified`

---

# Phase 1：FPGA Memory、Timing 與 Handshake 基礎

## 目的

補齊原計畫尚未完成、但新系統一定會使用的 FPGA 基礎。

## 1. LUT 與 Flip-Flop 推斷

- [ ] 組合 assign 如何映射 LUT
- [ ] `always @(posedge clk)` 如何映射 register
- [ ] enable 如何推斷 clock enable／MUX
- [ ] asynchronous reset 與 synchronous reset 的資源差異
- [ ] 閱讀 Quartus RTL Viewer／Technology Map Viewer

## 2. BRAM 與同步記憶體

- [ ] asynchronous read RAM 與 synchronous read RAM 差異
- [ ] 一個 clock latency 的意義
- [ ] Single-port RAM
- [ ] Simple dual-port RAM
- [ ] True dual-port RAM 的概念
- [ ] ROM 與 `$readmemh`
- [ ] Quartus M9K 推斷檢查

## 3. Handshake

- [ ] `valid`／`ready` 的定義
- [ ] producer 與 consumer 的責任
- [ ] backpressure
- [ ] 單筆 transaction timing diagram
- [ ] bus `ready=0` 時 CPU 為何必須等待

## 4. Timing 基礎

- [ ] clock period
- [ ] setup／hold 複習
- [ ] combinational path／critical path
- [ ] clock enable 與自行分頻 clock 的差異
- [ ] 基本 SDC clock constraint
- [ ] Quartus timing report 閱讀

## 同步補舊計畫基礎

- [ ] 可調整長度 Shift Register
- [ ] Pipeline Register（先作一般資料管線，不做 CPU pipeline）
- [ ] Simple Memory Interface
- [ ] LUT＋Flip-Flop inference
- [ ] BRAM inference
- [ ] IO constraint 練習
- [ ] Timing violation 模擬／分析
- [ ] DSP Block 推斷：只做乘法器觀察資源，暫不整合進 CPU
- [ ] LED 流水燈：作為 clock enable／counter 復健

## Mini Project

建立一個雙埠 RAM：

```text
Port A：每個 clock 寫入遞增資料
Port B：從不同 address 讀取並顯示到七段顯示器／testbench
```

## 通關條件

- [ ] 模擬確認 synchronous read latency
- [ ] Quartus 報告確認 RAM 被推斷為 M9K，而非大量 register
- [ ] 能解釋 CPU 為何不能假設 memory read 立即完成
- [ ] 建立 Git tag：`fpga-memory-basics`

---

# Phase 2：CPU v2 ISA 與微架構規格

## 目的

先設計規格，不急著寫 RTL。

## 建議初版規格

- Data width：8-bit
- Instruction width：16-bit
- Register File：8 × 8-bit，R0 固定為 0
- Instruction Address：第一版可先維持 8-bit
- Data／I/O Address：第一版可先維持 8-bit
- Architecture：Harvard architecture
- Control：Multi-cycle FSM
- I/O：Memory-mapped I/O

> 第一版以 256-word instruction space＋256-byte data／I/O space完成架構驗證；若之後容量不足，再設計 CPU v2.1 擴充 16-bit address，而不是一開始就同時處理所有複雜度。

## ISA 規劃

至少規劃以下類型：

### 資料搬移

- [ ] MOV／CP
- [ ] LDI：load immediate
- [ ] LD：data memory／I/O read
- [ ] ST：data memory／I/O write

### 算術與邏輯

- [ ] ADD
- [ ] SUB
- [ ] AND
- [ ] OR
- [ ] XOR
- [ ] SHL
- [ ] SHR

### 流程控制

- [ ] JMP
- [ ] BEQZ
- [ ] BNEZ
- [ ] NOP

### 後續選配

- [ ] CMP／flags
- [ ] CALL／RET
- [ ] Stack Pointer
- [ ] PUSH／POP
- [ ] Interrupt enable／return

## 指令格式工作

- [ ] 定義 R-type
- [ ] 定義 Immediate-type
- [ ] 定義 Memory-type
- [ ] 定義 Branch／Jump-type
- [ ] 定義每個欄位的位置
- [ ] 定義 sign extension／zero extension
- [ ] 定義 branch offset 基準
- [ ] 定義非法 opcode 行為

## 微操作表

每條指令都要寫成 register transfer，例如：

```text
LD Rd, [addr]
FETCH     : IR  <- IMEM[PC]
PC UPDATE : PC  <- PC + 1
MEM READ  : MDR <- BUS[addr]
WRITEBACK : R[rd] <- MDR
```

## 通關條件

- [ ] 完整 ISA 表
- [ ] 每條指令的 encoding 範例
- [ ] 每條指令的 micro-operation 表
- [ ] 指令與 datapath control signal 對照表
- [ ] 尚未寫 RTL 前，能手動執行一段 10～20 條指令的程式
- [ ] 建立 Git tag：`cpu-v2-spec`

---

# Phase 3：CPU v2 Multi-cycle Datapath 與 Control

## 目的

讓 CPU 能等待同步記憶體與慢速周邊，不再限制為固定 FETCH／EXECUTE 兩狀態。

## Datapath 新增模組

- [ ] 16-bit Instruction Register
- [ ] 擴充版 Instruction Decoder
- [ ] ALU operation selector
- [ ] ALU flags 或 zero comparator
- [ ] Memory Address Register（需要時）
- [ ] Memory Data Register（需要時）
- [ ] Writeback MUX
- [ ] PC source MUX
- [ ] Immediate generator v2

## 建議控制狀態

```text
FETCH
DECODE
EXECUTE
MEM_WAIT
WRITEBACK
```

依指令可跳過不需要的狀態。

## 實作順序

- [ ] 先只完成 NOP、MOV、ADD
- [ ] 再加入 SUB、AND、OR、XOR
- [ ] 再加入 LDI、SHL、SHR
- [ ] 再加入 JMP、BEQZ、BNEZ
- [ ] 最後才接 LD／ST 的 bus transaction

## 驗證

- [ ] Decoder 單元 testbench
- [ ] ALU 單元 testbench
- [ ] Control FSM 狀態測試
- [ ] CPU core testbench
- [ ] 每種 instruction format 都有測試
- [ ] illegal opcode 不會破壞 register／memory

## 通關條件

- [ ] 不接周邊時，CPU v2 可執行 register／branch 程式
- [ ] testbench 自動檢查暫存器與 PC
- [ ] 能以 waveform 說明每條指令經過哪些狀態
- [ ] 建立 Git tag：`cpu-v2-core`

---

# Phase 4：Data RAM、System Bus 與 Memory-mapped I/O

## 目的

建立「CPU 可接任意周邊」的核心介面。

## System Bus 建議訊號

```verilog
bus_addr
bus_write_data
bus_read_data
bus_read
bus_write
bus_ready
bus_error   // 可選
```

## 必學觀念

- [ ] master／slave
- [ ] address decode
- [ ] read transaction
- [ ] write transaction
- [ ] wait state
- [ ] unmapped address
- [ ] combinational response 與 registered response
- [ ] 同一時間只能選中一個 slave

## 初版 Memory Map 範例

```text
0x00～0x7F  Data RAM
0x80～0x8F  GPU registers
0x90～0x9F  UART registers
0xA0～0xAF  Timer／GPIO
0xB0～0xBF  Keyboard registers（進階）
0xC0～0xFF  保留
```

## 實作

- [ ] Data RAM slave
- [ ] Address Decoder
- [ ] Read-data MUX
- [ ] default slave／bus error
- [ ] CPU LD／ST transaction
- [ ] 加入可配置等待週期的 dummy peripheral

## 同步補舊計畫基礎

- [ ] Simple Memory Interface
- [ ] Handshake protocol／ready-valid
- [ ] Simple Bus 基礎

> 此處先做自訂簡易 bus。AXI-Lite 等標準 bus 應在自訂 bus 完全理解後再學。

## 通關條件

- [ ] CPU 可 LD／ST Data RAM
- [ ] CPU 面對 `bus_ready=0` 時會停在等待狀態
- [ ] 未映射位址不會誤寫其他裝置
- [ ] testbench 同時測 RAM 與 dummy peripheral
- [ ] 建立 Git tag：`cpu-v2-system-bus`

---

# Phase 5：UART TX、RX 與 FIFO Peripheral

## 目的

先理解 UART，再將它包裝成 CPU 周邊。

## UART TX

- [ ] UART frame：idle／start／8 data／stop
- [ ] LSB first
- [ ] baud tick generator
- [ ] TX shift register
- [ ] bit counter
- [ ] TX FSM
- [ ] `tx_start`、`tx_busy`、`tx_done`

## UART RX

- [ ] start bit detection
- [ ] middle-of-bit sampling
- [ ] RX shift register
- [ ] bit counter
- [ ] `rx_valid`
- [ ] framing error
- [ ] 2FF synchronizer
- [ ] 8×／16× oversampling 概念，初版可先採可理解方案

## FIFO

- [ ] write pointer
- [ ] read pointer
- [ ] empty／full
- [ ] count 或 pointer-wrap 判斷
- [ ] simultaneous read／write
- [ ] overflow／underflow 行為

## Memory-mapped Registers 範例

```text
UART_DATA
  write：送入 TX FIFO
  read ：取出 RX FIFO

UART_STATUS
  bit0：RX not empty
  bit1：TX not full
  bit2：TX busy
  bit3：framing error
```

## 同步補舊計畫基礎

- [ ] 可調整長度 Shift Register
- [ ] Counter 與 FSM 綜合練習
- [ ] UART TX／RX Mini Project

## 驗證順序

- [ ] TX 自動檢查每一 bit 的持續時間
- [ ] RX 以 testbench 模擬 serial waveform
- [ ] TX→RX internal loopback
- [ ] FIFO 壓力測試
- [ ] UART peripheral bus read／write

## 通關條件

- [ ] FPGA 能向電腦終端機傳送固定字串
- [ ] FPGA 能接收字元並在 LED／七段顯示器顯示 ASCII
- [ ] loopback 能連續處理多個 byte
- [ ] FIFO full／empty 行為正確
- [ ] 建立 Git tag：`uart-peripheral`

---

# Phase 6：由 CPU 程式控制 UART

## 目的

證明 UART 是可程式控制的周邊，而不是寫死的資料路徑。

## 先備：簡易 Assembly

- [ ] label
- [ ] instruction operand
- [ ] immediate
- [ ] branch／jump
- [ ] polling
- [ ] memory-mapped register

## 測試程式

- [ ] UART 傳送單一字元
- [ ] 傳送固定字串
- [ ] polling UART_STATUS
- [ ] 收到字元後由 CPU 回傳
- [ ] 將小寫 ASCII 轉大寫後回傳
- [ ] 收到命令後修改 LED／七段顯示器

## 工具

- [ ] 先手動編碼簡短程式
- [ ] 再用 Python 建立最小 assembler
- [ ] assembler 支援 label resolution
- [ ] 產生 `$readmemh` 可讀的 ROM 檔案

## 通關條件

- [ ] 迴路回傳由 CPU 軟體完成，不是 RTL 直接接線
- [ ] 修改 ROM 程式即可改變 UART 行為，無須修改 UART RTL
- [ ] assembler 能編譯至少 15 條核心指令
- [ ] 建立 Git tag：`cpu-uart-terminal`

---

# Phase 7：VGA Timing 與固定圖形

## 目的

先完成與 CPU 無關的 VGA 顯示基礎。

## 觀念

- [ ] active display
- [ ] front porch
- [ ] sync pulse
- [ ] back porch
- [ ] horizontal counter
- [ ] vertical counter
- [ ] pixel clock／clock enable
- [ ] HSYNC／VSYNC polarity
- [ ] display enable

## 實作順序

- [ ] VGA timing generator
- [ ] 輸出目前 pixel `x`／`y`
- [ ] 全畫面固定色
- [ ] color bar
- [ ] 方框
- [ ] checkerboard
- [ ] 移動方塊

## 同步補舊計畫基礎

- [ ] IO constraint：VGA pins
- [ ] Counter 大型整合
- [ ] Pipeline Register：pixel coordinate／color pipeline
- [ ] VGA Controller 顯示簡單圖形

## 通關條件

- [ ] 螢幕穩定鎖定訊號
- [ ] HSYNC／VSYNC testbench 週期符合規格
- [ ] active 區域外輸出黑色
- [ ] 能依 `x`／`y` 產生至少三種圖案
- [ ] 建立 Git tag：`vga-timing`

---

# Phase 8：BRAM Framebuffer／VRAM 顯示控制器

## 目的

建立獨立顯示記憶體，讓 VGA controller 只負責讀取並顯示。

## 初版建議

```text
邏輯解析度：160 × 120
每像素：8-bit indexed／RGB332
VGA 輸出：每個邏輯 pixel 放大為 4 × 4
VRAM：Simple Dual-port BRAM
```

## 必學觀念

- [ ] framebuffer address：`y * WIDTH + x`
- [ ] 乘法常數化／shift-add
- [ ] BRAM synchronous read latency
- [ ] pixel pipeline 對齊
- [ ] read port 與 write port 分離
- [ ] RGB332／palette 概念

## 實作

- [ ] 初始化 framebuffer 圖案
- [ ] VGA port 持續讀取
- [ ] write port 可修改指定 pixel
- [ ] 加入 pixel scaling
- [ ] 測試畫面更新時的 tearing 現象
- [ ] 選配：double buffering 概念

## 通關條件

- [ ] framebuffer 被推斷成 BRAM
- [ ] 能用 testbench 寫一個 pixel，再在正確座標讀到
- [ ] 上板顯示由 `.mem` 初始化的圖片
- [ ] 修改 write port 可改變任意 pixel
- [ ] 建立 Git tag：`vga-framebuffer`

---

# Phase 9：CPU 控制 Framebuffer

## 目的

先完成 CPU／顯示分離，但尚未加入硬體繪圖 GPU。

## 方案

CPU 不直接參與 VGA timing；CPU 只透過 GPU／VRAM 周邊介面修改畫面。

## 第一版 GPU Register 介面

```text
GPU_X
GPU_Y
GPU_COLOR
GPU_PIXEL_WRITE
GPU_STATUS
```

CPU 寫入 X、Y、Color，最後寫入 command／trigger register，控制器再把 pixel 寫進 VRAM。

## CPU 程式

- [ ] 畫單點
- [ ] 以迴圈畫水平線
- [ ] 以迴圈畫垂直線
- [ ] 以軟體畫矩形
- [ ] UART 收到座標／顏色後畫點

## 通關條件

- [ ] CPU 可透過 LD／ST 控制 GPU registers
- [ ] CPU 停止或變慢時，VGA 仍持續穩定顯示
- [ ] UART 命令可改變螢幕像素
- [ ] 建立 Git tag：`cpu-framebuffer`

---

# Phase 10：獨立 2D GPU Core 與 Command FIFO

## 目的

讓 GPU 自行執行繪圖迴圈，CPU 只提交命令。

## 第一版命令

- [ ] CLEAR_SCREEN
- [ ] DRAW_PIXEL
- [ ] FILL_RECT

## GPU Registers／Command Packet

可包含：

```text
COMMAND
X0
Y0
X1／WIDTH
Y1／HEIGHT
COLOR
STATUS
```

## 必學觀念

- [ ] command／parameter register
- [ ] command FIFO
- [ ] CPU producer、GPU consumer
- [ ] GPU busy／ready
- [ ] nested counter
- [ ] VRAM write arbitration
- [ ] GPU operation completion

## 進階命令

- [ ] DRAW_LINE：Bresenham 演算法前先學整數誤差概念
- [ ] DRAW_CHAR：Font ROM
- [ ] BLIT：區塊複製
- [ ] Sprite：透明色與座標
- [ ] Tile Map：遊戲背景
- [ ] Palette：indexed color

## 通關條件

- [ ] CPU 提交 FILL_RECT 後可繼續執行其他程式
- [ ] GPU 自行完成矩形填色
- [ ] Command FIFO 能保存多筆命令
- [ ] GPU 不會寫出 VRAM 範圍
- [ ] 建立 Git tag：`gpu-2d-v1`

---

# Phase 11：UART＋CPU＋GPU 完整系統

## 目的

建立可由電腦透過 UART 控制的小型 FPGA 圖形電腦。

## 建議指令協定

### 文字命令版

```text
CLEAR 3
PIXEL 20 30 255
RECT 10 10 40 20 224
```

### 二進位封包版（進階）

```text
SOF | CMD | LENGTH | PAYLOAD | CHECKSUM
```

## CPU 軟體工作

- [ ] 從 UART RX FIFO 讀字元
- [ ] parser／command decoder
- [ ] 數字字串轉整數
- [ ] 寫入 GPU command registers
- [ ] 等待／查詢 GPU status
- [ ] 回傳 OK／ERROR

## 系統驗證

- [ ] CPU core testbench
- [ ] Bus testbench
- [ ] UART peripheral testbench
- [ ] GPU testbench
- [ ] VGA timing testbench
- [ ] System-level testbench
- [ ] 上板長時間運行測試

## 通關條件

- [ ] 電腦透過 UART 能控制 VGA 畫面
- [ ] 不修改 FPGA bitstream，只改命令或 CPU 程式即可顯示不同內容
- [ ] CPU、UART、GPU、VGA 四者責任清楚分離
- [ ] 建立 Git tag：`fpga-computer-v1`

---

# Phase 12：鍵盤輸入與進階系統

## 路線 A：先以電腦鍵盤完成終端機

```text
PC Keyboard → Serial Terminal → UART → CPU
```

- [ ] VGA 文字模式
- [ ] ASCII Font ROM
- [ ] Cursor
- [ ] Newline
- [ ] Backspace
- [ ] Command shell

## 路線 B：外部 USB Host／MCU Bridge

```text
USB Keyboard → MCU／USB Host Controller → UART／SPI → FPGA
```

- [ ] 定義 bridge 封包
- [ ] Keyboard RX peripheral
- [ ] Key FIFO
- [ ] key press／release
- [ ] modifier keys
- [ ] ASCII mapping

## 路線 C：純 FPGA USB Host（研究級選配）

此路線涉及 USB PHY／Host、enumeration、control transfer、HID descriptor 等內容，應在前兩種路線完成後再評估，不列為第一版必要目標。

## 通關條件

- [ ] 鍵盤輸入由 CPU 程式讀取
- [ ] 按鍵可顯示在 VGA
- [ ] 可透過 UART 回覆電腦
- [ ] 可控制簡易選單／文字終端／小遊戲
- [ ] 建立 Git tag：`fpga-computer-keyboard`

---

# 六、建議週期表（彈性 28 週）

> 以下是建議節奏，不是硬性截止日期。每階段應以通關條件為準。

| 週次 | 主題 | 舊計畫同步補強 | 主要成果 |
|---|---|---|---|
| 1～2 | CPU v1 復健、完整 TB、`$readmemh` | Full CPU TB、Branch 文件 | `cpu-v1-verified` |
| 3～4 | LUT／FF／BRAM／同步 RAM | BRAM、LUT、Memory Interface | Dual-port RAM |
| 5 | Timing、SDC、ready／valid | Timing violation、Handshake | Timing／bus 練習 |
| 6～7 | CPU v2 ISA 與微操作規格 | Calculator、FSM 復健 | `cpu-v2-spec` |
| 8～10 | CPU v2 datapath／control | Pipeline register 基礎 | `cpu-v2-core` |
| 11～12 | Data RAM、Bus、LD／ST | Simple Bus／Memory Interface | `cpu-v2-system-bus` |
| 13～14 | UART TX／RX | Shift Register、Counter、FSM | UART loopback |
| 15 | FIFO、UART peripheral | ready／valid | `uart-peripheral` |
| 16～17 | CPU Assembly／UART 程式 | 程式記憶體初始化 | `cpu-uart-terminal` |
| 18～19 | VGA timing／固定圖形 | IO constraint、pixel pipeline | `vga-timing` |
| 20～21 | BRAM framebuffer | BRAM inference | `vga-framebuffer` |
| 22 | CPU 控制 pixel | Memory-mapped I/O | `cpu-framebuffer` |
| 23～25 | 2D GPU／Command FIFO | FIFO、nested counter | `gpu-2d-v1` |
| 26～27 | UART command parser／全系統 | System integration | `fpga-computer-v1` |
| 28+ | 文字模式／鍵盤／進階圖形 | VGA＋keyboard system | 進階版本 |

---

# 七、原計畫未完成項目的整合對照

## 必須納入本計畫

| 原計畫未完成項目 | 新計畫安排 |
|---|---|
| Full CPU testbench | Phase 0 |
| Instruction Memory／`$readmemh` | Phase 0、Phase 6 |
| Branch target 文件化 | Phase 0、Phase 2 |
| 可調整長度 Shift Register | Phase 1、Phase 5 |
| Pipeline Register | Phase 1、Phase 7／8 |
| Simple Memory Interface | Phase 1、Phase 4 |
| LUT＋Flip-Flop 推斷 | Phase 1 |
| BRAM 推斷 | Phase 1、Phase 8 |
| DSP Block 推斷 | Phase 1 選配練習 |
| IO Constraint | Phase 1、Phase 7 |
| Timing violation | Phase 1、系統整合後重測 |
| UART TX／RX | Phase 5 |
| VGA Controller | Phase 7～8 |
| Handshake／ready-valid | Phase 1、Phase 4、Phase 10 |
| Simple Bus | Phase 4 |
| UART＋Memory＋IO | Phase 4～6 |
| VGA＋Keyboard | Phase 7～12 |
| CPU＋VGA＋UART＋BRAM | Phase 11 |
| LOAD／STORE＋Branch | Phase 2～4 |

## 可作暖身，但非主線必要

| 原計畫項目 | 建議處理 |
|---|---|
| LED 流水燈 | Phase 1 clock-enable 暖身 |
| 4-bit Calculator | Phase 0 ALU 復健 |
| Traffic Light FSM | Phase 0 FSM 復健 |
| LED Pattern／音調／Keypad | 不必完整做；相關能力會由 UART／GPU／Keyboard 覆蓋 |
| Tic-Tac-Toe 真值表 | 與主線關聯低，可保留為選修 |
| Priority Encoder | 未來 interrupt priority／arbiter 時再補 |
| CPU Pipeline／Hazard／Forwarding | 完成 `fpga-computer-v1` 後再進入 |
| Cache／Branch Prediction | CPU v2 與完整系統穩定後再學 |

---

# 八、暫緩項目

在第一版完整系統完成前，暫不優先：

- [ ] 2～3 stage CPU pipeline
- [ ] data／control hazard
- [ ] forwarding
- [ ] branch prediction
- [ ] cache
- [ ] AXI-Lite
- [ ] 外部 SDRAM framebuffer
- [ ] 純 FPGA USB Host
- [ ] 高解析度完整 640×480 framebuffer
- [ ] 3D GPU

原因：這些項目都會同時增加時序、仲裁、協定或驗證複雜度，容易掩蓋 CPU、bus、UART、GPU 的核心學習目標。

---

# 九、建議專案目錄

```text
fpga-computer/
├─ docs/
│  ├─ architecture.md
│  ├─ cpu_v2_isa.md
│  ├─ memory_map.md
│  ├─ bus_protocol.md
│  ├─ uart_registers.md
│  └─ gpu_registers.md
├─ rtl/
│  ├─ cpu/
│  ├─ bus/
│  ├─ memory/
│  ├─ uart/
│  ├─ gpu/
│  ├─ vga/
│  ├─ keyboard/
│  └─ top/
├─ tb/
│  ├─ unit/
│  └─ system/
├─ programs/
│  ├─ asm/
│  ├─ hex/
│  └─ tests/
├─ tools/
│  └─ assembler/
├─ constraints/
├─ quartus/
└─ README.md
```

---

# 十、每個模組的固定學習模板

```text
1. 功能目標
2. 輸入／輸出定義
3. 時序需求
4. 手動畫資料流／狀態圖
5. 列出需要的 Register、MUX、Counter、Comparator
6. 寫 RTL
7. 寫單元 testbench
8. 加入極端條件與錯誤測試
9. 查看 Quartus 推斷資源
10. 整合至上層
11. 更新規格文件
12. Git commit／tag
```

---

# 十一、驗證標準

## 單元模組

- [ ] 正常輸入
- [ ] 邊界輸入
- [ ] reset
- [ ] enable／stall
- [ ] 非法輸入
- [ ] 連續操作
- [ ] 自動 PASS／FAIL

## CPU

- [ ] 每條指令至少一個測試
- [ ] register dependency
- [ ] branch taken／not taken
- [ ] 最大／最小 immediate
- [ ] R0 規則
- [ ] memory wait state
- [ ] peripheral wait state
- [ ] illegal opcode

## UART

- [ ] baud 誤差範圍
- [ ] 連續 byte
- [ ] start／stop bit
- [ ] FIFO full／empty
- [ ] framing error

## GPU／VGA

- [ ] 邊界座標
- [ ] 畫面外座標
- [ ] 矩形寬高為 0／1
- [ ] VRAM address 上下界
- [ ] 同時 VGA read 與 GPU write
- [ ] command FIFO full

## 系統

- [ ] reset 後所有 peripheral 狀態
- [ ] CPU 程式可查詢 peripheral 狀態
- [ ] 慢速周邊不會讓 bus 錯誤完成
- [ ] 長時間運行不當機
- [ ] 修改程式即可改變功能

---

# 十二、最終成果定義

## 最低完成版本：FPGA Computer v1

- [ ] CPU v2 執行 16-bit 指令
- [ ] Data RAM
- [ ] Memory-mapped System Bus
- [ ] UART TX／RX＋FIFO
- [ ] VGA timing
- [ ] BRAM framebuffer
- [ ] CPU 可畫 pixel／矩形
- [ ] 電腦可透過 UART 傳送繪圖命令
- [ ] VGA 顯示不同畫面

## 標準完成版本：FPGA Computer v1.5

- [ ] 獨立 2D GPU
- [ ] Command FIFO
- [ ] CLEAR／PIXEL／FILL_RECT／CHAR
- [ ] VGA 文字終端
- [ ] CPU command parser
- [ ] UART 軟體回覆

## 進階完成版本：FPGA Computer v2

- [ ] 外部鍵盤輸入
- [ ] Sprite／Tile／BLIT
- [ ] Timer／Interrupt
- [ ] 簡易 Monitor／Bootloader
- [ ] CPU v2.1 擴充地址空間
- [ ] 外部 SDRAM 或較高解析度 framebuffer

---

# 十三、下一個立即任務

不要立刻開始重寫 CPU v2。先依序完成：

1. [ ] 重新閱讀第一版 CPU 所有模組
2. [ ] 畫出目前 datapath
3. [ ] 補寫四條指令的正式 ISA 表
4. [ ] 建立 `$readmemh` 測試程式
5. [ ] 完成 self-checking Full CPU testbench
6. [ ] 確認舊 CPU 行為後，才進入 BRAM／memory timing

第一個 checkpoint：

> **在不修改 CPU 指令功能的前提下，讓第一版 CPU 透過外部 `.mem` 程式完成 ADD、ADDI、CP、BEQZ 測試，並由 testbench 自動輸出 PASS。**

---

# 十四、給 AI 教學助手的固定指示

- 先查看本文件與目前進度紀錄，再安排下一課。
- 不把尚未完成的項目假設為已學會。
- 介紹新概念前，先列出必要前置知識並確認缺口。
- 每課依序採用：觀念 → 手推 → 結構 → RTL → testbench → 上板／整合。
- 練習預設只給提示，不直接提供完整 RTL。
- 若程式有問題，先指出電路或時序原因，再提供修改方向。
- 不因最終目標很大而跳過 memory timing、handshake、FIFO、bus 等基礎。
- 每完成一個 milestone，更新本文件核取方塊及 `學習進度.md`。
- CPU、UART、GPU、VGA、Keyboard 必須維持模組責任分離。
- 第一版以能驗證、能解釋、能擴充為優先，不以效能或功能數量為優先。

