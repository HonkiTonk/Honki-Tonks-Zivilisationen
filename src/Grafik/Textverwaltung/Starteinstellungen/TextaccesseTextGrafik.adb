with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with TextaccessVariablen;
with Spieltexte;
with TextnummernKonstanten;
with SonstigesKonstanten;
with Menuetexte;
with BefehleDatentypen;
with Sequenzentexte;
with StadtDatentypen;
with Kartentexte;

with SpeziesbeschreibungenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;

package body TextaccesseTextGrafik is
   
   procedure TextSetzen
   is begin
      
      Allgemeines;
      Menüs;
      Spezies;
      ZusatztextKartengröße;
      Sprachauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      Befehle;
      
   end TextSetzen;
   
   
   
   procedure Texthöhen
   is begin
      
      TexthöhenSchleife:
      for TexthöhenSchleifenwert in TextaccessVariablen.TexthöhenaccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TexthöhenAccess (TexthöhenSchleifenwert),
                                            str  => "abcdefghijklmnopqrstuvwxyzäöüß - ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ - 0123456789 - ?!§$%&/()=:;.,<>|'*+#_");
         
      end loop TexthöhenSchleife;
      
   end Texthöhen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.VersionsnummerAccess,
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Sequenzentexte.Intro (IntroSchleifenwert)));
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Sequenzentexte.Outro (OutroSchleifenwert)));
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (ZeugSchleifenwert)));
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Fragen (FragenSchleifenwert)));
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Meldungen (MeldungenSchleifenwert)));
         
      end loop MeldungenSchleife;
      
      
      
      WürdigungenSchleife:
      for WürdigungenSchleifenwert in TextaccessVariablen.WürdigungenAccess'Range loop

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.WürdigungenAccess (WürdigungenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Würdigungen (WürdigungenSchleifenwert)));

      end loop WürdigungenSchleife;
      
      
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in TextaccessVariablen.BeschäftigungenAccess'Range loop

         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.BeschäftigungenAccess (BeschäftigungenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Beschäftigungen (BeschäftigungenSchleifenwert)));

      end loop BeschäftigungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      -- Ohne Überschrift.
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in TextaccessVariablen.HauptmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.HauptmenüAccess (HauptmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Hauptmenü (HauptmenüSchleifenwert)));
         
      end loop HauptmenüSchleife;
      
      
            
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in TextaccessVariablen.SpielmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielmenüAccess (SpielmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Spielmenü (SpielmenüSchleifenwert)));
         
      end loop SpielmenüSchleife;
                
      
      
      -- Mit Überschrift.
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in TextaccessVariablen.OptionsmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.OptionsmenüAccess (OptionsmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Optionsmenü (OptionsmenüSchleifenwert)));
         
      end loop OptionsmenüSchleife;
      
      
            
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in TextaccessVariablen.EinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinstellungsmenüAccess (EinstellungsmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Einstellungsmenü (EinstellungsmenüSchleifenwert)));
         
      end loop EinstellungsmenüSchleife;
      
      
            
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in TextaccessVariablen.EditorenmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EditorenmenüAccess (EditorenmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Editorenmenü (EditorenmenüSchleifenwert)));
         
      end loop EditorenmenüSchleife;
      
      
            
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in TextaccessVariablen.SpieleinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpieleinstellungsmenüAccess (SpieleinstellungsmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Spieleinstellungsmenü (SpieleinstellungsmenüSchleifenwert)));
         
      end loop SpieleinstellungsmenüSchleife;
      
      
            
      DebugmenüSchleife:
      for DebugmenüSchleifenwert in TextaccessVariablen.DebugmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.DebugmenüAccess (DebugmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Debugmenü (DebugmenüSchleifenwert)));
         
      end loop DebugmenüSchleife;
            
      
            
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in TextaccessVariablen.GrafikmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GrafikmenüAccess (GrafikmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Grafikmenü (GrafikmenüSchleifenwert)));
         
      end loop GrafikmenüSchleife;
      
      
            
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in TextaccessVariablen.KartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartengrößeAccess (KartengrößeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Kartengröße (KartengrößeSchleifenwert)));
         
      end loop KartengrößeSchleife;
      
      
            
      KartenartSchleife:
      for KartenartSchleifenwert in TextaccessVariablen.KartenartAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenartAccess (KartenartSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Kartenart (KartenartSchleifenwert)));
         
      end loop KartenartSchleife;
            
      
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in TextaccessVariablen.KartentemperaturAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartentemperaturAccess (KartentemperaturSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Kartentemperatur (KartentemperaturSchleifenwert)));
         
      end loop KartentemperaturSchleife;
            
      
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in TextaccessVariablen.SchwierigkeitsgradAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SchwierigkeitsgradAccess (SchwierigkeitsgradSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Schwierigkeitsgrad (SchwierigkeitsgradSchleifenwert)));
         
      end loop SchwierigkeitsgradSchleife;
            
      
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in TextaccessVariablen.RessourcenmengeAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RessourcenmengeAccess (RessourcenmengeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Ressourcenmenge (RessourcenmengeSchleifenwert)));
         
      end loop RessourcenmengeSchleife;
            
      
            
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in TextaccessVariablen.DiplomatiemenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.DiplomatiemenüAccess (DiplomatiemenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Diplomatiemenü (DiplomatiemenüSchleifenwert)));
         
      end loop DiplomatiemenüSchleife;
            
            
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in TextaccessVariablen.KartenpoleAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenpoleAccess (KartenpoleSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Kartenpole (KartenpoleSchleifenwert)));
         
      end loop KartenpoleSchleife;
      
      
            
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in TextaccessVariablen.SoundmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SoundmenüAccess (SoundmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Soundmenü (SoundmenüSchleifenwert)));
         
      end loop SoundmenüSchleife;
            
      
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in TextaccessVariablen.HandelsmenüAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.HandelsmenüAccess (HandelsmenüSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Handelsmenü (HandelsmenüSchleifenwert)));
         
      end loop HandelsmenüSchleife;
      
      
                               
      -- Doppelte Menüs.
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in TextaccessVariablen.SpeziesauswahlAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesauswahlAccess (SpeziesauswahlSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Speziesauswahl (SpeziesauswahlSchleifenwert)));
         
      end loop SpeziesauswahlSchleife;
      
      
            
      KartenformSchleife:
      for KartenformSchleifenwert in TextaccessVariablen.KartenformAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KartenformAccess (KartenformSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Kartenform (KartenformSchleifenwert)));
         
      end loop KartenformSchleife;
      
      
      
      -- Steuerungsmenü.
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Steuerungsmenü (SteuerungSchleifenwert)));
         
      end loop SteuerungSchleife;
      
      
      
      -- SpeichernLadenmenü
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (SpielstandSchleifenwert)));
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
                  
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugStadt + StadtDatentypen.Bauprojektart_Vorhanden_Enum'Pos (BauaufteilungSchleifenwert) - 1)));
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                            str  => SpeziesbeschreibungenGrafik.Kurzbeschreibung (SpeziesExtern => SpeziesSchleifenwert));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                            str  => SpeziesbeschreibungenGrafik.Langbeschreibung (SpeziesExtern => SpeziesSchleifenwert));
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugGebäude)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudetextSchleifenwert,
                                                                                                            SpeziesExtern => SpeziesSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern      => GebäudetextSchleifenwert,
                                                                                                            SpeziesExtern => SpeziesSchleifenwert));
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugEinheiten)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => EinheitentextSchleifenwert,
                                                                                                             SpeziesExtern => SpeziesSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.Langbeschreibung (IDExtern      => EinheitentextSchleifenwert,
                                                                                                             SpeziesExtern => SpeziesSchleifenwert));
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => ForschungSchleifenwert,
                                                                                                        SpeziesExtern => SpeziesSchleifenwert));
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.Langbeschreibung (IDExtern      => ForschungSchleifenwert,
                                                                                                        SpeziesExtern => SpeziesSchleifenwert));
         
         end loop ForschungenSchleife;
      end loop SpeziesSchleife;
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      null;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Sprachauswahl
   is begin
      
      null;
      
   end Sprachauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      null;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      null;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      null;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      null;
      
   end KarteAllgemeines;
   
   
   
   
   procedure Karte
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TextaccessVariablen.BasisgrundAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.BasisgrundAccess (BasisgrundSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Basisgrund (BasisgrundSchleifenwert)));
         
      end loop BasisgrundSchleife;
      
      
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TextaccessVariablen.ZusatzgrundAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatzgrundAccess (ZusatzgrundSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Zusatzgrund (ZusatzgrundSchleifenwert)));
         
      end loop ZusatzgrundSchleife;
      
      
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in TextaccessVariablen.FlüsseAccess'Range loop 
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.FlüsseAccess (FlüsseSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Flüsse (FlüsseSchleifenwert)));
         
      end loop FlüsseSchleife;
      
      
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TextaccessVariablen.RessourcenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RessourcenAccess (RessourcenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Ressourcen (RessourcenSchleifenwert)));
         
      end loop RessourcenSchleife;
      
      
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TextaccessVariablen.FeldeffekteAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.FeldeffekteAccess (FeldeffekteSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Feldeffekte (FeldeffekteSchleifenwert)));
         
      end loop FeldeffekteSchleife;
      
      
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TextaccessVariablen.VerbesserungenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.VerbesserungenAccess (VerbesserungenSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (VerbesserungenSchleifenwert)));
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegeSchleifenwert in TextaccessVariablen.WegeAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.WegeAccess (WegeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Kartentexte.Wege (WegeSchleifenwert)));
         
      end loop WegeSchleife;
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      null;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugJa + AnzeigeEingabeSchleifenwert - TextaccessVariablen.JaNeinAccessArray'First)));
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      null;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Stadtbefehle (BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Pos (StadtbefehleSchleifenwert) - 1)));
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseTextGrafik;
