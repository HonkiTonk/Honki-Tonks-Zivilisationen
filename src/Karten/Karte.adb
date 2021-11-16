pragma SPARK_Mode (On);

with KarteInformationenKonsole;
with KarteSFML;
with KarteKonsole;
with CursorPositionAltFestlegen;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      CursorPositionAltFestlegen.CursorPositionAltFestlegen (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            KarteInformationenKonsole.KarteInformationenKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.Beides =>
            -- KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            -- KarteInformationenKonsole.KarteInformationenKonsole (RasseExtern => RasseExtern);
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML =>
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
