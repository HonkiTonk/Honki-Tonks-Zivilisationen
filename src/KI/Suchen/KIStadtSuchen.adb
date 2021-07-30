pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitSuchen;

package body KIStadtSuchen is

   function NähesteStadtSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      AktuellGefundeneStadt := 0;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).ID = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
           AktuellGefundeneStadt = 0
         then
            AktuellGefundeneStadt := StadtSchleifenwert;
            Entfernung := Positive (abs (AnfangKoordinatenExtern.EAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuellGefundeneStadt).Position.EAchse)
                                    + abs (AnfangKoordinatenExtern.YAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuellGefundeneStadt).Position.YAchse)
                                    + abs (AnfangKoordinatenExtern.XAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuellGefundeneStadt).Position.XAchse));
            
         else
            EntfernungNeu := Positive (abs (AnfangKoordinatenExtern.EAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).Position.EAchse)
                                       + abs (AnfangKoordinatenExtern.YAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).Position.YAchse)
                                       + abs (AnfangKoordinatenExtern.XAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).Position.XAchse));
            if
              Entfernung > EntfernungNeu
            then
               AktuellGefundeneStadt := StadtSchleifenwert;
               
            else
               null;
            end if;
         end if;
            
      end loop StadtSchleife;
         
      case
        AktuellGefundeneStadt
      is
         when 0 =>      
            return GlobaleKonstanten.LeerKartenPosition;
            
         when others =>
            return GlobaleVariablen.StadtGebaut (RasseExtern, AktuellGefundeneStadt).Position;
      end case;
      
   end NähesteStadtSuchen;
   
   
   
   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (FeindlicheRasseExtern).Städtegrenze loop
         
         case
           GlobaleVariablen.StadtGebaut (FeindlicheRasseExtern, StadtNummerSchleifenwert).ID
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               if
                 EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindlicheRasseExtern,
                                                                 KoordinatenExtern => GlobaleVariablen.StadtGebaut (FeindlicheRasseExtern, StadtNummerSchleifenwert).Position)
                   = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  return GlobaleVariablen.StadtGebaut (FeindlicheRasseExtern, StadtNummerSchleifenwert).Position;
                  
               else
                  null;
               end if;
         end case;
         
      end loop StadtSchleife;
      
      return GlobaleKonstanten.LeerKartenPosition;
      
   end UnbewachteStadtSuchen;

end KIStadtSuchen;
