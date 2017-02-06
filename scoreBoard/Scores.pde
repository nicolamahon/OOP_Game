class Scores
{
   String name;
   int topscore;
   
   Scores(String line)
   {
     String[] fields = line.split(",");
     name = fields[0];
     topscore = Integer.parseInt(fields[1]);
   }
   
   Scores(TableRow row)
   {
     name = row.getString(0);
     topscore = row.getInt(1);
   }
   
   String toString()
   {
    return name + "\t" + topscore;
   }
}