with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with GebaeudeAllgemeinLogik;
with MeldungssystemHTSEB;

package body StadtGebaeudeBauenLogik is

   procedure GebäudeFertiggestellt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebaeudeAllgemeinLogik.GebäudeProduktionBeenden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        IDExtern                 => StadtDatentypen.GebäudeIDVorhanden (LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Gebäude));
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                  BeschäftigungExtern      => KIDatentypen.Keine_Aufgabe_Enum);
            
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            null;
            
         when SpeziesDatentypen.Leer_Spieler_Enum =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "StadtGebaeudeBauenLogik.GebäudeFertiggestellt: Unbelegte Spezies");
      end case;
      
   end GebäudeFertiggestellt;

end StadtGebaeudeBauenLogik;
