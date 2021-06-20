UPDATED

You can see my code [here](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%202/OddCount/src/com/wordcount/WordCount.java) and my video [here.](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%202/out-5.ogv?raw=true)

Here is how my code functions: It reads in each line of the input and mapper takes each token one at a time, it performs modulus two on each number and if we get 0, we output the key, value pair like this ("Even", 1), similarly with a remainder of 1 we output ("Odd", 1). At this point the reducer is the same as the basic WordCount example, we just iterate through each key and sum their values, this gives us an output that reads:

    Even: 1
    Odd: 1

Here are two screenshots:

![](https://raw.githubusercontent.com/mwhol/CS-490/master/ICP/ICP%202/Screenshot%20from%202018-06-21%2007-00-18.png)

![](https://raw.githubusercontent.com/mwhol/CS-490/master/ICP/ICP%202/Screenshot%20from%202018-06-21%2007-00-23.png)