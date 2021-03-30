pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleStädteMitNullWert is
   begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).AchsenPosition = KoordinatenExtern
         then
            return StadtNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).AchsenPosition = KoordinatenExtern
            then
               return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
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
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         StadtSchleife:
         for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

            if
              RasseExtern = RasseSchleifenwert
            then
               exit StadtSchleife;
               
            elsif
              GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).AchsenPosition = KoordinatenExtern
            then
               return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
   
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;

end StadtSuchen;
