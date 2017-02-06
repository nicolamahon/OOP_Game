class Scores
{
  // global variables
   String name;
   int topscore;
   
   // constructor
   Scores(String line)
   {
     String[] fields = line.split(",");
     name = fields[0];
     topscore = Integer.parseInt(fields[1]);
   }
   
   // constructor
   Scores(TableRow row)
   {
     name = row.getString(0);
     topscore = row.getInt(1);
   }
   
   // for printing during testing
   String toString()
   {
    return name + "\t" + topscore;
   }
}