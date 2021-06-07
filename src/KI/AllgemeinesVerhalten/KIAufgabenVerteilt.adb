pragma SPARK_Mode (On);

package body KIAufgabenVerteilt is

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
   is begin
      
      GleicheAufgabe := 0;
     
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
         if
           EinheitNummerSchleifenwert = EinheitRasseNummerExtern.Platznummer
           or
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).ID = 0
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
      RasseExtern : in GlobaleDatentypen.Rassen;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
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

end KIAufgabenVerteilt;
