The code is [here.](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2010/ICPSQL/run.py)

Here are some samples:

We figure out how many columns are unique using .count and .distinct.count like so:

    print("Repeated Records:\n")
    print(df.count() - df.distinct().count())

And we find the thirteenth row like so:

    trow = df2.take(13)[-1]
    thirteenDF = spark.createDataFrame([trow])
    thirteenDF.show()

Here are the screenshots.

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2010/10.1.png?raw=true)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2010/10.2.png?raw=true)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2010/10.3.png?raw=true)