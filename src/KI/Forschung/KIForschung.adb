pragma SPARK_Mode (On);

with ForschungsDatenbank;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt
      is
         when 0 =>      
            ForschungSchleife:
            for TechnologieSchleifenwert in ForschungsDatenbank.ForschungListeArray'Range (2) loop
               
               if
                 GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (TechnologieSchleifenwert) = True
               then
                  null;
                  
               elsif
                 GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (TechnologieSchleifenwert) = False
                 and
                   ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (1) = 0
               then
                  GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt := TechnologieSchleifenwert;
                  GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge := 0;
                  ForschungAllgemein.ForschungZeit (RasseExtern => RasseExtern);
                  return;
                  
               else
                  AnforderungVorhanden := 0;
                  AnforderungErfüllt := 0;
                  
                  ForschungMöglichSchleife:
                  for AnforderungenSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
                     
                     case
                       ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (AnforderungenSchleifenwert)
                     is
                        when 0 =>
                           exit ForschungMöglichSchleife;
                           
                        when others =>
                           AnforderungVorhanden := AnforderungVorhanden + 1;
                     end case;
                     
                     if
                       GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (AnforderungenSchleifenwert)) = True
                     then
                        AnforderungErfüllt := AnforderungErfüllt + 1;
                    
                     else
                        null;
                     end if;
                     
                  end loop ForschungMöglichSchleife;
                  
                  if
                    AnforderungVorhanden - AnforderungErfüllt = 0
                  then
                     GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt := TechnologieSchleifenwert;
                     GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge := 0;
                     ForschungAllgemein.ForschungZeit (RasseExtern => RasseExtern);
                     return;
                     
                  else
                     null;
                  end if;
               end if;
               
            end loop ForschungSchleife;
            
         when others =>
            null;
      end case;
      
   end Forschung;

end KIForschung;
