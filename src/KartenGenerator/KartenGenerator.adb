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

      Ladezeiten.SpielweltErstellenZeit (2, GlobaleDatentypen.Anfangswert) := Clock;
      GrößeLandartFestlegen;
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (2, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 2);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos | GlobaleDatentypen.Nur_Land =>
            Ladezeiten.SpielweltErstellenZeit (3, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (3, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (3, GlobaleDatentypen.Anfangswert);
            
         when others =>  
            Ladezeiten.SpielweltErstellenZeit (3, GlobaleDatentypen.Anfangswert) := Clock;
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            Ladezeiten.SpielweltErstellenZeit (3, GlobaleDatentypen.Endwert) := Clock;   
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 3);
      end case;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (4, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (4, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (4, GlobaleDatentypen.Anfangswert);
            
         when others =>            
            Ladezeiten.SpielweltErstellenZeit (4, GlobaleDatentypen.Anfangswert) := Clock;
            KartenGeneratorLandschaft.GenerierungLandschaft;
            Ladezeiten.SpielweltErstellenZeit (4, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 4);
      end case;
      
      Ladezeiten.SpielweltErstellenZeit (5, GlobaleDatentypen.Anfangswert) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.SpielweltErstellenZeit (5, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 5);
      
      Ladezeiten.SpielweltErstellenZeit (6, GlobaleDatentypen.Anfangswert) := Clock;
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.SpielweltErstellenZeit (6, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 6);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (8, GlobaleDatentypen.Anfangswert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (8, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (9, GlobaleDatentypen.Anfangswert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (9, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (10, GlobaleDatentypen.Anfangswert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (10, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (7, GlobaleDatentypen.Anfangswert);
            
         when others =>
            AndereEbenen;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 7);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 8);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 9);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 10);
      end case;

      Ladezeiten.SpielweltErstellenZeit (11, GlobaleDatentypen.Anfangswert) := Clock;
      KartenfelderBewerten.KartenfelderBewerten;
      Ladezeiten.SpielweltErstellenZeit (11, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 11);
      
   end KartenGenerator;
   
   
   
   procedure GrößeLandartFestlegen
   is begin
      
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Inseln | GlobaleDatentypen.Kontinente | GlobaleDatentypen.Nur_Land | GlobaleDatentypen.Chaos =>
            Karten.GrößeLandart := (6, 15, 1, 1, 1);
            return;
            
         when GlobaleDatentypen.Pangäa =>
            null;
      end case;
      
      -- Das hier und den KartenGenerator für Pangäa überarbeiten
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße < Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2
      then
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2;

      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2
      then
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2;

      else
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3;
      end if;
      
      Karten.GrößeLandart := (1, 1, GrößePangäa, 1, 1);
      
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
