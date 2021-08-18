pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with KISiedler, KINahkampfBoden, KIStadt, KIForschung, KIDiplomatie, LeseEinheitenGebaut;

package body KI is

   procedure KI
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschung.Forschung (RasseExtern => RasseExtern);
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerEinsSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert)) = GlobaleKonstanten.LeerEinheit.ID
           or
             LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert)) = GlobaleKonstanten.LeerEinheit.Bewegungspunkte
         then
            null;
            
         else
            AKtivitätEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
         end if;
            
      end loop EinheitenSchleife;
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtNummerEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
            
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            KIStadt.KIStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));
            
         else
            null;
         end if;

      end loop StadtSchleife;
      
   end StädteDurchgehen;
   
   

   procedure AKtivitätEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).EinheitArt
      is
         when GlobaleDatentypen.Arbeiter =>
            KISiedler.KISiedler (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when GlobaleDatentypen.Nahkämpfer =>
            KINahkampfBoden.KINahkampfBoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when GlobaleDatentypen.Fernkämpfer =>
            null;
            
         when GlobaleDatentypen.Beides =>
            null;
            
         when GlobaleDatentypen.Sonstiges =>
            null;
            
         when GlobaleDatentypen.Leer =>
            null;
      end case;
      
   end AKtivitätEinheit;

end KI;
