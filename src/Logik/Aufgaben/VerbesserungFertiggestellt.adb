pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

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
         when SystemKonstanten.LeerTastenbelegungKonstante | SystemKonstanten.HeilenKonstante | SystemKonstanten.VerschanzenKonstante =>
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
         when SystemKonstanten.LeerTastenbelegungKonstante =>
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
                                                              BeschäftigungExtern     => SystemKonstanten.LeerTastenbelegungKonstante);
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
         when SystemKonstanten.StraßeBauenKonstante =>
            VerbesserungWeg.WegBerechnen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
              
         when SystemKonstanten.MineBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Mine);
            
         when SystemKonstanten.FarmBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Farm);
            
         when SystemKonstanten.FestungBauenKonstante =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern    => KartenDatentypen.Festung);
              
         when SystemKonstanten.WaldAufforstenKonstante =>
            VerbesserungWaldAufforsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
         when SystemKonstanten.RodenTrockenlegenKonstante =>
            if
              LeseKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
            then
               SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern       => KartenDatentypen.Hügel);
                  
            else
               SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                     GrundExtern       => KartenDatentypen.Flachland);
            end if;
            
         when others =>
            null;
      end case;

      FelderwerteFestlegen.EinzelnesKartenfeldBewerten (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end VerbesserungAngelegt;
   
   
   
   procedure VerbesserungWaldAufforsten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Hügel
      then
         SchreibeKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                HügelExtern       => True);
               
      else
         null;
      end if;
            
      SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                            GrundExtern       => KartenDatentypen.Wald);
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenDatentypen.Karten_Verbesserung_Gebilde_Friedlich_Enum'Range
      then
         SchreibeKarten.VerbesserungGebiet (KoordinatenExtern     => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            VerbesserungExtern    => KartenDatentypen.Leer_Verbesserung);
                  
      else
         null;
      end if;
      
   end VerbesserungWaldAufforsten;

end VerbesserungFertiggestellt;
