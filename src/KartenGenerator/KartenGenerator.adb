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

      Ladezeiten.SpielweltErstellenZeit (2, 1) := Clock;
      GrößeLandartFestlegen;
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (2, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 2);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos | GlobaleDatentypen.Nur_Land =>
            Ladezeiten.SpielweltErstellenZeit (3, 1) := Clock;
            Ladezeiten.SpielweltErstellenZeit (3, 2) := Ladezeiten.SpielweltErstellenZeit (3, 1);
            
         when others =>  
            Ladezeiten.SpielweltErstellenZeit (3, 1) := Clock;
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            Ladezeiten.SpielweltErstellenZeit (3, 2) := Clock;   
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 3);
      end case;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (4, 1) := Clock;
            Ladezeiten.SpielweltErstellenZeit (4, 2) := Ladezeiten.SpielweltErstellenZeit (4, 1);
            
         when others =>            
            Ladezeiten.SpielweltErstellenZeit (4, 1) := Clock;
            KartenGeneratorLandschaft.GenerierungLandschaft;
            Ladezeiten.SpielweltErstellenZeit (4, 2) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 4);
      end case;
      
      Ladezeiten.SpielweltErstellenZeit (5, 1) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.SpielweltErstellenZeit (5, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 5);
      
      Ladezeiten.SpielweltErstellenZeit (6, 1) := Clock;
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.SpielweltErstellenZeit (6, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 6);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (7, 1) := Clock;
            Ladezeiten.SpielweltErstellenZeit (7, 2) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (8, 1) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (8, 2) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (9, 1) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (9, 2) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (10, 1) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            Ladezeiten.SpielweltErstellenZeit (10, 2) := Ladezeiten.SpielweltErstellenZeit (7, 1);
            
         when others =>
            AndereEbenen;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 7);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 8);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 9);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 10);
      end case;

      Ladezeiten.SpielweltErstellenZeit (11, 1) := Clock;
      KartenfelderBewerten.KartenfelderBewerten;
      Ladezeiten.SpielweltErstellenZeit (11, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 11);
      
   end KartenGenerator;
   
   
   
   procedure GrößeLandartFestlegen
   is begin
      
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Inseln | GlobaleDatentypen.Kontinente | GlobaleDatentypen.Nur_Land | GlobaleDatentypen.Chaos =>
            Karten.GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2, 10, 1);
            return;
            
         when GlobaleDatentypen.Pangäa =>
            null;
      end case;
      
      -- Festlegen der GrößeLandart für Pangäa kann zu Problemen führen, wenn die YAchse sehr klein ist.
      GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2;
      
      Karten.GrößeLandart := (6, 15, GrößePangäa, 10, 1);
      
   end GrößeLandartFestlegen;



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
