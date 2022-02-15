作業 7

409410048 資工二 王凱右

1: 描述你程式的內容
 此次程式包含兩個部分，第一個檔案 hw7.c 為無 SIMD 指令進行矩陣運算，第二個檔案 hw7simd.c 則利用 SIMD 指令進行矩陣運算，各編譯為 hw7.exe 及 hw7simd.exe。
 兩個程式都使用檔案中 RandomGeter 產生的 data.txt 為資料的來源，測資的浮點數皆只產生至小數點後三位，最後將結果分別輸出到 output.txt 與 outputSIMD.txt	

2: 執行環境
 CPU型號: Intel(R) Core(TM) i7-9750H @ 2.60Ghz
 記憶體: 16GB
 作業系統: Window11
 此程式的主要執行環境是在 ubuntu 20.04 WSL 上進行程式的編譯與執行。
 gcc 版本為 9.3.0

3: Non-SIMD version: read data、computation、write data的執行時間 
 readTime: 0.012521s
 computationTime: 0.017775s
 writeTime: 0.000149s

4: SIMD version: read data、computation、write data的執行時間
 readTime: 0.012401s
 computationTime: 0.004131s
 writeTime: 0.000149s

5: 效率比較
 在讀檔案與寫檔案方面，兩個程式都是使用fscanf與fprintf，因此相差不大。
 但是在計算方面，SIMD的效率比無SIMD快上4.25倍左右。

6: 如何編譯程式 (編譯時所下的參數)
 具體指令請參考makefile 
 編譯時使用了參數: -mavx為了使用AVX指令 -lrt用來計算時間 -o用來命名.exe檔案

7: 如何執行你的程式
 以./hw7.exe 與 ./hw7simd.exe 指令在 ubuntu 上執行。

8: 使用了哪些指令:
 AVX的_mm256_mul_ps與_mm256_add_ps，分別負責8個浮點數的乘法與加法。

