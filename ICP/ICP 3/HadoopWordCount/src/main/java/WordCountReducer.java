/**
 * Created by Mayanka on 03-Sep-15.
 */
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WordCountReducer extends
        Reducer<Text, IntWritable, Text, IntWritable> {

    private String word = new String();

    public void reduce(Text text, Iterable<IntWritable> values, Context context)
            throws IOException, InterruptedException {
        int sum = 1;
        for (IntWritable value : values) {
            sum *= value.get();
            word = text.toString();
            word = word.substring(0, 3);
            text = new Text(word);
        }
        context.write(text, new IntWritable(sum));
    }
}