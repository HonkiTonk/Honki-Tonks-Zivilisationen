pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtkarteGrafik;
with CursorplatzierungGrafik;
with CursorplatzierungAltGrafik;
with WeltkarteGrafik;
with SeitenleisteGrafik;
-- with StadtseitenleisteGrafik;
with StadtumgebungGrafik;

package body KartenaufteilungGrafik is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      CursorplatzierungGrafik.Weltkarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      CursorplatzierungAltGrafik.CursorplatzierungAlt (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
      WeltkarteGrafik.Weltkarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      SeitenleisteGrafik.SeitenleisteGrafik (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      CursorplatzierungGrafik.Stadtkarte (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      StadtkarteGrafik.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungGrafik.Stadtumgebung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      -- Nach einer Überarbeitung wieder einbauen. äöü
      -- Wenn es später überhaupt noch gebraucht wird. äöü
      -- StadtseitenleisteGrafik.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Stadtkarte;

end KartenaufteilungGrafik;
