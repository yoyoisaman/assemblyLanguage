409410048 資工二 王凱右 hw5

Q1:程式的內容:

A1:此程式hw5.exe的目標是對一個數字陣列進行由大到小的排序，並且在排序時使用malloc()函式去分配記憶體空間，並在排序完後輸出原始陣列與已排序陣列

Q2:如何編譯程式:

A2:先把程式內容打好之後，以"make"指令編譯程式。
詳細指令請參考同壓縮檔中之makefile之內容。
執行"make"指令，就能完成程式的編譯。

Q3:程式的執行環境、

A3:此程式的主要執行環境是Window10 ubuntu 20.04 WSL，
使用insight的ARM simulator進行程式的執行。
 
Q4:如何執行程式

A4:此程式中，我是使用insight的ARM simulator進行程式的執行。
在此作業中我將指令加入 makefile 中，以 "make gbd"進行程式的執行。
詳細指令請參考附檔之 makefile

在insight中設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw5.exe。
就可以利用insight去做本程式的模擬執行與除錯。
