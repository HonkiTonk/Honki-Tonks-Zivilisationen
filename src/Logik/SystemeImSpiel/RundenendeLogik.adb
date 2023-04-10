with SystemDatentypen;
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

with KIRundenende;

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
      
      -- Hier immer beachten in welcher Reihenfolge was aufgerufen wird, sonst könnte es zu Problemen führen!
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         Belegung := LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert);
         
         case
           Belegung
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               MeldungenSetzenLogik.MeldungenRundenende (SpeziesExtern => SpeziesSchleifenwert);
               EinheitenmodifizierungLogik.HeilungBewegungspunkteNeueRundeErmitteln (SpeziesExtern => SpeziesSchleifenwert);
               VerbesserungFertiggestelltLogik.VerbesserungFertiggestellt (SpeziesExtern => SpeziesSchleifenwert);
               StadtwachstumLogik.StadtWachstum (SpeziesExtern => SpeziesSchleifenwert);
               StadtproduktionLogik.StadtproduktionRundenende (SpeziesExtern => SpeziesSchleifenwert);
               ForschungsfortschrittLogik.Forschungsfortschritt (SpeziesExtern => SpeziesSchleifenwert);
               GeldForschung (SpeziesExtern => SpeziesSchleifenwert);
               Diplomatie (SpeziesExtern => SpeziesSchleifenwert);
         end case;
         
         case
           Belegung
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               -- Ich schreibe Meldungen nur für Menschen, reicht dann die Leerung auch nicht bei nur Menschen? äöü
               EinheitInUmgebungLogik.EinheitInUmgebung (SpeziesExtern => SpeziesSchleifenwert);
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KIRundenende.Rundenende (SpeziesExtern => SpeziesSchleifenwert);
               
            when others =>
               null;
         end case;
         
         LadezeitenLogik.RundenendeSchreiben;
         
      end loop SpeziesSchleife;
      
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
         SchreibeWichtiges.Geldmenge (SpeziesExtern       => SpeziesExtern,
                                      GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern)),
                                      RechnenSetzenExtern => True);
      end if;
               
      SchreibeWichtiges.Forschungsmenge (SpeziesExtern           => SpeziesExtern,
                                         ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (SpeziesExtern => SpeziesExtern),
                                         RechnenSetzenExtern     => True);
      
   end GeldForschung;
   
   
   
   -- Das später nach Diplomatie verschieben. äöü
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
            SchreibeDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern    => SpeziesExtern,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  ÄnderungExtern      => 1,
                                                  RechnenSetzenExtern => True);
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => SpeziesExtern,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => SchwierigkeitsgradMeinungsverbesserung (LeseAllgemeines.Schwierigkeitsgrad),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end Diplomatie;

end RundenendeLogik;
