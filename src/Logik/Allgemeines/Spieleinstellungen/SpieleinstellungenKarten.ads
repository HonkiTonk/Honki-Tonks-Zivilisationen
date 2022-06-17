pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;
with KartenDatentypen;
with SystemRecords;
with KartenRecords;

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
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   ZwischenwertKartenart : Positive;
   
   BenutzerdefinierteGröße : SystemRecords.ZahlenEingabeRecord;
   BenutzerdefinierteKartenart : SystemRecords.ZahlenEingabeRecord;
   
   type KartenartRückgabeZuKartenArray is array (RueckgabeDatentypen.Kartenart_Enum'Range) of KartenDatentypen.Kartenart_Enum;
   KartenartRückgabeZuKarten : constant KartenartRückgabeZuKartenArray := (
                                                                             RueckgabeDatentypen.Kartenart_Inseln_Enum        => KartenDatentypen.Kartenart_Inseln_Enum,
                                                                             RueckgabeDatentypen.Kartenart_Kontinente_Enum    => KartenDatentypen.Kartenart_Kontinente_Enum,
                                                                             RueckgabeDatentypen.Kartenart_Pangäa_Enum        => KartenDatentypen.Kartenart_Pangäa_Enum
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
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum);
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;
   
      
   
   ------------------------------ Post kleiner als Kartengröße?
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural;
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord;

end SpieleinstellungenKarten;
