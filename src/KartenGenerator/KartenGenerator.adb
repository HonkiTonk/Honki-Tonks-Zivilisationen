pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with SonstigeDatentypen;
with KartenDatentypen;
with SystemDatentypen;

with Ladezeiten;
with KartenfelderBewerten;
with KartenGeneratorChaos;
with KartenGeneratorStandard;
with KartenGeneratorKueste;
with KartenGeneratorLandschaft;
with KartenGeneratorFluss;
with KartenGeneratorRessourcen;
with KartenGeneratorUnterwasserUnterirdisch;
with Karten;
with LandwerteFestlegen;

package body KartenGenerator is

   procedure KartenGenerator
   is begin

      EisWasserLandGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;

      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, SystemDatentypen.Anfangswert) := Clock;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => SonstigeDatentypen.Leer);
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Kartenfelder_Bewerten, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Kartenfelder_Bewerten);
      
   end KartenGenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres, SystemDatentypen.Anfangswert) := Clock;
      LandwerteFestlegen.GrößeFestlegen;
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Normal_Himmel_Weltraum_Planeteninneres);
      
   end EisWasserLandGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos | KartenDatentypen.Nur_Land =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, SystemDatentypen.Endwert) := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Küstengewässer, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Küstengewässer);
      end case;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorLandschaft.GenerierungLandschaft;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Landschaft_Ebene_Oberfläche);
      end case;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Unterwasser_Unterirdisch);
      end case;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, SystemDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorFluss.GenerierungFlüsse;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Flüsse, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Flüsse);
      end case;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Chaos =>
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, SystemDatentypen.Endwert)
              := Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, SystemDatentypen.Anfangswert);
            
         when others =>
            Karten.GeneratorGrund := (others => (others => False));
            KartenGeneratorRessourcen.GenerierungRessourcen;
            Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ressourcen, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => Ladezeiten.Generiere_Ressourcen);
      end case;
      
   end RessourcenGenerieren;

end KartenGenerator;
