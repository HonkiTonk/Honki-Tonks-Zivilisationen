pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;

with Fehler;

package body WaldAnlegen is

   procedure WaldAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Koordinaten.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            if
              LeseKarten.AktuellerGrund (KoordinatenExtern => Koordinaten) = KartengrundDatentypen.Hügel_Enum
            then
               SchreibeKarten.Hügel (KoordinatenExtern => Koordinaten,
                                      HügelExtern       => True);
            
            else
               null;
            end if;

            NeuerGrund := KartengrundDatentypen.Wald_Enum;
            
         when KartenKonstanten.UnterflächeKonstante =>
            NeuerGrund := KartengrundDatentypen.Unterwald_Enum;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "WaldAnlegen.WaldAnlegen - Falsche Ebene.");
      end case;
            
      -- Nicht in den Überprüfung oben mit rein schieben, da der Wald immer erzeugt werden muss, unabhängig ob da ein Hügel ist.
      SchreibeKarten.AktuellerGrund (KoordinatenExtern => Koordinaten,
                            GrundExtern       => NeuerGrund);
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => Koordinaten)
      is
         when KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range =>
            SchreibeKarten.Verbesserung (KoordinatenExtern     => Koordinaten,
                                         VerbesserungExtern    => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum);
            
         when others =>
            null;
      end case;
      
   end WaldAnlegen;

end WaldAnlegen;
