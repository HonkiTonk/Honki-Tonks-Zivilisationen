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
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- CursorAltPlatzieren braucht aktuelle Cursor Koordinaten. Kann man aber bestimmt trotzdem optimieren.
      CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => RasseEinheitExtern.Rasse);
      CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => RasseEinheitExtern.Rasse);
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            KarteKonsole.AnzeigeKarteKonsole (RasseExtern => RasseEinheitExtern.Rasse);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            KarteSFML.KarteAnzeigen (RasseEinheitExtern => RasseEinheitExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
