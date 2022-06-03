pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;

with SchreibeKarten;
with LeseKarten;

package body RodenAnlegen is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern));
        
   end RodenAnlegen;

end RodenAnlegen;
