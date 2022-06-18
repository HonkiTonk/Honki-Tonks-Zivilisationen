pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;
with EinheitenKonstanten;
with LadezeitenDatentypen;

with KartenfelderBewerten;
with KartengeneratorKueste;
with KartengeneratorLandschaft;
with KartengeneratorFluss;
with KartengeneratorRessourcen;
with KartengeneratorUnterwasserUnterirdisch;
with KartengeneratorAllgemeines;
with Ladezeiten;

package body Kartengenerator is

   procedure Kartengenerator
   is begin
      
      AllgemeinesGenerieren;
      KüstenwasserGenerieren;
      LandschaftGenerieren;
      UnterwasserUnterirdischGenerieren;
      FlüsseGenerieren;
      RessourcenGenerieren;
      BewerteKartenfelder;
      
   end Kartengenerator;
   
   
   
   procedure AllgemeinesGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Allgemeines_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorAllgemeines.GenerierungAllgemeines;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
            
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Allgemeines_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end AllgemeinesGenerieren;
   
   
   
   procedure KüstenwasserGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Küstenwasser_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorKueste.GenerierungKüstenSeeGewässer;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Küstenwasser_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end KüstenwasserGenerieren;
   
   
   
   procedure LandschaftGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Landschaft_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorLandschaft.GenerierungLandschaft;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Landschaft_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end LandschaftGenerieren;
   
   
   
   procedure UnterwasserUnterirdischGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Unterfläche_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorUnterwasserUnterirdisch.GenerierungLandschaft;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Unterfläche_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end UnterwasserUnterirdischGenerieren;
   
   
   
   procedure FlüsseGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorFluss.AufteilungFlussgenerierung;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Flüsse_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end FlüsseGenerieren;
   
   
   
   procedure RessourcenGenerieren
   is begin
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartengeneratorRessourcen.AufteilungRessourcengenerierung;
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Generiere_Ressourcen_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end RessourcenGenerieren;
   
   
   
   procedure BewerteKartenfelder
   is begin

      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Bewerte_Kartenfelder_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      KartenfelderBewerten.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
      
      Ladezeiten.SpielweltErstellen (LadezeitenDatentypen.Bewerte_Kartenfelder_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
   end BewerteKartenfelder;

end Kartengenerator;
