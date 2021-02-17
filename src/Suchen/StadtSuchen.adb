pragma SPARK_Mode (On);

with GlobaleVariablen;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Natural is
   begin
      
      StadtSchleife:
      for Stadtnummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AchsenPosition = Koordinaten then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return RückgabeWertStadtNummer;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition = Koordinaten then
               return (RasseIntern, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWertStadtNummer);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if RasseExtern = RasseIntern then
               exit StadtSchleife;
                  
            else            
               if GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
                  exit StadtSchleife;
               
               elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition = Koordinaten then
                  return (RasseIntern, Stadtnummer);
               
               else
                  null;
               end if;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWertStadtNummer);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;

end StadtSuchen;
