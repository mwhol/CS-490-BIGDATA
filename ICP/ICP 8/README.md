## Part One

For the first half of the ICP I did a spark program which counts the number of words with an "H" in them (not the total number of H's.) The line that's doing most of the work here is:

    text = counts.map(lambda x: ("h", 1) if "h" in x[0] else(0, 0)).reduceByKey(add)

[Here's the code](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%208/icp1/run.py)

![](https://github.com/mwhol/CS-490/raw/master/ICP/ICP%208/8.1.png)

## Matrix Multiplication

[Here is the code.](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%208/matrix/matrixmult.py) It's almost a one-for-one translation of the previous java code I wrote for this same problem earlier. The basic idea is that we translate each value to the position in the final matrix that it belongs in along with its place in the addition. Then we multiply matching values, adjust the keys and add. At the end of this code I run _coalesce_ in order to bring everything back to one output page.

![](https://github.com/mwhol/CS-490/raw/master/ICP/ICP%208/8.2.png)