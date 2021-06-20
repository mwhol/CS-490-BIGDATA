/**
 * Created by Mayanka on 03-Sep-15.
 */
import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class WordCountReducer extends
        Reducer<Text, Text, Text, Text> {

    private String stringone = new String();
    private String stringtwo = new String();
    private String letter = new String();
    private String InterValue = new String();
    private Text FinalValue = new Text();

    public void reduce(Text text, Iterable<Text> values, Context context)
            throws IOException, InterruptedException {

            InterValue = "";
            stringone = values.iterator().next().toString();
            stringtwo = values.iterator().next().toString();

            for (int i = 0; i < stringone.length(); i++) {
                letter = String.valueOf(stringone.charAt(i));
                if (stringtwo.indexOf(letter) != -1) {
                    InterValue += String.valueOf(stringone.charAt(i));
                }
            }
            Text FinalValue = new Text(InterValue);
            context.write(text, FinalValue);
    }
}