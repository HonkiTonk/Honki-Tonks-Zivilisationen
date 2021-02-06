pragma SPARK_Mode (On);

with EinheitenDatenbank, KISiedler, KINahkampfLandEinheit, KIFernkampfLandEinheit, KINahkampfSeeEinheit, KIFernkampfSeeEinheit, KINahkampfLuftEinheit, KIFernkampfLuftEinheit, KIVariablen, KINahkampfUnterirdisch,
     KIFernkampfUnterirdisch, KINahkampfOrbital, KIFernkampfOrbital;

package body KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
         
      EinheitenMachenIrgendwasSchleife:
      loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
            case KIVariablen.EinheitenNochBefehleErteilbar (RasseExtern, EinheitNummer) is
               when True =>
                  KIVariablen.EinheitenSchonBefehleErteilt (RasseExtern) := 0;
                  if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 0 then
                     KIVariablen.EinheitenNochBefehleErteilbar (RasseExtern, EinheitNummer) := False;
               
                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
                     KIVariablen.EinheitenNochBefehleErteilbar (RasseExtern, EinheitNummer) := False;

                  elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung /= 0 then
                     KIVariablen.EinheitenNochBefehleErteilbar (RasseExtern, EinheitNummer) := False;
               
                  else
                     KIAKtivitätEinheit (RasseExtern   => RasseExtern,
                                          EinheitNummer => EinheitNummer);
                  end if;
               
               when False =>
                  KIVariablen.EinheitenSchonBefehleErteilt (RasseExtern) := KIVariablen.EinheitenSchonBefehleErteilt (RasseExtern) + 1;
                  case KIVariablen.EinheitenSchonBefehleErteilt (RasseExtern) is
                     when GlobaleVariablen.EinheitenGebaut'Last (2) =>
                        exit EinheitenMachenIrgendwasSchleife;
                        
                     when others =>
                        null;
                  end case;
            end case;
            
         end loop EinheitenSchleife;
      end loop EinheitenMachenIrgendwasSchleife;

      EinheitenDatenbank.EinheitGebautSortieren (RasseExtern => RasseExtern);
      
      StädteMachenIrgendwasSchleife:
      loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID = 0 then
               exit StadtSchleife;
               
            else
               KIAktivitätStadt (RasseExtern => RasseExtern,
                                  StadtNummer => StadtNummer);
            end if;

         end loop StadtSchleife;
         exit StädteMachenIrgendwasSchleife; -- Damit das erst einmal funktioniert
         
      end loop StädteMachenIrgendwasSchleife;
      
   end KI;



   procedure KIAKtivitätEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin
      
      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft, 9 = NahkampfUnterirdisch, 10 = FernkampfUnterirdisch,
      -- 11 = NahkampfOrbital, 12 = FernkampfOrbital
      case EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit is
         when 1 =>
            KISiedler.KISiedler (RasseExtern   => RasseExtern,
                                 EinheitNummer => EinheitNummer);
            
         when 2 => -- Bauarbeiter kommt vielleicht später
            null;
            
         when 3 =>
            KINahkampfLandEinheit.KINahkampfLandEinheit (RasseExtern   => RasseExtern,
                                                         EinheitNummer => EinheitNummer);
            
         when 4 =>
            KIFernkampfLandEinheit.KIFernkampfLandEinheit (RasseExtern   => RasseExtern,
                                                           EinheitNummer => EinheitNummer);
            
         when 5 =>
            KINahkampfSeeEinheit.KINahkampfSeeEinheit (RasseExtern   => RasseExtern,
                                                       EinheitNummer => EinheitNummer);
            
         when 6 =>
            KIFernkampfSeeEinheit.KIFernkampfSeeEinheit (RasseExtern   => RasseExtern,
                                                         EinheitNummer => EinheitNummer);
            
         when 7 =>
            KINahkampfLuftEinheit.KINahkampfLuftEinheit (RasseExtern   => RasseExtern,
                                                         EinheitNummer => EinheitNummer);
            
         when 8 =>
            KIFernkampfLuftEinheit.KIFernkampfLuftEinheit (RasseExtern   => RasseExtern,
                                                           EinheitNummer => EinheitNummer);
            
         when 9 =>
            KINahkampfUnterirdisch.KINahkampfUnterirdisch (RasseExtern   => RasseExtern,
                                                           EinheitNummer => EinheitNummer);

         when 10 =>
            KIFernkampfUnterirdisch.KIFernkampfUnterirdisch (RasseExtern   => RasseExtern,
                                                             EinheitNummer => EinheitNummer);
            
         when 11 =>
            KINahkampfOrbital.KINahkampfOrbital (RasseExtern   => RasseExtern,
                                                 EinheitNummer => EinheitNummer);

         when 12 =>
            KIFernkampfOrbital.KIFernkampfOrbital (RasseExtern   => RasseExtern,
                                                   EinheitNummer => EinheitNummer);

         when others =>
            null;
      end case;
      
   end KIAKtivitätEinheit;
   
   
               
   procedure KIAktivitätStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin
            
      null;
            
   end KIAktivitätStadt;

end KI;
