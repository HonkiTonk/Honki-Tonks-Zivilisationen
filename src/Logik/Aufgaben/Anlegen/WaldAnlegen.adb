pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen;

with SchreibeKarten;
with LeseKarten;

with Fehler;

package body WaldAnlegen is

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
            Fehler.LogikFehler (FehlermeldungExtern => "WaldAnlegen.WaldAnlegen - Falsche Ebene.");
      end case;
      
      SchreibeKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => NeuerGrund);
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range =>
            SchreibeKarten.Verbesserung (KoordinatenExtern     => KoordinatenExtern,
                                         VerbesserungExtern    => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
            
         when others =>
            null;
      end case;
      
   end WaldAnlegen;

end WaldAnlegen;
