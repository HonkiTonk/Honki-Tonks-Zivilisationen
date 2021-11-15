pragma SPARK_Mode (On);

with Sf.System.Vector2;

package BerechnungenKarteSFML is
   
   FensterKarte : Sf.System.Vector2.sfVector2f;
   StadtKarte : Sf.System.Vector2.sfVector2f;
   
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtfelderAbmessungBerechnen;
   
private
   
   AusschnittKarte : constant Float := 0.80;
   AusschnittStadtKarte : constant Float := 0.80;

end BerechnungenKarteSFML;
