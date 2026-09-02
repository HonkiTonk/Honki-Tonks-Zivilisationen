with SpeziesDatentypen;
with LadezeitenDatentypen;

with SpielstandAllgemeinesLogik;
with LadenSpezienspezifischesLogik;
with LadenDiplomatieLogik;
with LadenEinheitenLogik;
with LadenStaedteLogik;
with LadezeitenLogik;

package body LadenSpeziesLogik is
   
   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      LadezeitBasis := 100.00 / Float (SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => False));
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               if
                 SpielstandAllgemeinesLogik.SpeziesBesiegtLesen (SpeziesExtern => SpeziesSchleifenwert) = True
               then
                  null;
            
               elsif
                 False = LadenSpezienspezifischesLogik.Aufteilung (LadenPrüfenExtern => LadenPrüfenExtern,
                                                                   SpeziesExtern     => SpeziesSchleifenwert,
                                                                   DateiLadenExtern  => DateiLadenExtern)
               then
                  return False;
            
               elsif
                 False = LadenEinheitenLogik.Einheiten (LadenPrüfenExtern => LadenPrüfenExtern,
                                                        SpeziesExtern     => SpeziesSchleifenwert,
                                                        DateiLadenExtern  => DateiLadenExtern)
               then
                  return False;
            
               elsif
                 False = LadenStaedteLogik.Städte (LadenPrüfenExtern => LadenPrüfenExtern,
                                                    SpeziesExtern     => SpeziesSchleifenwert,
                                                    DateiLadenExtern  => DateiLadenExtern)
               then
                  return False;
            
               elsif
                 False = LadenDiplomatieLogik.Diplomatie (LadenPrüfenExtern => LadenPrüfenExtern,
                                                          SpeziesExtern     => SpeziesSchleifenwert,
                                                          DateiLadenExtern  => DateiLadenExtern)
               then
                  return False;
            
               else
                  null;
               end if;
         
               LadezeitenLogik.SpielstandSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Spezies_Enum,
                                                    ZeitExtern            => LadezeitBasis);
         end case;
         
      end loop SpeziesSchleife;
      
      LadezeitenLogik.SpielstandMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Spezies_Enum);
      
      return True;
      
   end SpezieswerteLaden;

end LadenSpeziesLogik;
