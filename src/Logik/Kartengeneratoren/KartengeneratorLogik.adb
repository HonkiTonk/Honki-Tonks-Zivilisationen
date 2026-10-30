with LadezeitenDatentypen;

with KartengeneratorKuesteLogik;
with KartengeneratorLandschaftLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRohstoffeLogik;
with KartengeneratorUnterflaecheLogik;
with KartengeneratorBasisLogik;
with LadezeitenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      PrüfeEinstellungen;
      
      KartengeneratorBasisLogik.Kartenbasis;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
      KartengeneratorKuesteLogik.GenerierungKüstenSeeGewässer;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorLandschaftLogik.GenerierungLandschaft;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      KartengeneratorUnterflaecheLogik.GenerierungLandschaft;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
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
