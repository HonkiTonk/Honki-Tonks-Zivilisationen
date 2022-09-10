pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;
with LeseKarten;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern));
        
   end RodenAnlegen;

end RodenAnlegenLogik;
