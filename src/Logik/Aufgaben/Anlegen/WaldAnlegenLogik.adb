with KartenverbesserungDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with MeldungssystemHTB1;
with Zusatzgrundplatzierungssystem;

package body WaldAnlegenLogik is

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OberflächeKonstante =>
            NeuerGrund := KartengrundDatentypen.Wald_Enum;
            
         when KartenKonstanten.UnterflächeKonstante =>
            NeuerGrund := KartengrundDatentypen.Unterwald_Enum;
            
         when others =>
            MeldungssystemHTB1.Logik (MeldungExtern => "WaldAnlegenLogik.WaldAnlegen: Falsche Ebene" & KoordinatenExtern.Ebene'Wide_Wide_Image);
            return;
      end case;
      
      Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => KoordinatenExtern,
                                                            ZusatzgrundExtern => NeuerGrund);
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Verbesserung_Gebilde_Friedlich_Enum'Range =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern     => KoordinatenExtern,
                                            VerbesserungExtern    => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
            
         when others =>
            null;
      end case;
      
   end WaldAnlegen;

end WaldAnlegenLogik;
