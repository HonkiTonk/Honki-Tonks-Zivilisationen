pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
      
      case
        LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern)
      is
         when KartengrundDatentypen.Hochwertiges_Holz_Enum =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => KartengrundDatentypen.Leer_Ressource_Enum);
            
         when others =>
            null;
      end case;
        
   end RodenAnlegen;

end RodenAnlegenLogik;
