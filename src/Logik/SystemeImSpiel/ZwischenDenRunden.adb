pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with SystemDatentypen;
with StadtKonstanten;
with TextnummernKonstanten;
with GrafikDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with WachstumLogik;
with ForschungsfortschrittLogik;
with StadtproduktionLogik;
with SiegbedingungenLogik;
with DiplomatischerZustand;
with MeldungenSetzenLogik;
with EinheitInUmgebung;
with EinheitenModifizieren;
with LadezeitenLogik;
with Speichern;
with VerbesserungFertiggestelltLogik;
with NachGrafiktask;
with JaNeinLogik;
with AbspannLogik;

package body ZwischenDenRunden is

   function BerechnungenRundenende
     return Boolean
   is begin
      
      case
        NachSiegWeiterspielen
      is
         when True =>
            LadezeitenLogik.RundenendeNullsetzen;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Rundenende_Enum;
            
         when False =>
            return False;
      end case;
      
      -- Später in verschiedene Teilbereiche aufteilen und nicht nur einen einzelnen Berechnungsfortschritt anzeigen? äöü
      MeldungenSetzenLogik.MeldungenRundenende;
      LadezeitenLogik.RundenendeSchreiben;
      
      EinheitInUmgebung.EinheitInUmgebung;
      LadezeitenLogik.RundenendeSchreiben;
            
      EinheitenModifizieren.HeilungBewegungspunkteNeueRundeErmitteln;
      LadezeitenLogik.RundenendeSchreiben;
      
      VerbesserungFertiggestelltLogik.VerbesserungFertiggestellt;
      LadezeitenLogik.RundenendeSchreiben;
      
      WachstumLogik.StadtWachstum;
      LadezeitenLogik.RundenendeSchreiben;
      
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer);
      LadezeitenLogik.RundenendeSchreiben;
            
      RundenanzahlSetzen;
      LadezeitenLogik.RundenendeSchreiben;
      
      GeldForschungDiplomatieÄndern;
      LadezeitenLogik.RundenendeSchreiben;
      
      ForschungsfortschrittLogik.Forschungsfortschritt;
      LadezeitenLogik.RundenendeSchreiben;
      
      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      Speichern.AutoSpeichern;
      LadezeitenLogik.RundenendeMaximum;
            
      return True;
      
   end BerechnungenRundenende;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        SpielVariablen.Allgemeines.PlanetVernichtet
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            null;
            
         when others =>
            AbspannLogik.Abspann (AbspannExtern => GrafikDatentypen.Planet_Vernichtet_Enum);
            return False;
      end case;
      
      case
        SpielVariablen.Allgemeines.Weiterspielen
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      case
        SiegbedingungenLogik.Siegbedingungen
      is
         when SystemDatentypen.Leer_Enum =>
            return True;
            
         when SystemDatentypen.Gewonnen_Enum =>
            SpielVariablen.Allgemeines.Weiterspielen := JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGewonnenWeiterspielen);
            return SpielVariablen.Allgemeines.Weiterspielen;
            
         when SystemDatentypen.Verloren_Enum =>
            return False;
      end case;
      
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
   
   
   
   procedure GeldForschungDiplomatieÄndern
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
            
            when others =>
               GeldForschung (RasseExtern => RasseSchleifenwert);
               Diplomatie (RasseExtern => RasseSchleifenwert);
         end case;
         
      end loop RassenSchleife;
      
   end GeldForschungDiplomatieÄndern;
   
   
   
   procedure GeldForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        RasseExtern = RassenDatentypen.Ekropa_Enum
      then
         null;
                  
      else
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern)),
                                      RechnenSetzenExtern => True);
      end if;
               
      SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseExtern,
                                         ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern),
                                         RechnenSetzenExtern     => True);
      
   end GeldForschung;
   
   
   
   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
         if
           SpielVariablen.Diplomatie (RasseExtern, RasseSchleifenwert).AktuellerZustand = DiplomatieDatentypen.Unbekannt_Enum
           or
             RasseExtern = RasseSchleifenwert
             or
               SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
                  
         else
            DiplomatischerZustand.VergangeneZeitÄndern (RasseEinsExtern => RasseExtern,
                                                         RasseZweiExtern => RasseSchleifenwert);
            DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => RasseExtern,
                                                    FremdeRasseExtern => RasseSchleifenwert,
                                                    ÄnderungExtern    => 1);
         end if;
            
      end loop RassenSchleife;
      
   end Diplomatie;

end ZwischenDenRunden;
