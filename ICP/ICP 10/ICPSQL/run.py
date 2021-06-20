from pyspark.sql import SparkSession
from pyspark import SparkContext

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()

# import pyspark class Row from module sql
from pyspark.sql import *
from pyspark.sql import functions

#1
df = spark.read.format("csv").option("header", "true").load("/home/mjw3/PycharmProjects/ICPSQL/ConsumerComplaints.csv")
df.show()

#2
df.write.json("/home/mjw3/PycharmProjects/ICPSQL/ConsumerComplaints.json")

#3
print("Repeated Records:\n")
print(df.count() - df.distinct().count())

#4
Complaint = Row("Date Received","Product Name","Sub Product","Issue","Sub Issue","Consumer Complaint Narrative","Company Public Response","Company","State Name","Zip Code","Tags","Consumer Consent Provided","Submitted via,Date Sent to Company","Company Response to Consumer","Timely Response","Consumer Disputed","Complaint ID")
newComplaint = Row("2013-07-29","Debt collection","Credit card","Communication tactics","Frequent or repeated calls","","","Asset Management Professionals, LLC","PA",19145,"Older American","N/A","Phone","2013-08-01","Closed with explanation","No","",468904)

df2 = spark.createDataFrame([newComplaint])

newdf = df.union(df2)
newdf.show()

#5
df3 = df.groupBy("Zip Code").count()
df3.show()


###########################
# Part Two
###########################


#6
df2 = df.select("Date Received", "Product Name", "Sub Product", "Zip Code", "Complaint ID")
df3 = df.select("Complaint ID", "Submitted via", "Tags", "State Name")
joinedDF = df2.join(df3, df2["Complaint ID"] == df3["Complaint ID"])
joinedDF.show()

df.agg(functions.avg("Complaint ID")).show()

#7
print("Repeated Records:\n")
print(df.count() - df.distinct().count())

#8
trow = df2.take(13)[-1]
thirteenDF = spark.createDataFrame([trow])
thirteenDF.show()