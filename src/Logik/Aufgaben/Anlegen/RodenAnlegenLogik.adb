with KartenressourcenDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with Zusatzgrundplatzierungssystem;

package body RodenAnlegenLogik is

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Zusatzgrundplatzierungssystem.Zusatzgrundentfernung (KoordinatenExtern => KoordinatenExtern);
      
      case
        LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenressourcenDatentypen.Hochwertiges_Holz_Enum =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => KartenressourcenDatentypen.Leer_Ressource_Enum);
            
         when others =>
            null;
      end case;
        
   end RodenAnlegen;

end RodenAnlegenLogik;
