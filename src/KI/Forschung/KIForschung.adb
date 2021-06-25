pragma SPARK_Mode (On);

with ForschungsDatenbank;

with ForschungAllgemein;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt
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
                  GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := TechnologieSchleifenwert;
                  GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := 0;
                  ForschungAllgemein.ForschungZeit (RasseExtern => RasseExtern);
                  return;
                  
               else
                  AnforderungVorhanden := 0;
                  AnforderungErfüllt := 0;
                  
                  ForschungMöglichSchleife:
                  for AnforderungenSchleifenwert in GlobaleDatentypen.AnforderungForschungArray'Range loop
                     
                     exit ForschungMöglichSchleife when ForschungsDatenbank.ForschungListe (RasseExtern, TechnologieSchleifenwert).AnforderungForschung (AnforderungenSchleifenwert) = 0;
                     
                     AnforderungVorhanden := AnforderungVorhanden + 1;
                     
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
                     GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := TechnologieSchleifenwert;
                     GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := 0;
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
