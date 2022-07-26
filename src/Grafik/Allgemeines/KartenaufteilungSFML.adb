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
with CursorAltPlatzieren;
with KarteTerminal;
with KarteSFML;

-- Hier muss eventuell auch einiges noch in die NachTasks verschoben bzw. überarbeitet werden. äöü
-- Ist die Cursorplatzierung überhaupt noch wirklich in Logik oder nur noch in Grafik? äöü
package body KartenaufteilungSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            delay ZeitKonstanten.WartezeitGrafik;
            return;
            
         when others =>
            -- CursorAltPlatzieren braucht aktuelle Cursor Koordinaten. Kann man aber bestimmt trotzdem optimieren, oder? äöü
            CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
            CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => EinheitRasseNummerExtern.Rasse);
      end case;
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            KarteTerminal.AnzeigeKarteTerminal (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            KarteSFML.KarteAnzeigen (RasseEinheitExtern => EinheitRasseNummerExtern);
      end case;

   end Weltkarte;
   
   

   procedure Stadtkarte
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
      
   end Stadtkarte;

end KartenaufteilungSFML;
