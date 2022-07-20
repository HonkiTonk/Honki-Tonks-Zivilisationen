pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen; use RassenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with StadtKonstanten;
with SpielVariablen;
with TextKonstanten;
with GrafikDatentypen;

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
with NachGrafiktask;
with Auswahl;

package body ZwischenDenRunden is

   function BerechnungenRundenende
     return Boolean
   is begin
      
      case
        NachSiegWeiterspielen
      is
         when True =>
            Ladezeiten.RundenendeNullsetzen;
            Ladezeiten.RundenendeZeit (SystemDatentypen.Anfangswert_Enum) := Clock;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Rundenende_Enum;
            
         when False =>
            return False;
      end case;
      
      -- Später in verschiedene Teilbereiche aufteilen und nicht nur einen einzelnen Berechnungsfortschritt anzeigen? äöü
      StadtMeldungenSetzen.StadtMeldungenSetzenRundenEnde;
      Ladezeiten.RundenendeSchreiben;
      
      EinheitenMeldungenSetzen.EinheitenMeldungenSetzenRundenEnde;
      Ladezeiten.RundenendeSchreiben;
      
      EinheitInUmgebung.EinheitInUmgebung;
      Ladezeiten.RundenendeSchreiben;
            
      EinheitenModifizieren.HeilungBewegungspunkteNeueRundeErmitteln;
      Ladezeiten.RundenendeSchreiben;
      
      VerbesserungFertiggestellt.VerbesserungFertiggestellt;
      Ladezeiten.RundenendeSchreiben;
      
      Wachstum.StadtWachstum;
      Ladezeiten.RundenendeSchreiben;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer);
      Ladezeiten.RundenendeSchreiben;
      
      GeldForschungMengeSetzen;
      Ladezeiten.RundenendeSchreiben;
      
      ForschungAllgemein.ForschungFortschritt;
      Ladezeiten.RundenendeSchreiben;
            
      RundenanzahlSetzen;
      Ladezeiten.RundenendeSchreiben;
      
      DiplomatieÄnderung;
      Ladezeiten.RundenendeSchreiben;
      
      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      Speichern.AutoSpeichern;
      Ladezeiten.RundenendeMaximum;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      Ladezeiten.RundenendeZeit (SystemDatentypen.Endwert_Enum) := Clock;
      
      return True;
      
   end BerechnungenRundenende;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        SpielVariablen.Allgemeines.Weiterspielen
      is
         when False =>
            if
              SiegBedingungen.SiegBedingungen = False
            then
               null;
            
            elsif
              Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageGewonnenWeiterspielen) = True
            then
               SpielVariablen.Allgemeines.Weiterspielen := True;
                                 
            else
               return False;
            end if;
         
         when True =>
            null;
      end case;
      
      return True;
      
   end NachSiegWeiterspielen;
   
   
   
   procedure RundenanzahlSetzen
   is begin
      
      case
        SpielVariablen.Allgemeines.Rundenanzahl
      is
         when Positive'Last =>
            null;
            
         when others =>
            SpielVariablen.Allgemeines.Rundenanzahl := SpielVariablen.Allgemeines.Rundenanzahl + 1;
      end case;
      
   end RundenanzahlSetzen;
   
   
   
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
                  SpielVariablen.RassenImSpiel (RasseEinsSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
              or
                SpielVariablen.RassenImSpiel (RasseZweiSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
            
            when others =>
               if
                 RasseSchleifenwert = RassenDatentypen.Ekropa_Enum
               then
                  null;
                  
               else
                  SchreibeWichtiges.Geldmenge (RasseExtern         => RasseSchleifenwert,
                                               GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseSchleifenwert)),
                                               RechnenSetzenExtern => True);
               end if;
               
               SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseSchleifenwert,
                                                  ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseSchleifenwert),
                                                  RechnenSetzenExtern     => True);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungMengeSetzen;

end ZwischenDenRunden;
