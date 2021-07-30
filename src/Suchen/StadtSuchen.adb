pragma SPARK_Mode (On);

with GlobaleKonstanten, Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).Position = KoordinatenExtern
         then
            return StadtNummerSchleifenwert;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.LeerEinheitStadtNummer;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
            
                  if
                    GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Position = KoordinatenExtern
                  then
                     return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                  else
                     null;
                  end if;
            
               end loop StadtSchleife;
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
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            StadtSchleife:
            for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop

               if
                 GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Position = KoordinatenExtern
               then
                  return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
               else
                  null;
               end if;
            
            end loop StadtSchleife;
         end if;
         
      end loop RasseSchleife;
   
      return (GlobaleDatentypen.Rassen_Enum'First, GlobaleKonstanten.LeerEinheitStadtNummer);
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   
   
   
   function AnzahlStädteErmitteln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      AnzahlStädte := 0;
      
      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            AnzahlStädte := AnzahlStädte + 1;
            
         else
            null;
         end if;
         
      end loop StädteSchleife;
         
      return AnzahlStädte;
      
   end AnzahlStädteErmitteln;
   
   
   
   function StadtNachNamenSuchen
     return GlobaleRecords.RassePlatznummerRecord
   is begin
      
      StadtName := Eingabe.StadtName;
      
      RasseSchleife:
      for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                           
                  if
                    GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).Name = StadtName
                    and
                      GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
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
