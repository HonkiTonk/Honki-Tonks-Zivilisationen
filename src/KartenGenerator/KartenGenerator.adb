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
      
      Karten.GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2, 10); -- Inseln, Kontinente, Pangäa
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 1) := Clock;
      case
        Karten.Kartenart
      is
         when 5 =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 1) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 1);
            
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 2) := Clock;
      KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 2) := Clock;   
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 2);   
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 3) := Clock;
      KartenGeneratorLandschaft.GenerierungLandschaft;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 3) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 3);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 4) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 4) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 4);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 5) := Clock;
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 5) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 5);
      
      AndereEbenen;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 6);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 7);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 8);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 9);

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 10) := Clock;
      KartenfelderBewerten.KartenfelderBewerten;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 10) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 10);
      
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
