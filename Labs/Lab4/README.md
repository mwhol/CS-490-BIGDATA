### CS5542 Big Data Apps and Analytics
### LAB ASSIGNMENT #4
### Lab Submission Before July/26/2018

## Part 1

# Spark Classification Task

We used Absenteeism at Work Dataset

This is the link for the Dataset:
https://archive.ics.uci.edu/ml/datasets/Absenteeism+at+work

## PART A

Use the following Classification Algorithms: Naïve Bayes, Decision Tree and Random Forest for the same attribute classification

This is the imports we used for each Classification algorithms:

Naïve Bayes imports: 
```

from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import NaiveBayes
from pyspark.sql import SparkSession
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
```
Decisions imports:
```
from pyspark.sql import SparkSession
from pyspark.ml import Pipeline
from pyspark.ml.classification import DecisionTreeClassifier
from pyspark.ml.feature import StringIndexer, VectorIndexer, VectorAssembler
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

```
Random Forest:
```
from pyspark.sql import SparkSession
from pyspark.ml import Pipeline
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.feature import IndexToString, StringIndexer, VectorIndexer, VectorAssembler
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
```
We use same code to load and parse the data file, converting it to a DataFrame.
```
spark = SparkSession.builder.appName("Lab 4").getOrCreate()
data = spark.read.load(path="Absenteeism_at_work.csv", format="csv", header=True, delimiter=';', schema="""
`ID` INT,
`Reason for absence` INT,
`Month of absence` INT,
`Day of the week` INT,
`Seasons` INT,
`Transportation expense` INT,
`Distance from Residence to Work` INT,
`Service time` INT,
`Age` INT,
`Work load Average/day` FLOAT,
`Hit target` INT,
`Disciplinary failure` INT,
`Education` INT,
`Son` INT,
`Social drinker` INT,
`Social smoker` INT,
`Pet` INT,
`Weight` INT,
`Height` INT,
`Body mass index` INT,
`Absenteeism time in hours` INT
""")
```
We also use same assembler for each Classification algorithms:
```
assembler = VectorAssembler(inputCols=[
    # "Reason for absence",
    "Month of absence",
    "Day of the week",
    # "Seasons",
    "Transportation expense",
    "Distance from Residence to Work",
    "Service time",
    "Age",
    "Work load Average/day",
    "Hit target",
    "Disciplinary failure",
    "Education",
    "Son",
    "Social drinker",
    "Social smoker",
    "Pet",
    "Weight",
    "Height",
    "Body mass index",
    "Absenteeism time in hours"
],outputCol="features")
```
After this point each classification algorithms has different code:
NaïveBayes Algorithm:
We used Seasons as the Indexed, make out Seasons are Column 
```
data = data.withColumn("IndexedSeasons", data['Seasons'] - 1)
```
Split the Data into train and test: 
```
splits = data.randomSplit([0.6, 0.4])
train = assembler.transform(splits[0])
test = assembler.transform(splits[1])
```



This is code to see the results from the train: 
```
train.select("IndexedSeasons", "features").show(truncate=False)
```
This is the result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/1.png)
 
This is code to see the results from the test 
```
test.select("IndexedSeasons", "features").show(truncate=False)
```
This is the result: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/2.png)

Create the trainer and set its parameters 
```
nb = NaiveBayes(labelCol='IndexedSeasons')
```
Train the models: 
```
model = nb.fit(train)
```
Select example rows to display 
```
predictions = model.transform(test)
predictions.select('IndexedSeasons', 'features', 'rawPrediction', 'prediction').show(200)
```
This is the result: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/3.png)

Then we compute accuracy on the test set:
```
evaluator = MulticlassClassificationEvaluator(labelCol="IndexedSeasons", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print("Test set accuracy = " + str(accuracy))
print("Error = %g " % (1.0 - accuracy))
```

This is the result: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/4.png)

Decision Tree
Use the assembler on the data
```
data = assembler.transform(data)
```
Then we index label, adding metadata to the label column and then fit on whole dataset to include all label in index.
```
labelIndexer = StringIndexer(inputCol="Seasons", outputCol="indexedLabel").fit(data)
```
Then we automatically identify categorical features, and index them, and also we specify max Categories so features with 28 distinct values are treated as continuous 
```
featureIndexer =\
    VectorIndexer(inputCol="features", outputCol="indexedFeatures", maxCategories=28).fit(data)
```
Then we train a DecisionTree model:
```
dt = DecisionTreeClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures")
```
Chain indexers and tree in a Pipeline
```
pipeline = Pipeline(stages=[labelIndexer, featureIndexer, dt])
```
then we train model so we can run the indexer.
```
model = pipeline.fit(data)
```
This going to make predictions:
```
predictions = model.transform(data)
```
Then we select example rows to display
```
print("All", predictions.count())
badpredictions = predictions.filter("prediction != indexedLabel")
badpredictions.select("prediction", "indexedLabel", "Seasons", "features", "indexedFeatures").show(20)
```
This is the result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/5.png)

We also bring the bad predictions count
```
print("Bad", badpredictions.count())
```
This is the result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/6.png)

This is how we selected and compute test error: 
```
evaluator = MulticlassClassificationEvaluator(labelCol="indexedLabel", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print("Test set accuracy = " + str(accuracy))
print("Error = %g " % (1.0 - accuracy))
treeModel = model.stages[2]
```
This is the result: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/7.png)

