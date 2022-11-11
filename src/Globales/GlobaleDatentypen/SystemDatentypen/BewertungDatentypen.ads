package BewertungDatentypen is
   pragma Pure;

   type Bewertung_Enum is (
                           Bewertung_Eins_Enum, Bewertung_Zwei_Enum, Bewertung_Drei_Enum, Bewertung_Vier_Enum, Bewertung_Fünf_Enum,
                           
                           Bewertung_Sechs_Enum, Bewertung_Sieben_Enum, Bewertung_Acht_Enum, Bewertung_Neun_Enum, Bewertung_Zehn_Enum
                          );
   pragma Ordered (Bewertung_Enum);
   
   subtype Fehlschlag is Bewertung_Enum range Bewertung_Eins_Enum .. Bewertung_Fünf_Enum;
   subtype KritischerFehlschlag is Fehlschlag range Bewertung_Eins_Enum .. Bewertung_Eins_Enum;
   subtype NormalerFehlschlag is Fehlschlag range Bewertung_Zwei_Enum .. Bewertung_Fünf_Enum;
   
   subtype Erfolg is Bewertung_Enum range Bewertung_Sechs_Enum .. Bewertung_Zehn_Enum;
   subtype NormalerErfolg is Erfolg range Bewertung_Sechs_Enum .. Bewertung_Neun_Enum;
   subtype KritischerErfolg is Erfolg range Bewertung_Zehn_Enum .. Bewertung_Zehn_Enum;

end BewertungDatentypen;
