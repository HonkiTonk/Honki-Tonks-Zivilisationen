pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with StadtKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;

with Wachstum;
with ForschungAllgemein;
with StadtProduktion;
with SiegBedingungen;
with DiplomatischerZustand;
with StadtMeldungenSetzen;
with EinheitenMeldungenSetzen;
with EinheitInUmgebung;
with EinheitenModifizieren;
with Ladezeiten;
with Speichern;
with VerbesserungFertiggestellt;
with LadezeitenDatentypen;
-- with InteraktionTasks;

package body ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean
   is begin
      
      case
        GlobaleVariablen.RasseAmZugNachLaden
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            return False;
      end case;
      
      -- InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Enum_Laden);
      -- Das Umschalten der Darstellung der Ladezeiten in die Prozeduren der jeweiligen Ladezeiten einbauen?
      
      LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Zwischen_Runden_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      case
        NachSiegWeiterspielen
      is
         when True =>
            null;
            
         when False =>
            return True;
      end case;
      
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      EinheitInUmgebung.EinheitInUmgebung;
      
      EinheitenModifizieren.HeilungBewegungspunkteNeueRundeErmitteln;
      VerbesserungFertiggestellt.VerbesserungFertiggestellt;
      Wachstum.StadtWachstum;
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer);
      GeldForschungMengeSetzen;
      ForschungAllgemein.ForschungFortschritt;
      
      RundenAnzahlSetzen;
      EinzelneKIZeitenAnzeigen;
      DiplomatieÄnderung;

      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      Speichern.AutoSpeichern;
            
      GesamteZeitenAnzeigen;
      
      -- InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => SystemDatentypen.Grafik_Enum_Pause);
      
      return False;
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      -- Muss an das neue System angepasst werden.
      case
        GlobaleVariablen.WeiterSpielen
      is
         when False =>
            if
              SiegBedingungen.SiegBedingungen = False
            then
               null;
            
               -- elsif
               --   Auswahl.AuswahlJaNein (FrageZeileExtern => 34) = SystemDatentypen.Ja_Enum
               --  then
               --    GlobaleVariablen.WeiterSpielen := True;
                                 
            else
               return True;
            end if;
         
         when True =>
            null;
      end case;
      
      GlobaleVariablen.WeiterSpielen := True;
      return True;
      
   end NachSiegWeiterspielen;
   
   
   
   procedure RundenAnzahlSetzen
   is begin
      
      case
        GlobaleVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            GlobaleVariablen.RundenAnzahl := GlobaleVariablen.RundenAnzahl + 1;
      end case;
      
   end RundenAnzahlSetzen;
   
   
   
   procedure EinzelneKIZeitenAnzeigen
   is begin
      
      KIVorhanden := False;
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemDatentypen.Spieler_KI_Enum
         then
            KIVorhanden := True;
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => RasseSchleifenwert);
            
         else
            LadezeitenDatentypen.KIZeiten (RasseSchleifenwert, SystemDatentypen.Anfangswert_Enum) := Clock;
            LadezeitenDatentypen.KIZeiten (RasseSchleifenwert, SystemDatentypen.Endwert_Enum) := LadezeitenDatentypen.KIZeiten (RasseSchleifenwert, SystemDatentypen.Anfangswert_Enum);
         end if;
         
      end loop RassenSchleife;
      
   end EinzelneKIZeitenAnzeigen;
   
   
   
   procedure DiplomatieÄnderung
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiSchleife:
         for RasseZweiSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              GlobaleVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt_Enum
              or
                RasseEinsSchleifenwert = RasseZweiSchleifenwert
                or
                  GlobaleVariablen.RassenImSpiel (RasseEinsSchleifenwert) = SystemDatentypen.Leer_Spieler_Enum
              or
                GlobaleVariablen.RassenImSpiel (RasseZweiSchleifenwert) = SystemDatentypen.Leer_Spieler_Enum
            then
               null;
                  
            else
               DiplomatischerZustand.VergangeneZeitÄndern (RasseEinsExtern => RasseEinsSchleifenwert,
                                                            RasseZweiExtern => RasseZweiSchleifenwert);
               DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => RasseEinsSchleifenwert,
                                                       FremdeRasseExtern => RasseZweiSchleifenwert,
                                                       ÄnderungExtern    => 1);
            end if;
            
         end loop RassenZweiSchleife;
         
      end loop RassenEinsSchleife;
      
   end DiplomatieÄnderung;
   
   
   
   procedure GeldForschungMengeSetzen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemDatentypen.Leer_Spieler_Enum =>
               null;
            
            when others =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseSchleifenwert,
                                            GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseSchleifenwert)),
                                            RechnenSetzenExtern => True);
               
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseSchleifenwert,
                                                  ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseSchleifenwert),
                                                  RechnenSetzenExtern     => True);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungMengeSetzen;
   
   
   
   procedure GesamteZeitenAnzeigen
   is begin
      
      case
        KIVorhanden
      is
         when True =>
            Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => StadtKonstanten.LeerRasse);
            
         when False =>
            null;
      end case;
      
      LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Zwischen_Runden_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => LadezeitenDatentypen.Zwischen_Runden_Enum);
      
   end GesamteZeitenAnzeigen;

end ZwischenDenRunden;
