## Part One

[Here is the code](https://github.com/mwhol/CS-490/blob/master/Labs/Lab2/Part1.hql) and [here is the video](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/L2.1.ogv) of some sample queries. We build several databases, the tricky parts are when we translate the array true-false table into a column in the main table which is an array with all the powers with a "True" value listed. Here is the relevant portion of the code.

    CREATE TABLE powers as SELECT hero_names, 
    SPLIT(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(concat_ws(' ',
    if(Agility == 'True', 'Agility', ''),
    if(AcceleratedHealing == 'True', 'AcceleratedHealing', ''),
    
    ...
    
    if(Omniscient == 'True', 'Omniscient', '')), 
    '^\\s+', ''),
    '\\s+$', ''),
    '\\s+', ' '), 
    ' ') as powerarray
    FROM heropowers;

We also create a map of all the physical characteristics and run some queries. For example this query:

    SELECT race, count(race) AS cnt, collect_set(name) FROM superheroes GROUP BY race HAVING cnt=1;

Prints out all the heroes who are the only one of their race. Here's some sample pictures:

![](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/l2.1.1.png)

![](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/l2.1.2.png)

#

## Part Two

We created a database. For my data I used the google job skills dataset from Part One. [Here is the code](https://github.com/mwhol/CS-490/blob/master/Labs/Lab2/Part2) and [here is a video](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/L2.2.ogv) of me running it. First we create the configuration which requires us to add some fields to the _schema.xml_ file, luckily they are all _text_general_.

Here's a couple of sample searches:

    Minimum\ Qualifications:"python"^4 AND Minimum\ Qualifications:"experience"

#

    Category:Data and _query_:"{!dismax qf=Responsibilities}dialogue analysis natural language optimization"

Here's some sample outputs: [One](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab2/1.json), [Two](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab2/4.json), [Three](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab2/8.xml)


![](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/l2.2.1.png)

![](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/L2.2.2.png)

![](https://github.com/mwhol/CS-490/raw/master/Labs/Lab2/L2.2.3.png)