with EinheitenDatentypen;
with ProduktionDatentypen;
with EinheitenKonstanten;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with MeldungenSetzenLogik;
with AufgabenAllgemeinLogik;
with WegeplatzierungssystemLogik;
with WaldAnlegenLogik;
with RodenAnlegenLogik;
with VerbesserungAnlegenLogik;

package body VerbesserungFertiggestelltLogik is

   procedure VerbesserungFertiggestellt
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseSchleifenwert) loop
         
                  case
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert))
                  is
                     when EinheitenKonstanten.LeerID =>
                        null;

                     when others =>
                        VerbesserungFertiggestelltPrüfen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end case;
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung | AufgabenDatentypen.Heilen_Enum | AufgabenDatentypen.Verschanzen_Enum =>
            return;
               
         when others =>
            null;
      end case;

      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => -1,
                                                   RechnenSetzenExtern      => True);
      
      if
        LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigungszeit
      then
         MeldungenSetzenLogik.EinheitmeldungSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                EreignisExtern           => EinheitenDatentypen.Aufgabe_Abgeschlossen_Enum);
         VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AufgabeNachfolgerVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end VerbesserungFertiggestelltPrüfen;
   
   
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
            AufgabenAllgemeinLogik.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         RechnenSetzenExtern      => False);
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                                                   RechnenSetzenExtern      => False);
      end case;
      
   end AufgabeNachfolgerVerschieben;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WelcheAufgabe := LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        WelcheAufgabe
      is
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            WegeplatzierungssystemLogik.Wegplatzierung (KoordinatenExtern => Koordinaten,
                                                        WegartExtern      => WelcheAufgabe);
            
         when AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range =>
            VerbesserungAnlegenLogik.VerbesserungAnlegen (KoordinatenExtern  => Koordinaten,
                                                          VerbesserungExtern => WelcheAufgabe);
              
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            WaldAnlegenLogik.WaldAnlegen (KoordinatenExtern => Koordinaten);
              
         when AufgabenDatentypen.Roden_Trockenlegen_Enum =>
            RodenAnlegenLogik.RodenAnlegen (KoordinatenExtern => Koordinaten);
      end case;
      
   end VerbesserungAngelegt;

end VerbesserungFertiggestelltLogik;
