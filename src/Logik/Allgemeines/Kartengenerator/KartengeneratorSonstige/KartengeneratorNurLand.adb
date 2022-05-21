pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with SchreibeKarten;

with KartengeneratorVariablen;

package body KartengeneratorNurLand is
      
   procedure NurLandGenerieren
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            SchreibeKarten.AktuellerGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                  GrundExtern       => KartengrundDatentypen.Flachland_Enum);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end NurLandGenerieren;

end KartengeneratorNurLand;
