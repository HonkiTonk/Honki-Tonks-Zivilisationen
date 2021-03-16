pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleStädteMitNullWert is
   begin
      
      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition = KoordinatenExtern then
            return StadtNummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition = KoordinatenExtern then
               return (RasseIntern, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if RasseExtern = RasseIntern then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition = KoordinatenExtern then
               return (RasseIntern, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
   
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;

end StadtSuchen;
