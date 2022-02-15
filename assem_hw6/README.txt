409410048 資工二 王凱右 hw6

1:程式內容：   

此次程式包含兩個部分，第一個檔案 hw6_test.s 為呼叫排序函式，並將排序結果輸出至 sort_result.txt。第二個檔案 numsort.s 則是存放執行排序的 function。
兩個檔案編譯為 hw6.exe ，由於此次使用 APCS 規範，所以傳參數的第一值即放入 r0 第二值 即放入 r1，回傳值統一傳回 r0。
參數給予後程式呼叫 NumSort 跳轉至 NumSort function，排序完成後回到 利用 hw6_test.s ,再利用 Software Interrupt 執行 File I/O 之動作輸出排序完之檔案。

2:如何編譯程式:

先把程式內容打好之後，以"make"指令編譯程式。
詳細指令請參考同壓縮檔中之makefile之內容。
執行"make"指令，就能完成程式的編譯。

3:程式的執行環境、

此程式的主要執行環境是Window10 ubuntu 20.04 WSL，
使用insight的ARM simulator進行程式的執行。
 
4:如何執行程式

此程式中，我是使用insight的ARM simulator進行程式的執行。
在此作業中我將指令加入 makefile 中，以 "make gbd"進行程式的執行。
詳細指令請參考附檔之 makefile

在insight中設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw6.exe。
就可以利用insight去做本程式的模擬執行與除錯。


