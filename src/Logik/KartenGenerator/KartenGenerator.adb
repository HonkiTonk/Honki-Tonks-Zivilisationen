pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with EinheitenKonstanten;
with KartenEinstellungenKonstanten;

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
with LadezeitenDatentypen;

package body KartenGenerator is

   procedure KartenGenerator
   is begin
      
      EisWasserLandGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;

      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten, SystemDatentypen.Anfangswert) := Clock;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Kartenfelder_Bewerten);
      
   end KartenGenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres, SystemDatentypen.Anfangswert) := Clock;
      LandwerteFestlegen.GrößeFestlegen;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres);
      
   end EisWasserLandGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante | KartenEinstellungenKonstanten.KartenartLandKonstante =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer, SystemDatentypen.Endwert)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Küstengewässer);
      end case;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Endwert)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorLandschaft.GenerierungLandschaft;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche);
      end case;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch);
      end case;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse, SystemDatentypen.Endwert)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse, SystemDatentypen.Anfangswert);
            
         when others =>
            KartenGeneratorFluss.GenerierungFlüsse;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Flüsse);
      end case;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen, SystemDatentypen.Anfangswert) := Clock;
      
      case
        Karten.Kartenart
      is
         when KartenEinstellungenKonstanten.KartenartChaosKonstante =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen, SystemDatentypen.Endwert)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen, SystemDatentypen.Anfangswert);
            
         when others =>
            Karten.GeneratorGrund := (others => (others => False));
            KartenGeneratorRessourcen.GenerierungRessourcen;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen, SystemDatentypen.Endwert) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Ressourcen);
      end case;
      
   end RessourcenGenerieren;

end KartenGenerator;
