with LadezeitenDatentypen;
with SpeziesDatentypen;

with LeseSpeziesbelegung;

with SpeichernStaedteLogik;
with SpeichernEinheitenLogik;
with SpeichernDiplomatieLogik;
with SpeichernSpezienspezifischesLogik;
with SpielstandAllgemeinesLogik;
with LadezeitenLogik;

package body SpeichernSpeziesLogik is
   
   function Spezieswerte
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      LadezeitBasis := 100.00 / Float (SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True));
      Ladezeit := LadezeitBasis;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               if
                 LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert) = True
               then
                  null;
            
               elsif
                 False = SpeichernSpezienspezifischesLogik.Aufteilung (SpeziesExtern        => SpeziesSchleifenwert,
                                                                       DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
            
               elsif
                 False = SpeichernEinheitenLogik.Einheiten (SpeziesExtern        => SpeziesSchleifenwert,
                                                            DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
            
               elsif
                 False = SpeichernStaedteLogik.Städte (SpeziesExtern        => SpeziesSchleifenwert,
                                                        DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
           
               elsif
                 False = SpeichernDiplomatieLogik.Diplomatie (SpeziesExtern        => SpeziesSchleifenwert,
                                                              DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
            
               else
                  null;
               end if;
         
               LadezeitenLogik.SpeichernLaden (BerechnungszeitExtern => LadezeitenDatentypen.Spezies_Enum,
                                               ZeitExtern            => Ladezeit);
         
               Ladezeit := Ladezeit + LadezeitBasis;
         
               if
                 Ladezeit > 100.00
               then
                  Ladezeit := 100.00;
            
               else
                  null;
               end if;
         end case;
         
      end loop SpeziesSchleife;
      
      LadezeitenLogik.SpeichernLadenMaximum (BerechnungszeitExtern => LadezeitenDatentypen.Spezies_Enum);
      
      return True;
      
   end Spezieswerte;

end SpeichernSpeziesLogik;
