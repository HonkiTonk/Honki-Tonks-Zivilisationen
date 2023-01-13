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
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt);
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
            Weiterspielen := JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGewonnenWeiterspielen);
            SchreibeAllgemeines.Weiterspielen (WeiterspielenExtern => Weiterspielen);
            return Weiterspielen;
            
         when SystemDatentypen.Verloren_Enum =>
            return False;
      end case;
      
   end NachSiegWeiterspielen;
   
   
   procedure GeldForschungDiplomatieÄndern
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
            
            when others =>
               GeldForschung (SpeziesExtern => SpeziesSchleifenwert);
               Diplomatie (SpeziesExtern => SpeziesSchleifenwert);
         end case;
         
      end loop SpeziesSchleife;
      
   end GeldForschungDiplomatieÄndern;
   
   
   
   procedure GeldForschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        SpeziesExtern = SpeziesDatentypen.Ekropa_Enum
      then
         null;
                  
      else
         SchreibeWichtiges.Geldmenge (SpeziesExtern         => SpeziesExtern,
                                      GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern)),
                                      RechnenSetzenExtern => True);
      end if;
               
      SchreibeWichtiges.Forschungsmenge (SpeziesExtern             => SpeziesExtern,
                                         ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (SpeziesExtern => SpeziesExtern),
                                         RechnenSetzenExtern     => True);
      
   end GeldForschung;
   
   
   
   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
            
         if
           SpeziesExtern = SpeziesSchleifenwert
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                  SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            null;
                  
         else
            SchreibeDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern     => SpeziesExtern,
                                                  SpeziesZweiExtern     => SpeziesSchleifenwert,
                                                  ÄnderungExtern     => 1,
                                                  RechnenSetzenExtern => True);
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern     => SpeziesExtern,
                                                  SpeziesZweiExtern     => SpeziesSchleifenwert,
                                                  SympathieExtern     => 1,
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end Diplomatie;

end RundenendeLogik;
