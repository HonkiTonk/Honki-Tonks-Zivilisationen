with SchreibeWeltkarte;

package body Basisgrundplatzierungssystem is

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => BasisgrundExtern);
      
   end Basisgrundplatzierung;

end Basisgrundplatzierungssystem;
