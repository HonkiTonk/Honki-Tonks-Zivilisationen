pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with GrafikDatentypen;
with OptionenVariablen;
with ZeitKonstanten;
with StadtKonstanten;

with KarteStadtTerminal;
with KarteStadtSFML;
with CursorPlatzierenSFML;

package body KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        StadtRasseNummerExtern.Rasse = RassenDatentypen.Keine_Rasse_Enum
        or
          StadtRasseNummerExtern.Nummer = StadtKonstanten.LeerNummer
      then
         delay ZeitKonstanten.WartezeitGrafik;
         return;
                  
      else
         CursorPlatzierenSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
      end if;
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            KarteStadtTerminal.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            KarteStadtSFML.AnzeigeStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end AnzeigeStadt;

end KarteStadt;
