pragma SPARK_Mode (On);

with EinheitenDatenbank;

with KISiedler, KINahkampfBoden, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit, KINahkampfUnterirdisch,
     KIFernkampfUnterirdisch, KINahkampfOrbital, KIFernkampfOrbital, KIStadt, KIForschung, KIDiplomatie;

package body KI is

   procedure KI
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitenDurchgehen (RasseExtern => RasseExtern);
      StädteDurchgehen (RasseExtern => RasseExtern);
      KIForschung.Forschung (RasseExtern => RasseExtern);
      KIDiplomatie.Diplomatie (RasseExtern => RasseExtern);
      
   end KI;
   
   
   
   procedure EinheitenDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerEinsSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID = 0
           or
             GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBewegungspunkte <= 0.00
         then
            null;
            
         else
            AKtivitätEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
         end if;
            
      end loop EinheitenSchleife;
      
   end EinheitenDurchgehen;
   
   
   
   procedure StädteDurchgehen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      StadtSchleife:
      for StadtNummerEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID > 0
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
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp
      is
         when 1 =>
            KISiedler.KISiedler (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 2 => -- Bauarbeiter kommt vielleicht später
            null;
            
         when 3 =>
            KINahkampfBoden.KINahkampfBoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 4 =>
            KIFernkampfLandEinheit.KIFernkampfLandEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 5 =>
            KINahkampfSeeEinheit.KINahkampfSeeEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 6 =>
            KIFernkampfSeeEinheit.KIFernkampfSeeEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 7 =>
            KINahkampfLuftEinheit.KINahkampfLuftEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 8 =>
            KIFernkampfLuftEinheit.KIFernkampfLuftEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 9 =>
            KINahkampfUnterirdisch.KINahkampfUnterirdisch (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when 10 =>
            KIFernkampfUnterirdisch.KIFernkampfUnterirdisch (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 11 =>
            KINahkampfOrbital.KINahkampfOrbital (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when 12 =>
            KIFernkampfOrbital.KIFernkampfOrbital (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end AKtivitätEinheit;

end KI;
