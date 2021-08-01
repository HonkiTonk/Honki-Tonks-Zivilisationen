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

      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert) := Clock;
      GrößeLandartFestlegen;
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Oberfläche, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ebene_Oberfläche);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos | GlobaleDatentypen.Nur_Land =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Anfangswert);
            
         when others =>  
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Anfangswert) := Clock;
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Endwert) := Clock;   
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Küstengewässer);
      end case;
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Anfangswert) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Flüsse);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert);
            
         when others =>            
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert) := Clock;
            KartenGeneratorLandschaft.GenerierungLandschaft;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche);
      end case;
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Anfangswert) := Clock;
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ressourcen);
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert) := Clock;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Weltraum, GlobaleDatentypen.Anfangswert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Weltraum, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Unterirdisch, GlobaleDatentypen.Anfangswert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Unterirdisch, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Planeteninneres, GlobaleDatentypen.Anfangswert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Planeteninneres, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert);
            
         when others =>
            AndereEbenen;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ebene_Himmel);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ebene_Weltraum);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ebene_Unterirdisch);
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ebene_Planeteninneres);
      end case;

      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, GlobaleDatentypen.Anfangswert) := Clock;
      KartenfelderBewerten.KartenfelderBewerten;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Kartenfelder_Bewerten);
      
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
