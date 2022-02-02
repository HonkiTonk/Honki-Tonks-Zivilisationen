pragma SPARK_Mode (On);

package GrafikStartEndeSFML is
   
   procedure FensterErzeugen;
   procedure FensterEntfernen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
     
   -- Das hier so lassen oder durch die erste Zeile der Textdatei - Hauptmenü ersetzen?
   -- Oder durch eine andere Textzeile ersetzen? Wobei sich der Spielenamen ja nicht ändert.
   Name : constant Wide_Wide_String := "Name des Spiels";
   
   procedure FensterErzeugenErweitert;

end GrafikStartEndeSFML;
