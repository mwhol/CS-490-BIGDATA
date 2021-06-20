My matrix multiplication was finished last week. The merge sort code is pretty simple, here's the meat of it:

    numbers = sc.textFile("/home/mjw3/PycharmProjects/MergeSort/input", 1).flatMap(lambda x: x.split(" ")).map(lambda x: (int(x), int(x)))
    numbers = numbers.sortByKey().keys()

Basically we're just able to use default sorting to automagically mergesort. My code is located [here.](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%209/MergeSort/mergesort.py)

Here are two screenshots of me running it.

![](https://github.com/mwhol/CS-490/raw/master/ICP/ICP%209/9.2.png)

![](https://github.com/mwhol/CS-490/raw/master/ICP/ICP%209/9.1.png)