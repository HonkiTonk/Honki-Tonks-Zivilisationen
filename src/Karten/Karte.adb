pragma SPARK_Mode (On);

with KarteSFML;
with KarteKonsole;
with BewegungCursorSFML;
with CursorPositionAltFestlegen;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      BewegungCursorSFML.CursorPlatzierenKarteSFML (RasseExtern => RasseExtern);
      CursorPositionAltFestlegen.CursorPositionAltFestlegen (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML =>
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
