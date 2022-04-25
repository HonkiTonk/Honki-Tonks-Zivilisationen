pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with KartenDatentypen;
with EinheitenKonstanten;

with KartenfelderBewerten;
with KartenGeneratorKueste;
with KartenGeneratorLandschaft;
with KartenGeneratorFluss;
with KartenGeneratorRessourcen;
with KartenGeneratorUnterwasserUnterirdisch;
with Karten;
with LadezeitenDatentypen;
with KartengeneratorEisWasserLand;

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
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Kartenfelder_Bewerten_Enum);
      
   end KartenGenerator;
   
   
   
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
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            null;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range =>
            KartenGeneratorKueste.GenerierungKüstenSeeGewässer;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Küstengewässer_Enum);
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            null;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            KartenGeneratorLandschaft.GenerierungLandschaft;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum);
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            null;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            KartenGeneratorUnterwasserUnterirdisch.UnterwasserUnterirdisch;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum);
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            null;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            KartenGeneratorFluss.GenerierungFlüsse;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            null;
            
         when KartenDatentypen.Kartenart_Normal_Enum'Range | KartenDatentypen.Kartenart_Sonstiges_Enum'Range =>
            -- Warum wird hier der Karten.GeneratorGrund auf False gesetzt?
            Karten.GeneratorGrund := (others => (others => False));
            KartenGeneratorRessourcen.GenerierungRessourcen;
      end case;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      --------------------- Gehört jetzt zur SFML
      -- Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
   end RessourcenGenerieren;

end KartenGenerator;
