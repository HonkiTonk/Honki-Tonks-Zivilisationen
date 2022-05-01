pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;

package body WaldAnlegen is

   procedure WaldAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartengrundDatentypen.Hügel_Enum =>
            SchreibeKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                   HügelExtern       => True);
            
         when others =>
            null;
      end case;
            
      -- Nicht in den Überprüfung oben mit rein schieben, da der Wald immer erzeugt werden muss, unabhängig ob da ein Hügel ist.
      SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                            GrundExtern       => KartengrundDatentypen.Wald_Enum);
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range =>
            SchreibeKarten.Verbesserung (KoordinatenExtern     => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                         VerbesserungExtern    => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum);
            
         when others =>
            null;
      end case;
      
   end WaldAnlegen;

end WaldAnlegen;
