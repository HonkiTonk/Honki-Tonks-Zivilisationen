pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with SchreibeEinheitenGebaut, SchreibeStadtGebaut;
with LeseEinheitenGebaut, LeseEinheitenDatenbank;

with Auswahl, Anzeige, Sichtbarkeit, StadtProduktion, RasseEntfernen, EinheitSuchen, StadtSuchen, BewegungPassierbarkeitPruefen;

package body EinheitenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Positive (IDExtern),
                                     LetzteZeileExtern      => Positive (IDExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Leer);
      
   end Beschreibung;



   procedure HeilungBewegungspunkteNeueRundeErmitteln
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
           
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                              
                  if
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert)) = GlobaleKonstanten.LeerEinheit.ID
                  then
                     null;
                  
                  else
                     HeilungBewegungspunkteNeueRundeSetzen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
                  end if;            
            
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteNeueRundeErmitteln;



   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleDatentypen.Leer
      then
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                  RechnenSetzenExtern      => 0);

      else
         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                                  RechnenSetzenExtern      => 0);
      end if;

      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleDatentypen.Heilen | GlobaleDatentypen.Verschanzen =>
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  LebenspunkteExtern       => Heilungsrate,
                                                  RechnenSetzenExtern      => 1);
            
         when others =>
            null;
      end case;
      
   end HeilungBewegungspunkteNeueRundeSetzen;
   


   procedure EinheitErzeugen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                  IDExtern                 => IDExtern);
      
      SchreibeEinheitenGebaut.Position (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                        PositionExtern           => KoordinatenExtern);
      
      SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                           HeimatstadtExtern        => StadtRasseNummerExtern.Platznummer);
      
      SchreibeEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                            LebenspunkteExtern       =>
                                              LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern    => IDExtern),
                                            RechnenSetzenExtern      => 0);
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern),
                                               BewegungspunkteExtern    =>
                                                 LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                 IDExtern    => IDExtern),
                                               RechnenSetzenExtern      => 0);
      
      case
        StadtRasseNummerExtern.Platznummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;

         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 IDExtern                => IDExtern,
                                                 VorzeichenWechselExtern => 1);
      end case;
      
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      
   end EinheitErzeugen;



   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;

         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                 IDExtern                => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 VorzeichenWechselExtern => -1);
      end case;

      SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end EinheitEntfernen;
   
   
   
   procedure PermanenteKostenDurchEinheitÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleRecords.PermanenteKostenArray'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                    IDExtern           => IDExtern,
                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert) <= 0
         then
            null;
            
         else
            SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                        KostenExtern           =>
                                                          GesamtePermanenteKosten (VorzeichenWechselExtern) * LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                                                       IDExtern           => IDExtern,
                                                                                                                                                       WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtProduktion.StadtProduktionBerechnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end PermanenteKostenDurchEinheitÄndern;
   
   

   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      case
        ArbeitExtern
      is
         when GlobaleDatentypen.Leer =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 9,
                                           LetzteZeileExtern      => 9,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           -- Der Abzug wird für die Textanzeige benötigt
                                           ErsteZeileExtern       => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - GlobaleKonstanten.EinheitBefehlAbzug,
                                           LetzteZeileExtern      => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - GlobaleKonstanten.EinheitBefehlAbzug,
                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                                           AbstandEndeExtern      => GlobaleTexte.Leer);
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean
   is begin
      
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => WelcheAuswahlExtern)
      is
         when GlobaleKonstanten.JaKonstante =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        EinheitRasseNummerExtern.Platznummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position);
            
         when others =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
      end case;
      
      StadtNummerNeu := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                    KoordinatenExtern => GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position);
      
      if
        EinheitNummer = GlobaleKonstanten.LeerEinheitStadtNummer
        or
          StadtNummerNeu = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return;
         
      elsif
        StadtNummerNeu = LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))
      then
         return;
         
      else
         null;
      end if;
      
      StadtNummerAlt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer));
      
      case
        StadtNummerAlt
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;
            
         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummerAlt),
                                                 IDExtern                => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)),
                                                 VorzeichenWechselExtern => -1);
      end case;
      
      SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer),
                                           HeimatstadtExtern        => StadtNummerNeu);
      
      PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummerNeu),
                                           IDExtern                => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)),
                                           VorzeichenWechselExtern => 1);
      
   end HeimatstadtÄndern;
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return Boolean
   is begin
      
      case
        BewegungPassierbarkeitPruefen.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 EinheitenIDExtern      => IDExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => IDExtern)
        = GlobaleKonstanten.LeerForschungAnforderung
        or else
          GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (LeseEinheitenDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                     IDExtern    => IDExtern))
        = True
      then
         return True;
         
      else
         return False;
      end if;
      
   end EinheitAnforderungenErfüllt;

end EinheitenAllgemein;
