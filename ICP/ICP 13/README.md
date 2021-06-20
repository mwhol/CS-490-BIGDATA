All is done using the absentee at work dataset from the lab.

### Naive Bayes

[Here's the code](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/ICP13/naiveBayes.py)

Here's the meat of it:

    nb = NaiveBayes(labelCol='IndexedSeasons')
    model = nb.fit(train)
    
    predictions = model.transform(test)
    predictions.select('IndexedSeasons', 'features', 'rawPrediction', 'prediction').show(20)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/13.1.1.png?raw=true)

### Decision Trees

[Here's the code](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/ICP13/decisionTree.py)

Here's the meat of it:

    dt = DecisionTreeClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures")
    pipeline = Pipeline(stages=[labelIndexer, featureIndexer, dt])
    model = pipeline.fit(data)
    predictions = model.transform(data)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/13.1.2.png?raw=true)

### Random Forest

[Here's the code](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/ICP13/randomForest.py)

Here's the meat of it:

    rf = RandomForestClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures", numTrees=10)
    labelConverter = IndexToString(inputCol="prediction", outputCol="predictedLabel",
                                   labels=labelIndexer.labels)
    pipeline = Pipeline(stages=[labelIndexer, featureIndexer, rf, labelConverter])
    model = pipeline.fit(trainingData)
    predictions = model.transform(testData)

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%2013/13.1.3.png?raw=true)