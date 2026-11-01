with LadezeitenDatentypen;

with KartengeneratorKuesteLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRohstoffeLogik;
with KartengeneratorBasisaufteilungLogik;
with KartengeneratorZusatzaufteilungLogik;
with LadezeitenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      PrüfeEinstellungen;
      
      KartengeneratorBasisaufteilungLogik.Kartenbasis;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Basisstrukturen_Enum);
      
      -- Küste später mit in die Landschaft schieben? äöü
      -- Kann ich bei der Basis noch nicht anwenden, da das Feld danach ja noch nicht festgelegt ist. äöü
      KartengeneratorKuesteLogik.Küste;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorZusatzaufteilungLogik.Kartenzusatz;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Zusatzstrukturen_Enum);
      
      KartengeneratorFlussLogik.GenerierungFlüsse;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      KartengeneratorRohstoffeLogik.Rohstoffgenerierung;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Rohstoffe_Enum);
      
   end Kartengenerator;
   
   
   
   -- Später hier Prüfungen auf korrekte Werte einbauen. äöü
   -- Oder alle Prüfungen direkt in die Einstellungen werfen? äöü
   procedure PrüfeEinstellungen
   is begin
      
      null;
      
   end PrüfeEinstellungen;

end KartengeneratorLogik;
