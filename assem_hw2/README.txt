409410048 資工二 王凱右

Q1:描述你程式的內容:

A1:此程式hw2.exe的目標是計算出 2*r1+4*r2+8*r3的值後放置於r0。
以我測試的範例 r1 = 1, r2 = 2, r3 = 3來說，最後放置於r0的值就會是 2*1+4*2+3*8=34。

Q2:如何編譯程式:

A2:先把程式內容打好之後，以gcc編譯器編譯程式，
編譯時加上"-g"參數，會讓程式在編譯完之後產生GBD可以辨識的除錯碼，提供給我們更多的除錯訊息，
在此作業中，我使用以下指令對程式進行編譯:
~/assembly/arm-tool-20.4/bin/arm-none-eabi-gcc -g hw2.s -o hw2.exe

Q3:程式的執行環境、

A3:此程式的主要執行環境是Window10 ubuntu 20.04 WSL，
使用insight的ARM simulator進行程式的執行。
 
Q4:如何執行你的程式

A4:此程式中，我是使用insight的ARM simulator進行程式的執行。
在安裝好X server之後，用以下指令執行insight
~/assembly/arm-tool-20.4/bin/arm-none-eabi-insight
然後設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw2.exe。
就可以利用insight去做本程式的模擬執行與除錯。