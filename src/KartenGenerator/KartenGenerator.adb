pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Ladezeiten, KartenfelderBewerten, KartenGeneratorChaos, KartenGeneratorStandard, KartenGeneratorKueste, KartenGeneratorLandschaft, KartenGeneratorFluss, KartenGeneratorRessourcen, KartenGeneratorHimmel,
     KartenGeneratorWeltraum, KartenGeneratorUnterwasserUnterirdisch, KartenGeneratorPlanetenInneres, Karten;

package body KartenGenerator is

   procedure KartenGenerator
   is begin
      
      -- Inseln, Kontinente, Pangäa
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.
      Karten.GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2, 10);

      Ladezeiten.SpielweltErstellenZeit (2, 1) := Clock;
      case
        Karten.Kartenart
      is
         when 5 =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (2, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 2);
            
      Ladezeiten.SpielweltErstellenZeit (3, 1) := Clock;
      KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
      Ladezeiten.SpielweltErstellenZeit (3, 2) := Clock;   
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 3);   
      
      Ladezeiten.SpielweltErstellenZeit (4, 1) := Clock;
      KartenGeneratorLandschaft.GenerierungLandschaft;
      Ladezeiten.SpielweltErstellenZeit (4, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 4);
      
      Ladezeiten.SpielweltErstellenZeit (5, 1) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.SpielweltErstellenZeit (5, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 5);
      
      Ladezeiten.SpielweltErstellenZeit (6, 1) := Clock;
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.SpielweltErstellenZeit (6, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 6);
      
      AndereEbenen;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 7);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 8);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 9);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 10);

      Ladezeiten.SpielweltErstellenZeit (11, 1) := Clock;
      KartenfelderBewerten.KartenfelderBewerten;
      Ladezeiten.SpielweltErstellenZeit (11, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 11);
      
   end KartenGenerator;



   procedure AndereEbenen
   is
      
      task Himmel;
      task Weltraum;
      task UnterwasserUnterirdisch;
      task PlanetenInneres;
      
      task body Himmel
      is begin
         
         KartenGeneratorHimmel.Himmel;
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartenGeneratorWeltraum.Weltraum;
         
      end Weltraum;
      
      

      task body UnterwasserUnterirdisch
      is begin
         
         KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres
      is begin
         
         KartenGeneratorPlanetenInneres.PlanetenInneres;
         
      end PlanetenInneres;


      
   begin
            
      null;
      
   end AndereEbenen;

end KartenGenerator;
