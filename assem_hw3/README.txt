409410048 資工二 王凱右 hw3

Q1:程式的內容:

A1:此程式hw3.exe的目標是計算出 2x4矩陣 乘 4x2矩陣 後的 2x2矩陣

Q2:編譯程式:

A2:先把程式內容打好之後，以makefile編譯程式。
詳細指令請參考同壓縮檔中之makefile之內容。
打好之後執行make 就能完成程式的編譯。

Q3:程式的執行環境、

A3:此程式的主要執行環境是Window10 ubuntu 20.04 WSL，
使用insight的ARM simulator進行程式的執行。
 
Q4:如何執行程式

A4:此程式中，我是使用insight的ARM simulator進行程式的執行。
在安裝好X server之後，用以下指令執行insight
~/assembly/arm-new/bin/arm-none-eabi-insight
然後設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw3.exe。
就可以利用insight去做本程式的模擬執行與除錯。
