with KartenrohstoffeDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with Zusatzgrundplatzierungssystem;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Zusatzgrundplatzierungssystem.Zusatzgrundentfernung (KoordinatenExtern => KoordinatenExtern);
      
      case
        LeseWeltkarte.Rohstoff (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenrohstoffeDatentypen.Hochwertiges_Holz_Enum =>
            SchreibeWeltkarte.Rohstoff (KoordinatenExtern => KoordinatenExtern,
                                         RohstoffExtern   => KartenrohstoffeDatentypen.Leer_Rohstoff_Enum);
            
         when others =>
            null;
      end case;
        
   end RodenAnlegen;

end RodenAnlegenLogik;
