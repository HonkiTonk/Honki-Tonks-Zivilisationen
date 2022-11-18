with DiplomatieDatentypen;
with SystemDatentypen;
with StadtKonstanten;
with TextnummernKonstanten;
with GrafikDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;

with StadtwachstumLogik;
with ForschungsfortschrittLogik;
with StadtproduktionLogik;
with SiegbedingungenLogik;
with DiplomatischerZustandLogik;
with MeldungenSetzenLogik;
with EinheitInUmgebungLogik;
with EinheitenmodifizierungLogik;
with LadezeitenLogik;
with SpeichernLogik;
with VerbesserungFertiggestelltLogik;
with NachGrafiktask;
with JaNeinLogik;
with AbspannLogik;

package body RundenendeLogik is

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
      
      EinheitInUmgebungLogik.EinheitInUmgebung;
      LadezeitenLogik.RundenendeSchreiben;
            
      EinheitenmodifizierungLogik.HeilungBewegungspunkteNeueRundeErmitteln;
      LadezeitenLogik.RundenendeSchreiben;
      
      VerbesserungFertiggestelltLogik.VerbesserungFertiggestellt;
      LadezeitenLogik.RundenendeSchreiben;
      
      StadtwachstumLogik.StadtWachstum;
      LadezeitenLogik.RundenendeSchreiben;
      
      StadtproduktionLogik.Stadtproduktion (StadtRasseNummerExtern => StadtKonstanten.LeerRasseNummer);
      LadezeitenLogik.RundenendeSchreiben;
      
      ForschungsfortschrittLogik.Forschungsfortschritt;
      LadezeitenLogik.RundenendeSchreiben;
            
      RundenanzahlSetzen;
      LadezeitenLogik.RundenendeSchreiben;
      
      GeldForschungDiplomatieÄndern;
      LadezeitenLogik.RundenendeSchreiben;
      
      -- Autospeichern muss immer nach allen Änderungen kommen, sonst werden nicht alle Änderungen gespeichert.
      SpeichernLogik.AutoSpeichern;
      LadezeitenLogik.RundenendeMaximum;
            
      return True;
      
   end BerechnungenRundenende;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        SpielVariablen.Allgemeines.Zusammenbruchszeit
      is
         when -1 =>
            null;
            
         when 0 =>
            AbspannLogik.Abspann (AbspannExtern => GrafikDatentypen.Planet_Vernichtet_Enum);
            return False;
            
         when others =>
            SpielVariablen.Allgemeines.Zusammenbruchszeit := SpielVariablen.Allgemeines.Zusammenbruchszeit - 1;
            -- Das True muss später raus, wenn ich eine Siegoption für interstellares Siedeln einbaue. äöü
            return True;
      end case;
      
      case
        SpielVariablen.Allgemeines.Weiterspielen
      is
         when True =>
            return MenschlicherSpielerVorhanden;
            
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
   
   
   
   function MenschlicherSpielerVorhanden
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Besiegt = False
           and
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Mensch_Spieler_Enum
         then
            return True;
                  
         else
            null;
         end if;
               
      end loop RassenSchleife;
            
      return False;
      
   end MenschlicherSpielerVorhanden;
   
   
   
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
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
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
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
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
            DiplomatischerZustandLogik.VergangeneZeitÄndern (RasseEinsExtern => RasseExtern,
                                                              RasseZweiExtern => RasseSchleifenwert);
            DiplomatischerZustandLogik.SympathieÄndern (EigeneRasseExtern => RasseExtern,
                                                         FremdeRasseExtern => RasseSchleifenwert,
                                                         ÄnderungExtern    => 1);
         end if;
            
      end loop RassenSchleife;
      
   end Diplomatie;

end RundenendeLogik;
