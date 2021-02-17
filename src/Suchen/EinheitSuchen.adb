pragma SPARK_Mode (On);

with GlobaleVariablen;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Natural is
   begin
      
      EinheitSchleife:
      for Einheitennummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).AchsenPosition = Koordinaten then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return RückgabeWertEinheitNummer;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenEinheitOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = Koordinaten then
               return (RasseIntern, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWertEinheitNummer);
      
   end KoordinatenEinheitOhneRasseSuchen;



   function KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

            if RasseExtern = RasseIntern then
               exit EinheitSchleife;
                  
            else
               if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
                  exit EinheitSchleife;
               
               elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = Koordinaten then
                  return (RasseIntern, EinheitNummer);
               
               else
                  null;
               end if;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWertEinheitNummer);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;

end EinheitSuchen;
