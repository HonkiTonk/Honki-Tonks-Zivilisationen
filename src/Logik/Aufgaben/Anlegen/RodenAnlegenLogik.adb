pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeWeltkarte;
with LeseWeltkarte;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenExtern));
        
   end RodenAnlegen;

end RodenAnlegenLogik;
