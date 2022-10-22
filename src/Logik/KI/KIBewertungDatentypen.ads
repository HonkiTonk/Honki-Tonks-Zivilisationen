pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIBewertungDatentypen is
   
   -- Wäre das nicht sinnvoller in ProduktionDatentypen? äöü
   type GesamteFeldbewertung is range 0 .. 750;
   subtype Einzelbewertung is GesamteFeldbewertung range 0 .. 10;

   type Bewertung_Enum is (
                           Bewertung_Null_Enum, Bewertung_Eins_Enum, Bewertung_Zwei_Enum, Bewertung_Drei_Enum, Bewertung_Vier_Enum, Bewertung_Fünf_Enum, Bewertung_Sechs_Enum, Bewertung_Sieben_Enum, Bewertung_Acht_Enum,
                           Bewertung_Neun_Enum, Bewertung_Zehn_Enum
                          );
   pragma Ordered (Bewertung_Enum);

end KIBewertungDatentypen;
