pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with EinheitenKonstanten;

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

      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Kartenfelder_Bewerten_Enum);
      
   end KartenGenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      LandwerteFestlegen.GrößeFestlegen;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum =>
            KartenGeneratorChaos.Chaos;
            
         when others =>
            KartenGeneratorStandard.StandardKarte;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum);
      
   end EisWasserLandGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum | SystemDatentypen.Karte_Art_Nur_Land_Enum =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Endwert_Enum)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Anfangswert_Enum);
            
         when others =>
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Endwert_Enum) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Küstengewässer_Enum);
      end case;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Endwert_Enum)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Anfangswert_Enum);
            
         when others =>
            KartenGeneratorLandschaft.GenerierungLandschaft;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum);
      end case;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum);
            
         when others =>
            KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum);
      end case;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum);
            
         when others =>
            KartenGeneratorFluss.GenerierungFlüsse;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      end case;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenart
      is
         when SystemDatentypen.Karte_Art_Chaos_Enum =>
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum)
              := LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum);
            
         when others =>
            Karten.GeneratorGrund := (others => (others => False));
            KartenGeneratorRessourcen.GenerierungRessourcen;
            LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
            Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      end case;
      
   end RessourcenGenerieren;

end KartenGenerator;
