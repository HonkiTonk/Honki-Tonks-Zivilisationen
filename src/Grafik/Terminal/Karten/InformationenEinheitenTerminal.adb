pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Wide_Wide_Text_IO;

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenbeschreibungenSFML;
with StadtInformationenTerminal;
with KampfwerteEinheitErmitteln;
with DebugmenueTerminal;

package body InformationenEinheitenTerminal is

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer := Allgemeines (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
       -- or
       --   DebugPlatzhalter.FeindlicheInformationenSehen
      then
         Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer);
         Angriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Verteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Rang (EinheitRasseNummerExtern => EinheitRasseNummer);
         Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuelleVerteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuellerAngriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
      else
         null;
      end if;
                        
      New_Line;
      DebugInformationen (EinheitRasseNummerExtern => EinheitRasseNummer);
      
   end Einheiten;
   
   
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
            
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Nummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      PlatzhalterText := EinheitenbeschreibungenSFML.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer)));
      New_Line;
      
      return (EinheitRasseNummerExtern.Rasse, EinheitNummer);
      
   end Allgemeines;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 14,
      --                                          LetzteZeileExtern      => 14,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                         Width => 1);
      Put (Item => " / ");
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                         IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                                         Width => 1);
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 15,
     --                                           LetzteZeileExtern      => 15,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
    --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
    
      -- Das hier später durch einen Aufruf von UmwandlungAdaNachEigenes ersetzen, wie bei der SFML Version.
      AnzeigeBewegungFloat.Put (Item => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);
      Put (Item => " / ");
      AnzeigeBewegungFloat.Put (Item => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                Fore => 1,
                                Aft  => 2,
                                Exp  => 0);
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 16,
     --                                           LetzteZeileExtern      => 16,
     --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                         Width => 1);
      Put (Item => " / ");
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                                         Width => 1);
      New_Line;
      
   end Erfahrungspunkte;
   
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 17,
      --                                          LetzteZeileExtern      => 17,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      PlatzhalterText := EinheitenbeschreibungenSFML.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end Beschäftigung;
   
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 18,
     --                                           LetzteZeileExtern      => 18,
     --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                         Width => 1);
      New_Line;
      
   end Beschäftigungszeit;
   
   
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 24,
      --                                          LetzteZeileExtern      => 24,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                                         Width => 1);
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 25,
     --                                           LetzteZeileExtern      => 25,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                                         Width => 1);
      
   end Verteidigung;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 26,
     --                                           LetzteZeileExtern      => 26,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                                         Width => 1);
      Put (Item => " / ");
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                 IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))),
                                         Width => 1);
      
   end Rang;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
    --                                            TextDateiExtern        => GlobaleTexte.Zeug,
    --                                            ÜberschriftZeileExtern => 0,
    --                                            ErsteZeileExtern       => 52,
    --                                            LetzteZeileExtern      => 52,
    --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
    --                                            AbstandMitteExtern     => GlobaleTexte.Leer,
    --                                            AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
         
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
           -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
           --                                           TextDateiExtern        => GlobaleTexte.Zeug,
           --                                           ÜberschriftZeileExtern => 0,
           --                                           ErsteZeileExtern       => 53,
           --                                           LetzteZeileExtern      => 53,
           --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
           --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
           --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            null;
               
         when others =>
            StadtInformationenTerminal.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      end case;
      New_Line;
      
   end Heimatstadt;
   
   
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 60,
     --                                           LetzteZeileExtern      => 60,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                   AngreiferExtern          => False)),
                                         Width => 1);
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 61,
     --                                           LetzteZeileExtern      => 61,
     --                                           AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
     --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
     --                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                               AngreiferExtern          => False)),
                                         Width => 1);
      
   end AktuellerAngriff;
   
   
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            null;
               
         when others =>
            ErsteAnzeige := True;
            
            LadungSchleife:
            for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => IDEinheit) loop
                  
               if
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
                 and
                   ErsteAnzeige
               then
                  New_Line;
                  ErsteAnzeige := False;
                --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Zeug,
                --                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                --                                            ÜberschriftZeileExtern => 51,
                 --                                           ErsteZeileExtern       =>
                 --                                             Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                --                                                                                                             LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                --                                                                                                                                                PlatzExtern              => LadungSchleifenwert)))),
                --                                            LetzteZeileExtern      =>
                --                                              Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                --                                                                                                             LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                --                                                                                                                                                PlatzExtern              => LadungSchleifenwert)))),
                --                                            AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                --                                            AbstandMitteExtern     => GlobaleTexte.Leer,
                --                                            AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                     
               elsif
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
               then
                --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                --                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Einheiten_Kurz,
                 --                                           ÜberschriftZeileExtern => 0,
                 --                                           ErsteZeileExtern       =>
                 --                                             Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                --                                                                                                             LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                 --                                                                                                                                               PlatzExtern              => LadungSchleifenwert)))),
                 --                                           LetzteZeileExtern      =>
                 --                                             Positive (LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                 --                                                                                                            LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                  --                                                                                                                                              PlatzExtern              => LadungSchleifenwert)))),
                 --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
                 --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
                --                                           AbstandEndeExtern      => GlobaleTexte.Großer_Abstand);
                  null;
                     
               else
                  null;
               end if;
            
            end loop LadungSchleife;
      end case;
         
      New_Line;
      
   end Ladung;
   
   
   
   procedure DebugInformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        SpielVariablen.Debug.VolleInformation
      is
         when False =>
            null;
            
         when True =>
            DebugmenueTerminal.KarteInfosEinheiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);                     
      end case;
      
   end DebugInformationen;

end InformationenEinheitenTerminal;
