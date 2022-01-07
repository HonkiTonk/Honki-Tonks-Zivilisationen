pragma SPARK_Mode (On);

package GrafikStartEnde is
   
   procedure FensterEntfernen;
   procedure FensterErzeugen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
     
   -- Das hier so lassen oder durch die erste Zeile der Textdatei - Hauptmenü ersetzen?
   Name : constant Wide_Wide_String := "Name des Spiels";

end GrafikStartEnde;
