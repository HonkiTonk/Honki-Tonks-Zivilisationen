pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with EinheitenMeldungenSetzen;
with FelderwerteFestlegen;
with AufgabenAllgemein;
with Wegeplatzierungssystem;
with WaldAnlegen;
with RodenAnlegen;
with VerbesserungAnlegen;

package body VerbesserungFertiggestellt is

   procedure VerbesserungFertiggestellt
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
         
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung | AufgabenDatentypen.Heilen_Enum | AufgabenDatentypen.Verschanzen_Enum =>
            return;
               
         when others =>
            null;
      end case;

      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => 1,
                                                   RechnenSetzenExtern      => -1);
      
      if
        LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Beschäftigungszeit
      then
         EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                EreignisExtern           => EinheitStadtDatentypen.Aufgabe_Abgeschlossen_Enum);
         VerbesserungAngelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AufgabeNachfolgerVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end VerbesserungFertiggestelltPrüfen;
   
   
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                                   RechnenSetzenExtern      => 0);
      end case;
      
   end AufgabeNachfolgerVerschieben;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      WelcheAufgabe := LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        WelcheAufgabe
      is
         when AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range =>
            Wegeplatzierungssystem.WegBerechnen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WegartExtern      => WelcheAufgabe);
              
         when AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range =>
            VerbesserungAnlegen.VerbesserungAnlegen (KoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                     VerbesserungExtern => WelcheAufgabe);
              
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            WaldAnlegen.WaldAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
         when AufgabenDatentypen.Roden_Trockenlegen_Enum =>
            RodenAnlegen.RodenAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;

      FelderwerteFestlegen.EinzelnesKartenfeldBewerten (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end VerbesserungAngelegt;

end VerbesserungFertiggestellt;
