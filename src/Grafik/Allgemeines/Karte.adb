pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with OptionenVariablen;

with KarteSFML;
with KarteKonsole;
with CursorPlatzierenSFML;
with CursorAltPlatzieren;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- CursorAltPlatzieren braucht aktuelle Cursor Koordinaten. Kann man aber bestimmt trotzdem optimieren.
      CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => RasseExtern);
      CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => RasseExtern);
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            KarteSFML.KarteAnzeigen (RasseExtern => RasseExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
