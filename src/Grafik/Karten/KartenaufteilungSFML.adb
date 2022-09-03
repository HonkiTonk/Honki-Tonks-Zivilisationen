pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtkarteSFML;
with CursorPlatzierenSFML;
with CursorAltPlatzieren;
with WeltkarteSFML;
with KarteInformationenSFML;
-- with StadtInformationenSFML;
with StadtumgebungGrafik;

package body KartenaufteilungSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      CursorPlatzierenSFML.CursorPlatzierenKarteSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
      CursorAltPlatzieren.CursorAltPlatzieren (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
      WeltkarteSFML.Weltkarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      CursorPlatzierenSFML.CursorPlatzierenStadtSFML (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      StadtkarteSFML.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungGrafik.Stadtumgebung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      -- Nach einer Überarbeitung wieder einbauen. äöü
      -- Wenn es später überhaupt noch gebraucht wird. äöü
      -- StadtInformationenSFML.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Stadtkarte;

end KartenaufteilungSFML;
