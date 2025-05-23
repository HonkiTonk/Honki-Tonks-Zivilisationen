with AufgabenDatentypen;
with TextnummernKonstanten;
with AuswahlKonstanten;
with SystemDatentypen;
with SystemKonstanten;

with LeseEinheitenGebaut;
with LeseZeiger;
with SchreibeGrafiktask;

with StadtmenueLogik;
with AufgabenLogik;
with StadtBauenLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;
with StadtEntfernenLogik;
with TransporterSuchenLogik;
with AufgabeFestlegenLogik;
with EinheitenkontrollsystemLogik;
with AuswahlStadtEinheitLogik;
with JaNeinLogik;
with EinheitenSpielmeldungenLogik;
with StadtAllgemeinesLogik;
with MeldungssystemHTSEB;

-- Hier auch mal überarbeiten, vor allem die Prozeduren weiter unten. äöü
package body BefehlspruefungenLogik is
   
   procedure WasWirdEntfernt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type StadtDatentypen.Städtebereich;
   begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));
      
      if
        EinheitNummer /= EinheitenDatentypen.Einheitenbereich'First
        and
          StadtNummer /= StadtDatentypen.Städtebereich'First
      then
         case
           AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => SpeziesExtern,
                                                         StadtnummerExtern   => StadtNummer,
                                                         EinheitNummerExtern => EinheitNummer)
         is
            when AuswahlKonstanten.LeerAuswahl =>
               LeerRückgabewert := StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
               
            when 1 =>
               EinheitBefehle (SpeziesExtern => SpeziesExtern,
                               BefehlExtern  => BefehleDatentypen.Auflösen_Enum);
               
            when SystemKonstanten.AbwählenNegativ =>
               null;
            
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "BefehlspruefungenLogik.WasWirdEntfernt: Fehlerhafte Auswahl");
         end case;
         
      elsif
        StadtNummer /= StadtDatentypen.Städtebereich'First
      then
         LeerRückgabewert := StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.Einheitenbereich'First
      then
         EinheitBefehle (SpeziesExtern => SpeziesExtern,
                         BefehlExtern  => BefehleDatentypen.Auflösen_Enum);
               
      else
         null;
      end if;
      
   end WasWirdEntfernt;
   
   
   
   procedure AuswahlEinheitStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type StadtDatentypen.Städtebereich;
   begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));

      if
        EinheitNummer /= EinheitenDatentypen.Einheitenbereich'First
        and
          StadtNummer /= StadtDatentypen.Städtebereich'First
      then
         EinheitOderStadt (SpeziesExtern       => SpeziesExtern,
                           StadtNummerExtern   => StadtNummer,
                           EinheitNummerExtern => EinheitNummer);
         
      elsif
        StadtNummer /= StadtDatentypen.Städtebereich'First
      then
         StadtAktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
         
      elsif
        EinheitNummer /= EinheitenDatentypen.Einheitenbereich'First
      then
         AuswahlEinheitTransporter (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer));
               
      else
         null;
      end if;
      
   end AuswahlEinheitStadt;



   procedure EinheitOderStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StadtNummerExtern : in StadtDatentypen.Städtebereich;
      EinheitNummerExtern : in EinheitenDatentypen.Einheitenbereich)
   is begin
      
      case
        AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => SpeziesExtern,
                                                      StadtnummerExtern   => StadtNummerExtern,
                                                      EinheitNummerExtern => EinheitNummerExtern)
      is
         when AuswahlKonstanten.LeerAuswahl =>
            StadtAktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummerExtern));
            
         when 1 =>
            AuswahlEinheitTransporter (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerExtern));
               
         when SystemKonstanten.AbwählenNegativ =>
            null;
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "BefehlspruefungenLogik.EinheitOderStadt: Fehlerhafte Auswahl");
      end case;
      
   end EinheitOderStadt;
   
   
   
   -- Eventuell noch eine Einstellung einbauen, welche das Deaktivieren des verschachtelten Einheitenzugriffs ermöglicht? äöü
   procedure AuswahlEinheitTransporter
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        TransporterSuchenLogik.HatTransporterLadung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when True =>
            TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
            AusgewählteEinheit := AuswahlStadtEinheitLogik.AuswahlStadtEinheit (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                                                 StadtnummerExtern   => StadtDatentypen.Städtebereich'First,
                                                                                 EinheitNummerExtern => TransporterNummer);
            
         when False =>
            TransporterNummer := EinheitSpeziesNummerExtern.Nummer;
            AusgewählteEinheit := AuswahlKonstanten.LeerAuswahl;
      end case;
      
      case
        AusgewählteEinheit
      is
         when AuswahlKonstanten.LeerAuswahl =>
            EinheitSteuern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer));
            
         when Positive (EinheitenRecords.TransporterArray'First) .. Positive (EinheitenRecords.TransporterArray'Last) =>
            AuswahlEinheitTransporter (EinheitSpeziesNummerExtern =>
                                         (EinheitSpeziesNummerExtern.Spezies, LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, TransporterNummer),
                                                                                                                 PlatzExtern                => EinheitenDatentypen.Transportplätze (AusgewählteEinheit))));
            
         when SystemKonstanten.AbwählenNegativ =>
            null;
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "BefehlspruefungenLogik.AuswahlEinheitTransporter: Fehlerhafte Auswahl:" & AusgewählteEinheit'Wide_Wide_Image);
      end case;
      
   end AuswahlEinheitTransporter;
   
   
   
   procedure EinheitSteuern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      SchreibeGrafiktask.Einheitnummer (EinheitnummerExtern => EinheitSpeziesNummerExtern.Nummer);
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         case
           EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when True =>
               EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
            when False =>
               null;
         end case;
            
      else
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               AufgabeFestlegenLogik.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
               if
                 LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
               then
                  null;
                  
               else
                  EinheitenkontrollsystemLogik.Einheitenkontrolle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               end if;
               
            when others =>
               null;
         end case;
      end if;
      
      SchreibeGrafiktask.Einheitnummer (EinheitnummerExtern => EinheitenKonstanten.LeerNummer);
            
   end EinheitSteuern;
   
   
   
   procedure BaueStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := StadtBauenLogik.StadtBauen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer));
            
         when False =>
            null;
      end case;
      
   end BaueStadt;
   
   
   
   procedure EinheitBefehle
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Klein_Enum)
   is begin
                     
      EinheitNummer := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                              KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                                              TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        EinheitNummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
                  
         when others =>
            null;
      end case;
      
      case
        EinheitenSpielmeldungenLogik.BewegungspunkteMeldung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer))
      is
         when True =>
            LeerRückgabewert := AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer),
                                                        BefehlExtern               => BefehlExtern,
                                                        AnlegenTestenExtern        => True,
                                                        KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummer)));
            
         when False =>
            null;
      end case;
      
   end EinheitBefehle;
   
   
   
   procedure StadtUmbenennen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      StadtNummer := StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                        KoordinatenExtern => LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern));
      
      case
        StadtNummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
         
         when others =>
            StadtAllgemeinesLogik.NeuerStadtname (StadtSpeziesNummerExtern => (SpeziesExtern, StadtNummer));
      end case;
      
   end StadtUmbenennen;
   
   
   
   -- Hier dann später die Prüfungen für das vorhandene Stadtbewegungsgebäude und die entsprechende Auswahl zwischen Stadt betreten und bewegen einbauen. äöü
   procedure StadtAktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      
      
      StadtmenueLogik.Stadtmenü (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end StadtAktion;

end BefehlspruefungenLogik;
