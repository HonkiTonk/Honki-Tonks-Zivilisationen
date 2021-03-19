pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleEinheitenMitNullWert is
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).AchsenPosition = KoordinatenExtern then
            return EinheitNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         EinheitSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AchsenPosition = KoordinatenExtern then
               return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenEinheitOhneRasseSuchen;



   function KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen loop
         EinheitSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

            if RasseExtern = RasseSchleifenwert then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).AchsenPosition = KoordinatenExtern then
               return (RasseSchleifenwert, EinheitNummerSchleifenwert);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;

end EinheitSuchen;