This is how we print summary
```
treeModel = model.stages[2]
# summary only
print(treeModel)
```
This is the result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/8.png)
 
Random Forest:
Use the assembler on the data
```
data = assembler.transform(data)
```
Then we index label, adding metadata to the label column and then fit on whole dataset to include all label in index.
```
labelIndexer = StringIndexer(inputCol="Seasons", outputCol="indexedLabel").fit(data)
```
Then we automatically identify categorical features, and index them, and also we specify max Categories so features with > 4 distinct values are treated as continuous 
```
featureIndexer =\
    VectorIndexer(inputCol="features", outputCol="indexedFeatures", maxCategories=4).fit(data)
```
Then we split the data into training and test sets (30% held out for testing)
```
(trainingData, testData) = data.randomSplit([0.7, 0.3])
```
Then we create Random Forest model
```
rf = RandomForestClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures", numTrees=10)
```
Then we convert indexed labels back to original labels. 
```
labelConverter = IndexToString(inputCol="prediction", outputCol="predictedLabel",
                               labels=labelIndexer.labels)
```
Chain indexers and tree in a Pipeline
```
pipeline = Pipeline(stages=[labelIndexer, featureIndexer, rf, labelConverter])
```
Then we train model so we can run the indexer.
```
model = pipeline.fit(trainingData)
```
This going to make predictions:
```
predictions = model.transform(testData)
```
Then we select the example row to display 
```
predictions.select("predictedLabel", "Seasons", "features").show(50)
```
This is the result:

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/9.png)

This is how we selected and compute test error: 
```
evaluator = MulticlassClassificationEvaluator(
    labelCol="indexedLabel", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print("Test set accuracy = " + str(accuracy))
print("Test Error = %g" % (1.0 - accuracy))
```
This is the result: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/10.png)

This is how we print summary
```
treeModel = model.stages[2]
# summary only
print(treeModel)
```
This is the result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/11.png)
 

## Part C

Best algorithm to use for this dataset was Random Forest Classifier we because it got the most accuracy and less attest error then other classifiers, if you look at the top you can see the Random Forest had 10 trees and no notes at all, and when you look at the a DecisionTree Classifier has depth of 5 with 13 nodes. The DecisionTree had more bad predictions and this effect the result. Because the dataset we used is small this two classifier are the best, but if we use the much bigger dataset then NaiveBayes going to have better results because NaïveBayes is best when comes to work with bigger datasets. 

## PART 2 

# Spark Streaming Task

Perform Word - Count on Twitter Streaming Data using Spark.

This is the import we used for the running our twitter
```
from tweepy import OAuthHandler
from tweepy import Stream
from tweepy.streaming import StreamListener
import socket
```
We have to import to use API keys to use twitter API:
```
consumer_key = "Put your key "
consumer_secret = "Put your key "
access_token = "Put your key”
access_secret = "Put your key
```
Then we create a socket object
```
s = socket.socket()
```
Then we create the host and port for using the twitter because we need host name and port to use the streaming.
```
host = "localhost" 
port = 9999  
s.bind((host, port)) 
```
Then we create the twitter listeners 
```
class TweetsListener(StreamListener):
    def __init__(self, csocket):
        self.client_socket = csocket

    def on_data(self, data):
        try:
            print(data.split('\n'))
            data = data.encode('utf-8')
            self.client_socket.send(data)
            return True
        except BaseException as e:
            print("Error on_data: %s" % str(e))
        return True

    def on_error(self, status):
        print(status)
        return True
```
We filtering the anything to do with “Trump” twitters
```
def sendData(c_socket):
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_secret)

    twitter_stream = Stream(auth, TweetsListener(c_socket))
    twitter_stream.filter(track=['trump'])
```
We establish the connection with client
```
print("Listening on port: %s" % str(port))
s.listen(5) 
c, addr = s.accept
print("Received request from: " + str(addr))
sendData(c)
```
Then we run the listener:
```
if __name__ == "__main__":
```
This is the result:

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/12.png)

We use Twitter Speaker code that created by Laurent Weichberger, from Hortonworks, we build our code top of Laurent Twitter Speaker code. 
```
 import json
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
def filter_tweets(tweet):
    json_tweet = json.loads(tweet)
    if "text" in json_tweet:
        words = json_tweet["text"].split(" ")
        return words
    else:
        return []
sc = SparkContext("local[2]", "Twitter Demo")
sc.setLogLevel("ERROR")
ssc = StreamingContext(sc, 3)  # 10 is the batch interval in seconds
```
We made sure that it hit right IP and Port 
```
sc = SparkContext("local[2]", "Twitter Demo")
sc.setLogLevel("ERROR")
ssc = StreamingContext(sc, 3)  # 10 is the batch interval in seconds
IP = "localhost"
Port = 9999
lines = ssc.socketTextStream(IP, Port)
```
This is our code do world count on the twitter 
```
# Count each word in each batch
words = lines.flatMap(filter_tweets)
pairs = words.map(lambda word: (word, 1))
wordCounts = pairs.reduceByKey(lambda x, y: x + y)
```
Then we made sure it going to print the results
``` 
wordCounts.pprint(num=30)
```
Then we the computation 
```
ssc.start()             # Start the computation
```
Then we made sure if we done with computation it terminated 
```
ssc.awaitTermination()  # Wait for the computation to terminate
```

Then we run the Speaker and this is our Result:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab4LastLab/pictures/13.png)
 

