[The Code](https://github.com/mwhol/CS-490/tree/master/ICP/ICP%203/HadoopWordCount/src/main/java)

Our output (using input2): ![](https://raw.githubusercontent.com/mwhol/CS-490/master/ICP/ICP%203/Screenshot%20from%202018-06-16%2016-56-22.png)

[Here is the video of me running the code.](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%203/ICP%203.ogv?raw=true)

Basically we use two mappers and reducers, first we group the values by row and column and multiplication place, then our first reducer does the multiplication and groups by just row and column. This goes to the second mapper and the second reducer does the addition then outputs the values.


Running code:
![](https://raw.githubusercontent.com/mwhol/CS-490/master/ICP/ICP%203/Screenshot%20from%202018-06-16%2016-56-40.png)
