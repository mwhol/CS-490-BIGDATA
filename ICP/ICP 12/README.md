Here is my code:

[Part 1](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/spark-streaming/streaming.py)

[Part 2](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/ICP12/run.py)

[Bonus](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/ICP12/bonus.py)

Part 1 is self-explanatory.

In Part 2 the key lines are these two:

    pairs = words.map(lambda word: (word, 1))
    wordCounts = pairs.reduceByKey(lambda x, y: x + y)

In the bonus, the key lines are these two:

    pairs = words.map(lambda word: (len(word), set([word.lower()])))
    wordCounts = pairs.reduceByKey(lambda x, y: x.union(y))

which serve to lowercase the words and make our word lists unique (by turning them into a set).

Here are the pictures of the code running:

# Part 1

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.1.1.png?raw=true)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.1.2.png?raw=true)

# Part 2

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.2.1.png?raw=true)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.2.2.png?raw=true)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.2.3.png?raw=true)

# Bonus

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2012/12.3.1.png?raw=true)