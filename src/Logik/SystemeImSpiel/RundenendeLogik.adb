with DiplomatieDatentypen;
with SystemDatentypen;
with StadtKonstanten;
with TextnummernKonstanten;
with GrafikDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;
with SchreibeAllgemeines;
with LeseAllgemeines;
with LeseDiplomatie;
with SchreibeDiplomatie;

with StadtwachstumLogik;
with ForschungsfortschrittLogik;
with StadtproduktionLogik;
with SiegbedingungenLogik;
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
      
      GeldForschungDiplomatieÄndern;
      LadezeitenLogik.RundenendeSchreiben;
            
      SchreibeAllgemeines.Rundenanzahl;
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
        LeseAllgemeines.Zusammenbruchszeit
      is
         when -1 =>
            Weiterspielen := LeseAllgemeines.Weiterspielen;
            
         when 0 =>
            AbspannLogik.Abspann (AbspannExtern => GrafikDatentypen.Planet_Vernichtet_Enum);
            return False;
            
         when others =>
            SchreibeAllgemeines.Zusammenbruchszeit (ZeitExtern          => -1,
                                                    RechnenSetzenExtern => True);
            
            -- Das True muss später raus, wenn ich eine Siegoption für interstellares Siedeln einbaue. äöü
            return True;
      end case;
      
      case
        Weiterspielen
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
            SchreibeAllgemeines.Weiterspielen (WeiterspielenExtern => JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGewonnenWeiterspielen));
            return Weiterspielen;
            
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
           LeseRassenbelegung.Besiegt (RasseExtern => RasseSchleifenwert) = False
           and
             LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert) = RassenDatentypen.Mensch_Spieler_Enum
         then
            return True;
            
         else
            null;
         end if;
               
      end loop RassenSchleife;
            
      return False;
      
   end MenschlicherSpielerVorhanden;
   
   
   
   procedure GeldForschungDiplomatieÄndern
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
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
           RasseExtern = RasseSchleifenwert
           or
             LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                                                                  RasseZweiExtern => RasseSchleifenwert)
         then
            null;
                  
         else
            SchreibeDiplomatie.ZeitSeitÄnderung (RasseEinsExtern     => RasseExtern,
                                                  RasseZweiExtern     => RasseSchleifenwert,
                                                  ÄnderungExtern     => 1,
                                                  RechnenSetzenExtern => True);
            SchreibeDiplomatie.AktuelleSympathie (RasseEinsExtern     => RasseExtern,
                                                  RasseZweiExtern     => RasseSchleifenwert,
                                                  SympathieExtern     => 1,
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop RassenSchleife;
      
   end Diplomatie;

end RundenendeLogik;
