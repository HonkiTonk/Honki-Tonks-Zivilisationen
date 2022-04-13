pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with KartenDatentypen;
with SystemRecords;

package SpieleinstellungenKarten is
   
   procedure KartengrößeWählen;
   procedure KartenartWählen;
   procedure KartenformWählen;
   procedure KartentemperaturWählen;
   procedure KartenressourcenWählen;
   
private
         
   KartengrößeAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenartAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenformAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartentemperaturAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   KartenressourcenAuswahl : SystemDatentypen.Rückgabe_Werte_Enum;
   
   BenutzerdefinierteGröße : SystemRecords.ZahlenEingabeRecord;
   
   procedure GrößeSelbstBestimmen
     (KartengrößeExtern : in KartenDatentypen.Kartengröße_Enum);

end SpieleinstellungenKarten;
