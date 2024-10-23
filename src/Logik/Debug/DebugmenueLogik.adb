with MenueDatentypen;
with KartenKonstanten;
with ProduktionDatentypen;
with EinheitenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarteneinstellungen;
with SchreibeSpeziesbelegung;
with SchreibeCursor;
with SchreibeDiplomatie;
with SchreibeWichtiges;
with LeseCursor;
with LeseEinheitenGebaut;

with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with DebugmenueAllgemeinesLogik;
with ZahleneingabeLogik;
with EinheitenErzeugenEntfernenLogik;
with EinlesenTextLogik;
with DebugmenueTextausgabeLogik;

package body DebugmenueLogik is

   procedure Debugmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KarteAufdecken (SpeziesExtern => SpeziesExtern);
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               SchreibeWichtiges.ErforschtDebug (SpeziesExtern => SpeziesExtern);
                              
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               MenschKITauschen (SpeziesExtern => SpeziesExtern);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               DiplomatischenStatusÄndern (NeuerStatusExtern => DebugmenueAllgemeinesLogik.DiplomatiestatusAuswählen,
                                            SpeziesExtern     => SpeziesExtern);
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SchreibeWichtiges.Forschungsmenge (SpeziesExtern           => SpeziesExtern,
                                                  ForschungZugewinnExtern => ProduktionDatentypen.Produktion'Last,
                                                  RechnenSetzenExtern     => False);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               EinheitErzeugen (SpeziesExtern => SpeziesExtern);
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               -- Das verwendet nur die Font die die aktuelle Sprache verwendet, sollte man das anpassen? äöü
               EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => Einsprachig);
               Einsprachig := not Einsprachig;
               
            when RueckgabeDatentypen.Auswahl_Acht_Enum =>
               raise Teststopp;
               
            when RueckgabeDatentypen.Auswahl_Neun_Enum =>
               DebugmenueTextausgabeLogik.TexteAusgeben;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
                  
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "DebugmenueLogik.Debugmenü: Falsche Rückgabe: " & RückgabeDebugmenü'Wide_Wide_Image);
         end case;
      
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   -- Eventuell hier was Ähnliches wie im Diplomatieauswahlmenü einbauen oder eine allgemeinere Version der Diplomatieauswahl bauen? äöü
   procedure MenschKITauschen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      AusgewählteSpezies := DebugmenueAllgemeinesLogik.SpeziesAuswählen (SpeziesExtern => SpeziesExtern);
      
      case
        AusgewählteSpezies
      is
         when SpeziesDatentypen.Leer_Spezies_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => AusgewählteSpezies)
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => AusgewählteSpezies,
                                              BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
            
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => AusgewählteSpezies,
                                               KoordinatenExtern => (0, 1, 1));
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => AusgewählteSpezies,
                                           KoordinatenExtern => (0, 1, 1));
                                             
         when others =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => AusgewählteSpezies,
                                              BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
      end case;
                                             
   end MenschKITauschen;
   
   
   
   procedure KarteAufdecken
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
            
               SchreibeWeltkarte.Sichtbar (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                           SpeziesExtern     => SpeziesExtern,
                                           SichtbarExtern    => True);
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum,
                                   SpeziesExtern     => SpeziesExtern);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
            
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesSchleifenwert = SpeziesExtern
         then
            null;
               
         else
            SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                 SpeziesZweiExtern => SpeziesSchleifenwert,
                                                 ZustandExtern     => NeuerStatusExtern);
            
            
            SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesSchleifenwert,
                                                 SpeziesZweiExtern => SpeziesExtern,
                                                 ZustandExtern     => NeuerStatusExtern);
         end if;
            
      end loop SpeziesSchleife;
      
   end DiplomatischenStatusÄndern;
   
   
   
   procedure EinheitErzeugen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      Einheitenauswahl := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (EinheitenDatentypen.EinheitenbereichVorhanden'First),
                                                            ZahlenMaximumExtern => Positive (EinheitenDatentypen.EinheitenbereichVorhanden'Last),
                                                            WelcheFrageExtern   => 3);
      
      case
        Einheitenauswahl.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            Einheitennummer := EinheitenKonstanten.LeerNummer;
      end case;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenbereichVorhanden loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               Einheitennummer := EinheitenSchleifenwert;
               exit EinheitenSchleife;
               
            when others =>
               null;
         end case;
      end loop EinheitenSchleife;
      
      case
        Einheitennummer
      is
         when EinheitenKonstanten.LeerNummer =>
            Einheitennummer := 1;
            
         when others =>
            EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern        => LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern),
                                                             EinheitNummerExtern      => Einheitennummer,
                                                             IDExtern                 => EinheitenDatentypen.EinheitenIDVorhanden (Einheitenauswahl.EingegebeneZahl),
                                                             StadtSpeziesNummerExtern => (SpeziesExtern, 0));
      end case;
      
   end EinheitErzeugen;
   
end DebugmenueLogik;
