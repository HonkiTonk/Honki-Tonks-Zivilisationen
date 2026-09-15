with LadezeitenDatentypen;
with KartenRecordKonstanten;
with KartenArrays;

with KartengeneratorKuesteLogik;
with KartengeneratorLandschaftLogik;
with KartengeneratorFlussLogik;
with KartengeneratorRohstoffeLogik;
with KartengeneratorUnterflaecheLogik;
with KartengeneratorAllgemeinesLogik;
with LadezeitenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorLogik is

   procedure Kartengenerator
   is begin
      
      PrüfeEinstellungen;
      
      KartengeneratorAllgemeinesLogik.GenerierungAllgemeines;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Allgemeines_Enum);
      
      KartengeneratorKuesteLogik.GenerierungKüstenSeeGewässer;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
      
      KartengeneratorLandschaftLogik.GenerierungLandschaft;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
      
      KartengeneratorUnterflaecheLogik.GenerierungLandschaft;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
      
      KartengeneratorFlussLogik.GenerierungFlüsse;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
      
      KartengeneratorRohstoffeLogik.Rohstoffe;
      LadezeitenLogik.KartengeneratorMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Rohstoffe_Enum);
      
   end Kartengenerator;
   
   
   
   -- Setzt im Moment nur die Rohstoffe und kann deswegen nicht entfernt werden, später mal erweitern. äöü
   -- Beim Erweitern auch Prüfungen auf korrekte Werte einbauen. äöü
   procedure PrüfeEinstellungen
   is begin
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenArrays.KartenrohstoffeWahrscheinlichkeitenArray'Range loop
         
         KartengeneratorVariablenLogik.RohstoffwahrscheinlichkeitenSchreiben
           (RohstoffExtern           => RohstoffeSchleifenwert,
            WahrscheinlichkeitExtern => KartenRecordKonstanten.StandardKartenrohstoffeWahrscheinlichkeiten (KartengeneratorVariablenLogik.Kartenparameter.Kartenrohstoffe, RohstoffeSchleifenwert));
         
      end loop RohstoffeSchleife;
      
   end PrüfeEinstellungen;

end KartengeneratorLogik;
