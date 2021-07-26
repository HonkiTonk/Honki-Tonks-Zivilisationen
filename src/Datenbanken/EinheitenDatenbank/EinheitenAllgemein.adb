pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleKonstanten, GlobaleTexte;

with EinheitenDatenbank;

with KIDatentypen;

with Auswahl, Anzeige, Eingabe, Sichtbarkeit;

package body EinheitenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => Positive (IDExtern),
                                     LetzteZeileExtern      => Positive (IDExtern),
                                     AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                     AbstandMitteExtern     => GlobaleTexte.Keiner,
                                     AbstandEndeExtern      => GlobaleTexte.Keiner);
      
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
         EinheitenSchleife:
         for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
            if
              GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
            then
               exit EinheitenSchleife;

            elsif GlobaleVariablen.EinheitenGebaut (RasseSchleifenwert, EinheitNummerSchleifenwert).ID = GlobaleKonstanten.LeerEinheit.ID then
               null;
                  
            else
               HeilungBewegungspunkteNeueRundeSetzen (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitNummerSchleifenwert));
            end if;            
            
         end loop EinheitenSchleife;
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
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      -- ID, AchsenPosition
      -- Lebenspunkte, Bewegungspunkte, Erfahrungspunkte, Rang
      -- Beschäftigung, Zweite Beschäftigung
      -- Beschäftigungszeit, Zweite Beschäftigungszeit
      -- Zielkoordinaten der KI, Beschäftigung der KI, Bewegungsplan der KI
      -- Platznummer der transportierten Einheiten, Platznummer der transportierenden Einheit
            
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) :=
        (
         IDExtern, KoordinatenExtern,
         0, 0.00, 0, 0,
         GlobaleDatentypen.Nicht_Vorhanden, GlobaleDatentypen.Nicht_Vorhanden,
         0, 0,
         (0, 0, 0), KIDatentypen.Keine_Aufgabe, (others => (0, 0, 0)),
         (others => 0), 0
        );
      
      LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Sichtbarkeit.SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end EinheitErzeugen;



   procedure EinheitEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeerEinheit;
      
   end EinheitEntfernen;
   
   

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
                                           AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                           AbstandMitteExtern     => GlobaleTexte.Keiner,
                                           AbstandEndeExtern      => GlobaleTexte.Keiner);
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Beschäftigung_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           -- Der Abzug wird für die Textanzeige benötigt
                                           ErsteZeileExtern       => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - GlobaleKonstanten.EinheitBefehlAbzug,
                                           LetzteZeileExtern      => GlobaleDatentypen.Tastenbelegung_Befehle_Enum'Pos (ArbeitExtern) - GlobaleKonstanten.EinheitBefehlAbzug,
                                           AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                           AbstandMitteExtern     => GlobaleTexte.Keiner,
                                           AbstandEndeExtern      => GlobaleTexte.Keiner);
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
     
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp;
   
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
      
      return EinheitenDatenbank.EinheitenListe (TransporterExtern.Rasse, GlobaleVariablen.EinheitenGebaut (TransporterExtern.Rasse, TransporterExtern.Platznummer).ID).Transportkapazität;
      
   end MaximaleTransporterKapazität;

end EinheitenAllgemein;
