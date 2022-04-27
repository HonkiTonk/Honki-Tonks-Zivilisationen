pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with EinheitenKonstanten;

with KartenfelderBewerten;
with KartengeneratorKueste;
with KartengeneratorLandschaft;
with KartengeneratorFluss;
with KartengeneratorRessourcen;
with KartengeneratorUnterwasserUnterirdisch;
with LadezeitenDatentypen;
with KartengeneratorEisWasserLand;
with KartengeneratorUnterflaeche;

package body Kartengenerator is

   procedure Kartengenerator
   is begin
            
      EisWasserLandGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterflächeGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;

      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Kartenfelder_Bewerten_Enum);
      
   end Kartengenerator;
   
   
   
   procedure EisWasserLandGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorEisWasserLand.AufteilungEisWasserLand;
            
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum);
      
   end EisWasserLandGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorKueste.GenerierungKüstenSeeGewässer;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Küstengewässer_Enum);
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorLandschaft.GenerierungLandschaft;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum);
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterflächeGenerieren
   is begin
      
      ----------------------- Ladezeiten hier einbauen.
      
      KartengeneratorUnterflaeche.KartengeneratorUnterfläche;
      
      ----------------------- Ladezeiten hier einbauen.
      
   end UnterflächeGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum);
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorFluss.AufteilungFlussgenerierung;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorRessourcen.AufteilungRessourcengenerierung;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end RessourcenGenerieren;

end Kartengenerator;
