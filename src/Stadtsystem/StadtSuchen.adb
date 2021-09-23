pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseStadtGebaut;
  
with Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         else
            return StadtNummerSchleifenwert;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                              KoordinatenExtern => KoordinatenExtern);
               
               if
                 StadtNummer = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                  
               else
                  return (RasseSchleifenwert, StadtNummer);
               end if;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                           KoordinatenExtern => KoordinatenExtern);
               
            case
              StadtNummer
            is
               when GlobaleKonstanten.LeerEinheitStadtNummer =>
                  null;
                  
               when others =>
                  return (RasseSchleifenwert, StadtNummer);
            end case;
         end if;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   

   
   function StadtNachNamenSuchen
     return GlobaleRecords.RassePlatznummerRecord
   is begin
      
      StadtName := Eingabe.StadtName;
      
      RasseSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  if
                    LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtName
                  then
                     return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                  else
                     null;
                  end if;
            
               end loop StadtSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end StadtNachNamenSuchen;

end StadtSuchen;
