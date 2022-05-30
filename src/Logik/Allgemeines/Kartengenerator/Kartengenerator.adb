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
with KartengeneratorAllgemeines;

package body Kartengenerator is

   procedure Kartengenerator
   is begin
      
      AllgemeinesGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;

      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Kartenfelder_Bewerten_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end Kartengenerator;
   
   
   
   procedure AllgemeinesGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorAllgemeines.GenerierungAllgemeines;
            
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end AllgemeinesGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorKueste.GenerierungKüstenSeeGewässer;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Küstengewässer_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorLandschaft.GenerierungLandschaft;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Landschaft_Ebene_Oberfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Unterwasser_Unterirdisch_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorFluss.AufteilungFlussgenerierung;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorRessourcen.AufteilungRessourcengenerierung;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end RessourcenGenerieren;

end Kartengenerator;
