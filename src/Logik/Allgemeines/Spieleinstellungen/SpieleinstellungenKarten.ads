pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;
with KartenDatentypen;
with SystemRecords;

package SpieleinstellungenKarten is
   
   procedure KartenpoleWählen;
   procedure KartengrößeWählen;
   procedure KartenartWählen;
   procedure KartenformWählen;
   procedure KartentemperaturWählen;
   procedure KartenressourcenWählen;
   
private
   
   KartenpoleAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartengrößeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartentemperaturAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenressourcenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   EingegebeneEisdicke : KartenDatentypen.KartenfeldNatural;
   MaximaleEisdicke : KartenDatentypen.KartenfeldPositiv;
   
   ZwischenwertKartenart : Positive;
   
   BenutzerdefinierteGröße : SystemRecords.ZahlenEingabeRecord;
   BenutzerdefinierteKartenart : SystemRecords.ZahlenEingabeRecord;
   
   type KartengrößeRückgabeZuKartenArray is array (RueckgabeDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.Kartengröße_Verwendet_Enum;
   KartengrößeRückgabeZuKarten : constant KartengrößeRückgabeZuKartenArray := (
                                                                                     RueckgabeDatentypen.Kartengröße_20_20_Enum     => KartenDatentypen.Kartengröße_20_20_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_40_40_Enum     => KartenDatentypen.Kartengröße_40_40_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_80_80_Enum     => KartenDatentypen.Kartengröße_80_80_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_120_80_Enum    => KartenDatentypen.Kartengröße_120_80_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_120_160_Enum   => KartenDatentypen.Kartengröße_120_160_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_160_160_Enum   => KartenDatentypen.Kartengröße_160_160_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_240_240_Enum   => KartenDatentypen.Kartengröße_240_240_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_320_320_Enum   => KartenDatentypen.Kartengröße_320_320_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_1000_1000_Enum => KartenDatentypen.Kartengröße_1000_1000_Enum,
                                                                                     RueckgabeDatentypen.Kartengröße_Nutzer_Enum    => KartenDatentypen.Kartengröße_Nutzer_Enum
                                                                                    );
   
   type KartenartRückgabeZuKartenArray is array (RueckgabeDatentypen.Kartenart_Enum'Range) of KartenDatentypen.Kartenart_Enum;
   KartenartRückgabeZuKarten : constant KartenartRückgabeZuKartenArray := (
                                                                             RueckgabeDatentypen.Kartenart_Inseln_Enum        => KartenDatentypen.Kartenart_Inseln_Enum,
                                                                             RueckgabeDatentypen.Kartenart_Kontinente_Enum    => KartenDatentypen.Kartenart_Kontinente_Enum,
                                                                             RueckgabeDatentypen.Kartenart_Pangäa_Enum        => KartenDatentypen.Kartenart_Pangäa_Enum,
                                                                             RueckgabeDatentypen.Kartenart_Nur_Land_Enum      => KartenDatentypen.Kartenart_Nur_Land_Enum
                                                                            );
   
   type KartentemperaturRückgabeZuKartenArray is array (RueckgabeDatentypen.Kartentemperatur_Enum'Range) of KartenDatentypen.Kartentemperatur_Enum;
   KartentemperaturRückgabeZuKarten : constant KartentemperaturRückgabeZuKartenArray := (
                                                                                           RueckgabeDatentypen.Kartentemperatur_Kalt_Enum     => KartenDatentypen.Kartentemperatur_Kalt_Enum,
                                                                                           RueckgabeDatentypen.Kartentemperatur_Gemäßigt_Enum => KartenDatentypen.Kartentemperatur_Gemäßigt_Enum,
                                                                                           RueckgabeDatentypen.Kartentemperatur_Heiß_Enum     => KartenDatentypen.Kartentemperatur_Heiß_Enum,
                                                                                           RueckgabeDatentypen.Kartentemperatur_Eiszeit_Enum  => KartenDatentypen.Kartentemperatur_Eiszeit_Enum,
                                                                                           RueckgabeDatentypen.Kartentemperatur_Wüste_Enum    => KartenDatentypen.Kartentemperatur_Wüste_Enum
                                                                                          );
   
   type KartenressourcenRückgabeZuKartenArray is array (RueckgabeDatentypen.Kartenressourcen_Enum'Range) of KartenDatentypen.Kartenressourcen_Enum;
   KartenressourcenRückgabeZuKarten : constant KartenressourcenRückgabeZuKartenArray := (
                                                                                           RueckgabeDatentypen.Kartenressourcen_Arm_Enum       => KartenDatentypen.Kartenressourcen_Arm_Enum,
                                                                                           RueckgabeDatentypen.Kartenressourcen_Wenig_Enum     => KartenDatentypen.Kartenressourcen_Wenig_Enum,
                                                                                           RueckgabeDatentypen.Kartenressourcen_Mittel_Enum    => KartenDatentypen.Kartenressourcen_Mittel_Enum,
                                                                                           RueckgabeDatentypen.Kartenressourcen_Viel_Enum      => KartenDatentypen.Kartenressourcen_Viel_Enum,
                                                                                           RueckgabeDatentypen.Kartenressourcen_Überfluss_Enum => KartenDatentypen.Kartenressourcen_Überfluss_Enum
                                                                                          );
   
   procedure GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum);
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum);
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;
   
      
   
   ------------------------------ Post kleiner als Kartengröße?
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural;

end SpieleinstellungenKarten;
