import os

os.environ["SPARK_HOME"] = "/home/mjw3/Downloads/spark-2.3.1-bin-hadoop2.7"

from operator import add
from pyspark import SparkContext

if __name__ == "__main__":

    sc = SparkContext.getOrCreate()
    lines = sc.textFile("/home/mjw3/PycharmProjects/icp1/input", 1)
    counts = lines.flatMap(lambda x: x.split(' ')) \
        .map(lambda x: (x, 1)) \
        .reduceByKey(add)

    print(counts.collect())

    text = counts.map(lambda x: ("h", 1) if "h" in x[0] else(0, 0)).reduceByKey(add)
    print(text.collect())

    text.saveAsTextFile("output2")
    sc.stop()