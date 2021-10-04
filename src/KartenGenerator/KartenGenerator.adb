pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen, SonstigeDatentypen, KartenDatentypen;
use GlobaleDatentypen;

with Ladezeiten, KartenfelderBewerten, KartenGeneratorChaos, KartenGeneratorStandard, KartenGeneratorKueste, KartenGeneratorLandschaft, KartenGeneratorFluss, KartenGeneratorRessourcen,
     KartenGeneratorUnterwasserUnterirdisch, Karten, LandwerteFestlegen;

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
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => SonstigeDatentypen.Leer);
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Kartenfelder_Bewerten);
      
   end KartenGenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres, GlobaleDatentypen.Anfangswert) := Clock;
      LandwerteFestlegen.GrößeFestlegen;
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
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
         when KartenDatentypen.Chaos | KartenDatentypen.Nur_Land =>
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
         when KartenDatentypen.Chaos =>
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
         when KartenDatentypen.Chaos =>
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
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorFluss.GenerierungFlüsse;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Flüsse);
      end case;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Anfangswert);
            
         when others =>
            Karten.GeneratorGrund := (others => (others => False));
            KartenGeneratorRessourcen.GenerierungRessourcen;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, GlobaleDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ressourcen);
      end case;
      
   end RessourcenGenerieren;

end KartenGenerator;
