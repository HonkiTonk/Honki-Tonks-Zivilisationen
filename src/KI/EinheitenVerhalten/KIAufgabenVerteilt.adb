pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseEinheitenGebaut;

package body KIAufgabenVerteilt is

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
   is begin
      
      GleicheAufgabe := 0;
     
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze loop
            
         if
           EinheitNummerSchleifenwert = EinheitRasseNummerExtern.Platznummer
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheit.ID
         then
            null;
               
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = AufgabeExtern
         then
            GleicheAufgabe := GleicheAufgabe + 1;
               
         else
            null;
         end if;
            
      end loop EinheitSchleife;
      
      return GleicheAufgabe;
      
   end AufgabenVerteilt;
   
   
   
   -- Gibt es bereits eine Einheit die diese Aufgabe auf diesem Ziel ausführen will?
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = AufgabeExtern
           and
             LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitAufgabeZiel;
   
   
   
   -- Gibt es bereits eine Einheit mit diesem Ziel?
   function EinheitZiel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitZiel;

end KIAufgabenVerteilt;
