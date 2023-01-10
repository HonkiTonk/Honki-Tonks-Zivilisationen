with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with GebaeudeAllgemeinLogik;

package body StadtGebaeudeBauenLogik is

   procedure GebäudeFertiggestellt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebaeudeAllgemeinLogik.GebäudeProduktionBeenden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        IDExtern               => StadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Gebäude));
            
      if
        LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Mensch_Spieler_Enum
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Keine_Aufgabe_Enum);
               
      else
         -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => Meldungstexte.Zeug,
         --                                      TextZeileExtern => 29);
         null;
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauenLogik;
