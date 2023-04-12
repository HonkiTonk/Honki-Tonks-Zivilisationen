with KartenverbesserungDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with Fehlermeldungssystem;
with Zusatzgrundplatzierungssystem;

package body WaldAnlegenLogik is

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when 0 =>
            NeuerGrund := KartengrundDatentypen.Wald_Enum;
            
         when -1 =>
            NeuerGrund := KartengrundDatentypen.Unterwald_Enum;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "WaldAnlegenLogik.WaldAnlegen: Falsche Ebene");
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
