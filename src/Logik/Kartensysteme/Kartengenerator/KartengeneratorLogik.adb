pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with LadezeitenDatentypen;

with KartenfelderBewertenLogik;
with KartengeneratorKuesteLogik;
with KartengeneratorLandschaftLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRessourcenLogik;
with KartengeneratorUnterflaecheLogik;
with KartengeneratorAllgemeinesLogik;
with LadezeitenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      KartengeneratorAllgemeinesLogik.GenerierungAllgemeines;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
      KartengeneratorKuesteLogik.GenerierungKüstenSeeGewässer;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorLandschaftLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      KartengeneratorUnterflaecheLogik.GenerierungLandschaft;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
      KartengeneratorFlussLogik.GenerierungFlüsse;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      KartengeneratorRessourcenLogik.GenerierungRessourcen;
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Ressourcen_Enum);
      
      KartenfelderBewertenLogik.KartenfelderBewerten (RasseExtern => EinheitenKonstanten.LeerRasse);
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
      
   end Kartengenerator;

end KartengeneratorLogik;
