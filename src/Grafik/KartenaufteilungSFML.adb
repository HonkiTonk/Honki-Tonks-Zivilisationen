pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;

with StadtkarteSFML;
with CursorPlatzierenSFML;
with CursorAltPlatzieren;
with WeltkarteSFML;
with Fehler;
with KarteInformationenSFML;
with StadtInformationenSFML;

package body KartenaufteilungSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            Fehler.GrafikFehler (FehlermeldungExtern => "KartenaufteilungSFML.Weltkarte - Keine Rasse festgelegt.");
            
         when others =>
            CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
            CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
            WeltkarteSFML.Weltkarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            KarteInformationenSFML.KarteInformationenSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
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
         Fehler.GrafikFehler (FehlermeldungExtern => "KartenaufteilungSFML.Weltkarte - Keine Rasse festgelegt.");
                  
      else
         CursorPlatzierenSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
      
         StadtkarteSFML.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
         StadtInformationenSFML.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end if;
      
   end Stadtkarte;

end KartenaufteilungSFML;
