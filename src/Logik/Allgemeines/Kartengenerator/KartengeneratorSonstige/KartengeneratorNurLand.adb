pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen;

with SchreibeKarten;

with Karten;
with KartenpoleKorrigieren;

package body KartengeneratorNurLand is
      
   procedure NurLandGenerieren
   is begin
      
      Polkorrektur := KartenpoleKorrigieren.KartenpoleKorrigieren;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + Polkorrektur.Norden .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße - Polkorrektur.Süden loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) + Polkorrektur.Westen .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße - Polkorrektur.Osten loop
            
            SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartenGrundDatentypen.Flachland_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end NurLandGenerieren;

end KartengeneratorNurLand;
