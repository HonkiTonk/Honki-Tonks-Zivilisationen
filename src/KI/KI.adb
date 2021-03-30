pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with EinheitenDatenbank, KISiedler, KINahkampfLandEinheit, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit, KINahkampfUnterirdisch,
     KIFernkampfUnterirdisch, KINahkampfOrbital, KIFernkampfOrbital;

package body KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
               
      EinheitenMachenIrgendwasSchleife:
      loop
         EinheitenSchleife:
         for EinheitNummerEinsSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                     
            if
              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBeschäftigung /= 0
              and
                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID > 0
              and
                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBewegungspunkte > 0.00
            then
               AKtivitätEinheitAbbrechen (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));

            elsif
              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).AktuelleBeschäftigung /= 0
              or
                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerEinsSchleifenwert).ID = 0
            then
               null;
               
            else
               AKtivitätEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerEinsSchleifenwert));
            end if;
            
         end loop EinheitenSchleife;

         EinheitenBeschäftigt := 0;
         
         KannEineEinheitNochWasMachenSchleife:
         for EinheitNummerZweiSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerZweiSchleifenwert).KIBeschäftigt = KIDatentypen.Keine_Aufgabe
              and
                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerZweiSchleifenwert).ID > 0
              and
                GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerZweiSchleifenwert).AktuelleBewegungspunkte > 0.00
            then
               exit KannEineEinheitNochWasMachenSchleife;
               
            else
               EinheitenBeschäftigt := EinheitenBeschäftigt + 1;
            end if;
            
         end loop KannEineEinheitNochWasMachenSchleife;

         case
           EinheitenBeschäftigt
         is
            when GlobaleVariablen.EinheitenGebautArray'Last (2) =>
               exit EinheitenMachenIrgendwasSchleife;
               
            when others =>
               null;
         end case;

      end loop EinheitenMachenIrgendwasSchleife;
      
      StädteMachenIrgendwasSchleife:
      loop
         StadtSchleife:
         for StadtNummerEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID > 0
              and
                GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).KIAktuelleBeschäftigung /= 0
              and
                GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).KIAktuelleBeschäftigung /= -10
            then
               AktivitätStadtAbbrechen (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));

            elsif
              GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).ID = 0
              or
                GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerEinsSchleifenwert).KIAktuelleBeschäftigung /= 0
            then
               null;
               
            else
               AktivitätStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerEinsSchleifenwert));
            end if;

         end loop StadtSchleife;

         StadtBeschäftigt := 0;

         KannEineStadtNochWasMachenSchleife:
         for StadtNummerZweiSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerZweiSchleifenwert).KIAktuelleBeschäftigung > -10
              and
                GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerZweiSchleifenwert).ID > 0
            then
               exit KannEineStadtNochWasMachenSchleife;
               
            else
               StadtBeschäftigt := StadtBeschäftigt + 1;
            end if;

         end loop KannEineStadtNochWasMachenSchleife;
         
         case
           StadtBeschäftigt
         is
            when GlobaleVariablen.StadtGebautArray'Last (2) =>
               exit StädteMachenIrgendwasSchleife;
                  
            when others =>
               null;
         end case;
            
      end loop StädteMachenIrgendwasSchleife;
      
   end KI;
      
   

   procedure AKtivitätEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin

      EinheitTyp := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp;
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case
        EinheitTyp
      is
         when 1 =>
            KISiedler.KISiedler (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 2 => -- Bauarbeiter kommt vielleicht später
            null;
            
         when 3 =>
            KINahkampfLandEinheit.KINahkampfLandEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
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



   procedure AKtivitätEinheitAbbrechen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Aufrufen um den Abbruch der aktuellen Tätigkeit zu prüfen
   begin
      
      null;
      
   end AKtivitätEinheitAbbrechen;
   
   
               
   procedure AktivitätStadt (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
            
      null;
            
   end AktivitätStadt;



   procedure AktivitätStadtAbbrechen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is -- Aufrufen um den Abbruch der aktuellen Tätigkeit zu prüfen
   begin
            
      null;
            
   end AktivitätStadtAbbrechen;

end KI;
