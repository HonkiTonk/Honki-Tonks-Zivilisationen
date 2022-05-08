pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseEinheitenGebaut;
with LeseKarten;

with Fehler;

package body RodenAnlegen is

   procedure RodenAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Koordinaten.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            NeuerGrund := HügelSetzen (LeseKarten.Hügel (KoordinatenExtern => Koordinaten));
            
         when KartenKonstanten.UnterflächeKonstante =>
            if
              LeseKarten.Grund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, Koordinaten.YAchse, Koordinaten.XAchse)) = Wasser_Enum
            then
               NeuerGrund := KartengrundDatentypen.Meeresgrund_Enum;
               
            else
               NeuerGrund := KartengrundDatentypen.Küstengrund_Enum;
            end if;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "RodenAnlegen.RodenAnlegen - Falsche Ebene.");
      end case;
      
      SchreibeKarten.Grund (KoordinatenExtern => Koordinaten,
                            GrundExtern       => NeuerGrund);
      
   end RodenAnlegen;

end RodenAnlegen;
