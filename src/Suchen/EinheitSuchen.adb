pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleEinheitenMitNullWert is
   begin
      
      EinheitSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition = KoordinatenExtern then
            return EinheitNummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch;
      
   end KoordinatenEinheitMitRasseSuchen;



   function KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleDatentypen.Rassen loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = KoordinatenExtern then
               return (RasseIntern, EinheitNummer);
               
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
      for RasseIntern in GlobaleDatentypen.Rassen loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

            if RasseExtern = RasseIntern then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = KoordinatenExtern then
               return (RasseIntern, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch);
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;

end EinheitSuchen;
