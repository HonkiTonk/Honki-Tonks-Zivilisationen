pragma SPARK_Mode (On);

with GlobaleKonstanten;

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
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).ID = GlobaleKonstanten.LeerEinheit.ID
         then
            null;
               
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).KIBeschäftigt = AufgabeExtern
         then
            GleicheAufgabe := GleicheAufgabe + 1;
               
         else
            null;
         end if;
            
      end loop EinheitSchleife;
      
      return GleicheAufgabe;
      
   end AufgabenVerteilt;
   
   
   
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).KIBeschäftigt = AufgabeExtern
           and
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).KIZielKoordinaten = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitAufgabeZiel;
   
   
   
   function EinheitZiel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).KIZielKoordinaten = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitZiel;

end KIAufgabenVerteilt;
