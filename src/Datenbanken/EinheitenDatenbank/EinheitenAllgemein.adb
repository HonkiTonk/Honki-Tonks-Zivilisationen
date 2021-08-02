pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleKonstanten, GlobaleTexte;

with EinheitenDatenbank;

with Auswahl, Anzeige, Eingabe, Sichtbarkeit, StadtProduktion, RasseEntfernen, EinheitSuchen, StadtSuchen;

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



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
        := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



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
                    GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = GlobaleKonstanten.LeerEinheit.ID
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
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Nicht_Vorhanden
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
           := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleBewegungspunkte;

      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := GlobaleKonstanten.LeerEinheit.Bewegungspunkte;
      end if;

      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Heilen
        and
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate
        >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
           := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := GlobaleKonstanten.LeerEinheit.Beschäftigungszeit;
                  
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Heilen
        and
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate
        < EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
           := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Verschanzen
        and
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate
        >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
           := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = GlobaleDatentypen.Verschanzen
        and
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate
        < EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).MaximaleLebenspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
           := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + Heilungsrate;
        
      else
         null;
      end if;
      
   end HeilungBewegungspunkteNeueRundeSetzen;
   


   procedure EinheitErzeugen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerExtern) := GlobaleKonstanten.LeerEinheit;
      GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerExtern).ID := IDExtern;
      GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerExtern).Position := KoordinatenExtern;
      GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerExtern).Heimatstadt := StadtRasseNummerExtern.Platznummer;
      
      case
        StadtRasseNummerExtern.Platznummer
      is
         when 0 =>
            null;

         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 IDExtern                => IDExtern,
                                                 VorzeichenWechselExtern => 1);
      end case;
      
      LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerExtern));
      
   end EinheitErzeugen;



   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        HeimatstadtErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when 0 =>
            null;

         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, HeimatstadtErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                                 IDExtern                => EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 VorzeichenWechselExtern => -1);
      end case;

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeerEinheit;
      RasseEntfernen.RasseExistenzPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end EinheitEntfernen;
   
   
   
   procedure PermanenteKostenDurchEinheitÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      VorzeichenWechselExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in GlobaleDatentypen.PermanenteKostenArray'Range loop
         
         if
           EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert) <= 0
         then
            null;
               
         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
           + GesamtePermanenteKosten (VorzeichenWechselExtern) * EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert) < 0
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert) := 0;
               
         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
           + GesamtePermanenteKosten (VorzeichenWechselExtern) * EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert)
           > GlobaleDatentypen.GesamtePermanenteKosten'Last
         then
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert) := GlobaleDatentypen.GesamtePermanenteKosten'Last;
               
         else
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (PermanenteKostenSchleifenwert)
              + GesamtePermanenteKosten (VorzeichenWechselExtern) * EinheitenDatenbank.EinheitenListe (StadtRasseNummerExtern.Rasse, IDExtern).PermanenteKosten (PermanenteKostenSchleifenwert);
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
         when GlobaleDatentypen.Nicht_Vorhanden =>
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



   function EinheitTransporterAuswählen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin

      Anzeige.AllgemeineAnzeigeText := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Anzeige.AllgemeineAnzeigeText (1) := (GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                                            Positive (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)), Positive (EinheitRasseNummerExtern.Platznummer));
      AktuellePosition := 2;
      Ende := 1;

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. MaximaleTransporterKapazität (TransporterExtern => EinheitRasseNummerExtern) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterPlatzSchleifenwert) = GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            null;
            
         else
            Anzeige.AllgemeineAnzeigeText (AktuellePosition)
              := (GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (GlobaleTexte.Beschreibungen_Einheiten_Kurz),
                  Positive (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterPlatzSchleifenwert)).ID)),
                  Positive (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterPlatzSchleifenwert)));

            AktuellePosition := AktuellePosition + 1;
            Ende := Ende + 1;
         end if;
         
      end loop TransporterSchleife;

      AktuelleAuswahl := 1;

      EinheitAuswählenSchleife:
      loop
         
         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");

         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fragen,
                                               TextZeileExtern => 27);
         Anzeige.AllgemeineAnzeige (AktuelleAuswahlExtern => GlobaleDatentypen.KartenverbesserungEinheitenID (AktuelleAuswahl));
                  
         case
           Eingabe.Tastenwert
         is               
            when GlobaleDatentypen.Hoch => 
               if
                 AktuelleAuswahl = Anzeige.AllgemeineAnzeigeText'First
               then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when GlobaleDatentypen.Runter =>
               if
                 AktuelleAuswahl = Ende
               then
                  AktuelleAuswahl := Anzeige.AllgemeineAnzeigeText'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when GlobaleDatentypen.Auswählen =>
               return GlobaleDatentypen.MaximaleEinheitenMitNullWert (Anzeige.AllgemeineAnzeigeText (AktuelleAuswahl).Nummer);

            when GlobaleDatentypen.Menü_Zurück =>
               return 0;
                     
            when others =>
               null;
         end case;
         
      end loop EinheitAuswählenSchleife;
      
   end EinheitTransporterAuswählen;
   
   
   
   function EinheitenTypErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Einheit_Art_Verwendet_Enum
   is begin
     
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitArt;
   
   end EinheitenTypErmitteln;
   
   
   
   function KannTransportiertWerden
     (LadungExtern, TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (LadungExtern.Rasse, GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).ID).KannTransportiertWerden
          = GlobaleKonstanten.LeerTransportiertWirdTransportiert
        or
          EinheitenDatenbank.EinheitenListe (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).ID).KannTransportieren
            < EinheitenDatenbank.EinheitenListe (LadungExtern.Rasse, GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).ID).KannTransportiertWerden
      then
         return False;
         
      else
         null;
      end if;
      
      PlatzFreiSchleife:
      for PlatzSchleifenwert in GlobaleRecords.TransporterArray'First .. MaximaleTransporterKapazität (TransporterExtern => TransporterExtern) loop
         
         if
           GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).Transportiert (PlatzSchleifenwert) = GlobaleKonstanten.LeerTransportiertWirdTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop PlatzFreiSchleife;
      
      return False;
      
   end KannTransportiertWerden;
   
   
   
   
   function IDTransporterAusLadung
     (LadungExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenIDMitNullWert
   is begin
      
      case
        GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).WirdTransportiert
      is
         when GlobaleKonstanten.LeerTransportiertWirdTransportiert =>
            return GlobaleKonstanten.LeerEinheit.ID;
            
         when others =>
            return GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, GlobaleVariablen.EinheitenGebaut (LadungExtern.Rasse, LadungExtern.Platznummer).WirdTransportiert).ID;
      end case;
      
   end IDTransporterAusLadung;
   
   
   
   function MaximaleTransporterKapazität
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).ID).Transportkapazität
          <= GlobaleRecords.TransporterArray'Last
      then
         return EinheitenDatenbank.EinheitenListe (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).ID).Transportkapazität;
         
      else
         return GlobaleRecords.TransporterArray'Last;
      end if;
      
   end MaximaleTransporterKapazität;
   
   
   
   procedure Beförderung
     (EinheitRasseNummerExtern, BesiegteEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      ErhalteneErfahrungspunkte := EinheitenDatenbank.EinheitenListe (BesiegteEinheitExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => BesiegteEinheitExtern)).Beförderungsgrenze / 5;
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte + ErhalteneErfahrungspunkte > GlobaleDatentypen.MaximaleStädte'Last
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := GlobaleDatentypen.MaximaleStädte'Last;
         
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
           := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte + ErhalteneErfahrungspunkte;
      end if;
      
      BeförderungSchleife:
      while GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
        >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Beförderungsgrenze loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
           >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Beförderungsgrenze
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang
           < EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).MaximalerRang
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
              - EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Beförderungsgrenze;            
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang
              := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang + 1;
         
         elsif
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
           >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Beförderungsgrenze
           and
             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang
           >= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).MaximalerRang
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
              := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).Beförderungsgrenze;
            exit BeförderungSchleife;
         
         else
            null;
         end if;
         
      end loop BeförderungSchleife;
      
   end Beförderung;
      
      
      
   function EinheitenIDErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenID
   is begin
         
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID;
         
   end EinheitenIDErmitteln;
   
   
   
   function PermanenteKosten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcheRessourceExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitenIDErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).PermanenteKosten (WelcheRessourceExtern);
      
   end PermanenteKosten;
   
   
   
   function HeimatstadtErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
         
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Heimatstadt;
         
   end HeimatstadtErmitteln;
   
   
   
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
        StadtNummerNeu = EinheitenAllgemein.HeimatstadtErmitteln (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))
      then
         return;
         
      else
         null;
      end if;
      
      StadtNummerAlt := HeimatstadtErmitteln (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer));
      
      case
        StadtNummerAlt
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            null;
            
         when others =>
            PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummerAlt),
                                                 IDExtern                => EinheitenIDErmitteln (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)),
                                                 VorzeichenWechselExtern => -1);
      end case;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Heimatstadt := StadtNummerNeu;
      
      PermanenteKostenDurchEinheitÄndern (StadtRasseNummerExtern  => (EinheitRasseNummerExtern.Rasse, StadtNummerNeu),
                                           IDExtern                => EinheitenIDErmitteln (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)),
                                           VorzeichenWechselExtern => 1);
      
   end HeimatstadtÄndern;

end EinheitenAllgemein;
