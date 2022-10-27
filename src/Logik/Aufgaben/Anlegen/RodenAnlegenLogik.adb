pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with SchreibeWeltkarte;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
        
   end RodenAnlegen;

end RodenAnlegenLogik;
