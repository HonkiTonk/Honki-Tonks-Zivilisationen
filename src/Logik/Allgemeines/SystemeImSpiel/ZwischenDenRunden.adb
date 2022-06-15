pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen; use RassenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with SonstigeVariablen;
with StadtKonstanten;
with SpielVariablen;

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
-- with InteraktionTasks;

package body ZwischenDenRunden is

   function BerechnungenNachZugendeAllerSpieler
     return Boolean
   is begin
      
      case
        SonstigeVariablen.RasseAmZugNachLaden
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            return False;
      end case;
      
      -- InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => RueckgabeDatentypen.Grafik_Enum_Laden);
      -- Das Umschalten der Darstellung der Ladezeiten in die Prozeduren der jeweiligen Ladezeiten einbauen?
      
      -- LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Zwischen_Runden_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
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
      
      -- InteraktionTasks.AktuelleDarstellungÄndern (DarstellungExtern => RueckgabeDatentypen.Grafik_Enum_Pause);
      
      return False;
      
   end BerechnungenNachZugendeAllerSpieler;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      -- Muss an das neue System angepasst werden.
      case
        SonstigeVariablen.WeiterSpielen
      is
         when False =>
            if
              SiegBedingungen.SiegBedingungen = False
            then
               null;
            
               -- elsif
               --   Auswahl.AuswahlJaNein (FrageZeileExtern => 34) = RueckgabeDatentypen.Ja_Enum
               --  then
               --    SonstigeVariablen.WeiterSpielen := True;
                                 
            else
               return True;
            end if;
         
         when True =>
            null;
      end case;
      
      SonstigeVariablen.WeiterSpielen := True;
      return True;
      
   end NachSiegWeiterspielen;
   
   
   
   procedure RundenAnzahlSetzen
   is begin
      
      case
        SpielVariablen.RundenAnzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            SpielVariablen.RundenAnzahl := SpielVariablen.RundenAnzahl + 1;
      end case;
      
   end RundenAnzahlSetzen;
   
   
   
   procedure EinzelneKIZeitenAnzeigen
   is begin
      
      KIVorhanden := False;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Spieler_KI_Enum
         then
            KIVorhanden := True;
            -- Ladezeiten.AnzeigeKIZeit (WelcheZeitExtern => RasseSchleifenwert);
            
         else
            Ladezeiten.KIZeiten (RasseSchleifenwert, SystemDatentypen.Anfangswert_Enum) := Clock;
            Ladezeiten.KIZeiten (RasseSchleifenwert, SystemDatentypen.Endwert_Enum) := Ladezeiten.KIZeiten (RasseSchleifenwert, SystemDatentypen.Anfangswert_Enum);
         end if;
         
      end loop RassenSchleife;
      
   end EinzelneKIZeitenAnzeigen;
   
   
   
   procedure DiplomatieÄnderung
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt_Enum
              or
                RasseEinsSchleifenwert = RasseZweiSchleifenwert
                or
                  SonstigeVariablen.RassenImSpiel (RasseEinsSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
              or
                SonstigeVariablen.RassenImSpiel (RasseZweiSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
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

end ZwischenDenRunden;
