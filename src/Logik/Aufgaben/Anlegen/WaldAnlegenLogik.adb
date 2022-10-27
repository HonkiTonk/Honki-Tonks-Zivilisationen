pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen;

with SchreibeWeltkarte;
with LeseWeltkarte;

with Fehler;

package body WaldAnlegenLogik is

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when 0 =>
            NeuerGrund := KartengrundDatentypen.Wald_Enum;
            
         when -1 =>
            NeuerGrund := KartengrundDatentypen.Unterwald_Enum;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WaldAnlegen.WaldAnlegen: Falsche Ebene.");
      end case;
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => NeuerGrund);
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern     => KoordinatenExtern,
                                            VerbesserungExtern    => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
            
         when others =>
            null;
      end case;
      
   end WaldAnlegen;

end WaldAnlegenLogik;
