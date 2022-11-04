pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with GebaeudeAllgemeinLogik;

package body StadtGebaeudeBauenLogik is

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GebaeudeAllgemeinLogik.GebäudeProduktionBeenden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        IDExtern               => StadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Gebäude));
            
      if
        SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Mensch_Spieler_Enum
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Keine_Aufgabe_Enum);
               
      else
         -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => Meldungstexte.Zeug,
         --                                      TextZeileExtern => 29);
         null;
      end if;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauenLogik;
