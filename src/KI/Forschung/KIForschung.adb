pragma SPARK_Mode (On);

with GlobaleKonstanten;

with ForschungsDatenbank;

with ForschungAllgemein, LeseForschungsDatenbank;

package body KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
                   LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                 IDExtern                => TechnologieSchleifenwert,
                                                                 WelcheAnforderungExtern => 1) = GlobaleKonstanten.LeerForschungAnforderung
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
                     
                     exit ForschungMöglichSchleife when LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                       IDExtern                => TechnologieSchleifenwert,
                                                                                                       WelcheAnforderungExtern => AnforderungenSchleifenwert) = GlobaleKonstanten.LeerForschungAnforderung;
                     
                     AnforderungVorhanden := AnforderungVorhanden + 1;
                     
                     if
                       GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (LeseForschungsDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                                         IDExtern                => TechnologieSchleifenwert,
                                                                                                                         WelcheAnforderungExtern => AnforderungenSchleifenwert)) = True
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
