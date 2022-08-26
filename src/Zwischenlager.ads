



-- Später abfragen für Menschen und KI für die jeweiligen Möglichkeiten einbauen.
function DiplomatischenStatusÄndern
  (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
   KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
is begin

   -- StatusAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Diplomatie,
   --                                  TextDateiExtern   => GlobaleTexte.Diplomatie,
   --                                  FrageZeileExtern  => 3,
   --                                  ErsteZeileExtern  => 9,
   --                                  LetzteZeileExtern => 12);

   case
     StatusAuswahl
   is
      when 1 .. 2 =>
         KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                  RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                  NeuerStatusExtern => SystemDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
         return RueckgabeDatentypen.Start_Weiter_Enum;

         -- Ist dazu da um im Kriegsfall sofort das Diplomatiemenü zu schließen.
      when 3 =>
         KriegJetzt := DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                  RasseZweiExtern   => KontaktierteRasseExtern,
                                                                                  NeuerStatusExtern => SystemDatentypen.Status_Untereinander_Enum'Val (StatusAuswahl));
         if
           KriegJetzt
         then
            return RueckgabeDatentypen.Zurück_Enum;

         else
            return RueckgabeDatentypen.Start_Weiter_Enum;
         end if;

      when others =>
         -- Start_Weiter_Enum ist hier nur weil ich das Leer_Enum aus den Rückgabe_Werte_Enum entfernt habe.
         return RueckgabeDatentypen.Start_Weiter_Enum;
   end case;

end DiplomatischenStatusÄndern;



