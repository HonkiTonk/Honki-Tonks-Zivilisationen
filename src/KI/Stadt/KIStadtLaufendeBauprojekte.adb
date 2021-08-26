pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseStadtGebaut, LeseEinheitenDatenbank;

package body KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesBauprojekt := 0;
     
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Platznummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = GlobaleDatentypen.Leer
         then
            null;
               
         elsif
           LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) = BauprojektExtern
         then
            GleichesBauprojekt := GleichesBauprojekt + 1;
               
         else
            null;
         end if;
            
      end loop StadtSchleife;
      
      return GleichesBauprojekt;
      
   end StadtLaufendeBauprojekte;
   
   
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitArtExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      GleichesBauprojekt := 0;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Platznummer
           or
             LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert)) = GlobaleDatentypen.Leer
         then
            null;
               
         else
            case
              LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
            is
               when GlobaleKonstanten.BauprojekteEinheitenAnfang .. GlobaleKonstanten.BauprojekteEinheitenEnde =>
                  if
                    LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.EinheitAufschlag))
                    = EinheitArtExtern
                  then
                     GleichesBauprojekt := GleichesBauprojekt + 1;
                     
                  else
                     null;
                  end if;
                  
               when others =>
                  null;
            end case;
         end if;
         
      end loop StadtSchleife;
      
      return GleichesBauprojekt;
      
   end GleicheEinheitArtBauprojekte;

end KIStadtLaufendeBauprojekte;
