pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with OptionenVariablen;
with ZeitKonstanten;

with KarteSFML;
with KarteTerminal;
with CursorPlatzierenSFML;
with CursorAltPlatzieren;

package body Karte is

   procedure AnzeigeKarte
     -- Parameter umbenennen. äöü
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        RasseEinheitExtern.Rasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            return;
            
         when others =>
            -- CursorAltPlatzieren braucht aktuelle Cursor Koordinaten. Kann man aber bestimmt trotzdem optimieren, oder? äöü
            CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => RasseEinheitExtern.Rasse);
            CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => RasseEinheitExtern.Rasse);
      end case;
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            KarteTerminal.AnzeigeKarteTerminal (RasseExtern => RasseEinheitExtern.Rasse);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            KarteSFML.KarteAnzeigen (RasseEinheitExtern => RasseEinheitExtern);
      end case;

   end AnzeigeKarte;
   
end Karte;
