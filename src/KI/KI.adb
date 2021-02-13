pragma SPARK_Mode (On);

with EinheitenDatenbank, KISiedler, KINahkampfLandEinheit, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit, KINahkampfUnterirdisch,
     KIFernkampfUnterirdisch, KINahkampfOrbital, KIFernkampfOrbital, Sortieren;

package body KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
               
      EinheitenMachenIrgendwasSchleife:
      loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                     
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= 0 and GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= -10
              and GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID > 0 and GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte > 0.00 then
               AKtivitätEinheitAbbrechen (EinheitRasseNummerID => (RasseExtern, EinheitNummer, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID));

            elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= 0 or GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 0 then
               null;
               
            else
               AKtivitätEinheit (EinheitRasseNummerID => (RasseExtern, EinheitNummer, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID));
            end if;
            
         end loop EinheitenSchleife;

         EinheitenBeschäftigt := 0;

         KannEineEinheitNochWasMachenSchleife:
         for Platznummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, Platznummer).AktuelleBeschäftigung > -10 and GlobaleVariablen.EinheitenGebaut (RasseExtern, Platznummer).ID > 0
              and GlobaleVariablen.EinheitenGebaut (RasseExtern, Platznummer).AktuelleBewegungspunkte > 0.00 then
               exit KannEineEinheitNochWasMachenSchleife;
               
            else
               EinheitenBeschäftigt := EinheitenBeschäftigt + 1;
            end if;
            
         end loop KannEineEinheitNochWasMachenSchleife;

         case EinheitenBeschäftigt is
            when GlobaleVariablen.EinheitenGebautArray'Last (2) =>
               exit EinheitenMachenIrgendwasSchleife;
               
            when others =>
               null;
         end case;

      end loop EinheitenMachenIrgendwasSchleife;

      Sortieren.EinheitenSortieren (RasseExtern => RasseExtern);
      
      StädteMachenIrgendwasSchleife:
      loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID > 0 and GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).KIAktuelleBeschäftigung /= 0
              and GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).KIAktuelleBeschäftigung /= -10 then
               AktivitätStadtAbbrechen (StadtRasseNummerID => (RasseExtern, StadtNummer, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID));

            elsif GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID = 0 or GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).KIAktuelleBeschäftigung /= 0 then
               null;
               
            else
               AktivitätStadt (StadtRasseNummerID => (RasseExtern, StadtNummer, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID));
            end if;

         end loop StadtSchleife;

         StadtBeschäftigt := 0;

         KannEineStadtNochWasMachenSchleife:
         for Platznummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseExtern, Platznummer).KIAktuelleBeschäftigung > -10 and GlobaleVariablen.StadtGebaut (RasseExtern, Platznummer).ID > 0 then
               exit KannEineStadtNochWasMachenSchleife;
               
            else
               StadtBeschäftigt := StadtBeschäftigt + 1;
            end if;

         end loop KannEineStadtNochWasMachenSchleife;
         
         case StadtBeschäftigt is
            when GlobaleVariablen.StadtGebautArray'Last (2) =>
               exit StädteMachenIrgendwasSchleife;
                  
            when others =>
               null;
         end case;
            
      end loop StädteMachenIrgendwasSchleife;

      Sortieren.StädteSortieren (RasseExtern => RasseExtern);
      
   end KI;
      
   

   procedure AKtivitätEinheit (EinheitRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin

      EinheitTyp := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerID.Rasse, EinheitRasseNummerID.ID).EinheitTyp;
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case EinheitTyp is
         when 1 =>
            null;
            -- KISiedler.KISiedler (EinheitRasseNummer => EinheitRasseNummer);
            
         when 2 => -- Bauarbeiter kommt vielleicht später
            null;
            
         when 3 =>
            null;
            -- KINahkampfLandEinheit.KINahkampfLandEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 4 =>
            null;
            -- KIFernkampfLandEinheit.KIFernkampfLandEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 5 =>
            null;
            -- KINahkampfSeeEinheit.KINahkampfSeeEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 6 =>
            null;
            -- KIFernkampfSeeEinheit.KIFernkampfSeeEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 7 =>
            null;
            -- KINahkampfLuftEinheit.KINahkampfLuftEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 8 =>
            null;
            -- KIFernkampfLuftEinheit.KIFernkampfLuftEinheit (EinheitRasseNummer => EinheitRasseNummer);
            
         when 9 =>
            null;
            -- KINahkampfUnterirdisch.KINahkampfUnterirdisch (EinheitRasseNummer => EinheitRasseNummer);

         when 10 =>
            null;
            -- KIFernkampfUnterirdisch.KIFernkampfUnterirdisch (EinheitRasseNummer => EinheitRasseNummer);
            
         when 11 =>
            null;
            -- KINahkampfOrbital.KINahkampfOrbital (EinheitRasseNummer => EinheitRasseNummer);

         when 12 =>
            null;
            -- KIFernkampfOrbital.KIFernkampfOrbital (EinheitRasseNummer => EinheitRasseNummer);
      end case;
      
   end AKtivitätEinheit;



   procedure AKtivitätEinheitAbbrechen (EinheitRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) is -- Aufrufen um den Abbruch der aktuellen Tätigkeit zu prüfen
   begin
      
      null;
      
   end AKtivitätEinheitAbbrechen;
   
   
               
   procedure AktivitätStadt (StadtRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) is
   begin
            
      null;
            
   end AktivitätStadt;



   procedure AktivitätStadtAbbrechen (StadtRasseNummerID : in GlobaleRecords.RassePlatznummerIDRecord) is
   begin
            
      null;
            
   end AktivitätStadtAbbrechen;

end KI;
