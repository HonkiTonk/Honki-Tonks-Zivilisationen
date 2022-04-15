pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;
with KartenDatentypen;
with SystemRecords;

package SpieleinstellungenKarten is
   
   procedure KartengrößeWählen;
   procedure KartenartWählen;
   procedure KartenformWählen;
   procedure KartentemperaturWählen;
   procedure KartenressourcenWählen;
   
private
         
   KartengrößeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartentemperaturAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenressourcenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   BenutzerdefinierteGröße : SystemRecords.ZahlenEingabeRecord;
   
   procedure GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum);

end SpieleinstellungenKarten;
