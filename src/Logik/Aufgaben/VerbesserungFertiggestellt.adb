pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with KartenVerbesserungKonstanten;
with TastenbelegungKonstanten;

with KIDatentypen;

with SchreibeEinheitenGebaut;
with SchreibeKarten;
with LeseEinheitenGebaut;
with LeseKarten;

with EinheitenMeldungenSetzen;
with FelderwerteFestlegen;
with VerbesserungWeg;
with AufgabenAllgemein;

package body VerbesserungFertiggestellt is

   procedure VerbesserungFertiggestellt
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
         
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
         when TastenbelegungKonstanten.LeerTastenbelegungKonstante | TastenbelegungKonstanten.HeilenKonstante | TastenbelegungKonstanten.VerschanzenKonstante =>
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
                                                                EreignisExtern           => EinheitStadtDatentypen.Aufgabe_Abgeschlossen);
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
         when TastenbelegungKonstanten.LeerTastenbelegungKonstante =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => LeseEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => LeseEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              BeschäftigungExtern     => TastenbelegungKonstanten.LeerTastenbelegungKonstante);
            SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                                   RechnenSetzenExtern      => 0);
      end case;
      
   end AufgabeNachfolgerVerschieben;



   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when TastenbelegungKonstanten.StraßeBauenKonstante =>
            VerbesserungWeg.WegBerechnen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
              
         when TastenbelegungKonstanten.MineBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Mine);
            
         when TastenbelegungKonstanten.FarmBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Farm);
            
         when TastenbelegungKonstanten.FestungBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Festung);
              
         when TastenbelegungKonstanten.WaldAufforstenKonstante =>
            VerbesserungWaldAufforsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
         when TastenbelegungKonstanten.RodenTrockenlegenKonstante =>
            if
              LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
            then
               SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern       => KartenDatentypen.Hügel);
                  
            else
               SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern       => KartenDatentypen.Flachland);
            end if;
            
         when others =>
            null;
      end case;

      FelderwerteFestlegen.EinzelnesKartenfeldBewerten (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end VerbesserungAngelegt;
   
   
   
   procedure VerbesserungWaldAufforsten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Hügel
      then
         SchreibeKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                HügelExtern       => True);
               
      else
         null;
      end if;
            
      SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                            GrundExtern       => KartenDatentypen.Wald);
      
      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range
      then
         SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            VerbesserungExtern    => KartenVerbesserungKonstanten.LeerVerbesserungGebiet);
                  
      else
         null;
      end if;
      
   end VerbesserungWaldAufforsten;

end VerbesserungFertiggestellt;
