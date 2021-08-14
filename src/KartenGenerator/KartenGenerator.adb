pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Ladezeiten, KartenfelderBewerten, KartenGeneratorChaos, KartenGeneratorStandard, KartenGeneratorKueste, KartenGeneratorLandschaft, KartenGeneratorFluss, KartenGeneratorRessourcen,
     KartenGeneratorUnterwasserUnterirdisch, Karten;

package body KartenGenerator is

   procedure KartenGenerator
   is begin

      EisWasserLandGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;

      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, GlobaleDatentypen.Anfangswert) := Clock;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => GlobaleDatentypen.Leer);
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Kartenfelder_Bewerten);
      
   end KartenGenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres, GlobaleDatentypen.Anfangswert) := Clock;
      GrößeLandartFestlegen;
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres);
      
   end EisWasserLandGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos | GlobaleDatentypen.Nur_Land =>            
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Anfangswert);
            
         when others =>  
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, GlobaleDatentypen.Endwert) := Clock;   
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Küstengewässer);
      end case;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorLandschaft.GenerierungLandschaft;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche);
      end case;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Unterwasser_Unterirdisch);
      end case;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Anfangswert) := Clock;
      KartenGeneratorFluss.GenerierungFlüsse;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Flüsse);
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Anfangswert) := Clock;
      Karten.GeneratorGrund := (others => (others => False));
      KartenGeneratorRessourcen.GenerierungRessourcen;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ressourcen);
      
   end RessourcenGenerieren;
   
   
   
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

end KartenGenerator;
