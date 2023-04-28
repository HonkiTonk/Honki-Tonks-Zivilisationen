with SystemDatentypen;
with TextnummernKonstanten;
with GrafikDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenverbesserungDatentypen;
with WichtigesKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with SchreibeAllgemeines;
with LeseAllgemeines;
with LeseGrenzen;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with StadtmaterialwachstumLogik;
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
with GlobalesWachstumLogik;
with StadtbewohnerwachstumLogik;
with DiplomatieLogik;

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
      -- Immer erst die aktuellen Werte hinzufügen und dann für die nächste Runde die neuen Produktionswerte berechnen!
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
               
               -- Sollte die Forschung nicht vor dem Fortschritt hinzugefügt werden? Und sollte das Hinzufügen vielleicht nicht Teil des Fortschritts sein? äöü
               GeldForschung (SpeziesExtern => SpeziesSchleifenwert);
               DiplomatieLogik.DiplomatieRundenende (SpeziesExtern => SpeziesSchleifenwert);
               
               BerechnungenEinheiten (SpeziesExtern => SpeziesSchleifenwert);
               BerechnungenStädte (SpeziesExtern => SpeziesSchleifenwert);
               
               ForschungsfortschrittLogik.Forschungsfortschritt (SpeziesExtern => SpeziesSchleifenwert);
         end case;
         
         case
           Belegung
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               -- Ich schreibe Meldungen nur für Menschen, reicht dann die Leerung auch nicht bei nur Menschen? äöü
               EinheitInUmgebungLogik.EinheitInUmgebung (SpeziesExtern => SpeziesSchleifenwert);
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KIRundenende.Rundenende (SpeziesExtern => SpeziesSchleifenwert);
               
            when SpeziesDatentypen.Leer_Spieler_Enum =>
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
   
   
   
   procedure BerechnungenEinheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
                  
            when others =>
               EinheitenmodifizierungLogik.HeilungBewegungspunkteNeueRunde (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert));
               VerbesserungFertiggestelltLogik.VerbesserungFertiggestellt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert));
         end case;
            
      end loop EinheitenSchleife;
      
   end BerechnungenEinheiten;
   
   
   
   procedure BerechnungenStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
                  
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               StadtmaterialwachstumLogik.Material (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
               StadtbewohnerwachstumLogik.Einwohner (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
               StadtproduktionLogik.StadtProduktionBerechnung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
            
      end loop StadtSchleife;
            
      GlobalesWachstumLogik.WachstumsratenBerechnen (SpeziesExtern => SpeziesExtern);
      
   end BerechnungenStädte;
   
   
   
   function NachSiegWeiterspielen
     return Boolean
   is begin
      
      case
        LeseAllgemeines.Zusammenbruchszeit
      is
         when WichtigesKonstanten.KeinZusammenbruch =>
            Weiterspielen := LeseAllgemeines.Weiterspielen;
            
         when WichtigesKonstanten.Zusammenbruch =>
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
   
   
   
   -- Das später auch an eine passendere Stelle schieben/aufteilen. äöü
   procedure GeldForschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
                  
         when others =>
            SchreibeWichtiges.Geldmenge (SpeziesExtern       => SpeziesExtern,
                                         GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern)),
                                         RechnenSetzenExtern => True);
      end case;
               
      SchreibeWichtiges.Forschungsmenge (SpeziesExtern           => SpeziesExtern,
                                         ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (SpeziesExtern => SpeziesExtern),
                                         RechnenSetzenExtern     => True);
      
   end GeldForschung;

end RundenendeLogik;
