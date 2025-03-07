with TextaccessVariablen;

package body TextaccesseSchriftstilGrafik is

   procedure SchriftstilSetzen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Texthöhen (StilExtern => StilExtern);
      Allgemeines (StilExtern => StilExtern);
      Menüs (StilExtern => StilExtern);
      Spezies (StilExtern => StilExtern);
      ZusatztextKartengröße (StilExtern => StilExtern);
      Sprachauswahl (StilExtern => StilExtern);
      StadtInformationen (StilExtern => StilExtern);
      EinheitenInformationen (StilExtern => StilExtern);
      KarteWichtiges (StilExtern => StilExtern);
      KarteAllgemeines (StilExtern => StilExtern);
      Karte (StilExtern => StilExtern);
      EinheitStadtAuswahl (StilExtern => StilExtern);
      AnzeigeEingabe (StilExtern => StilExtern);
      Ladezeiten (StilExtern => StilExtern);
      Befehle (StilExtern => StilExtern);
      
   end SchriftstilSetzen;
   
   
   
   procedure Texthöhen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      TexthöhenSchleife:
      for TexthöhenSchleifenwert in TextaccessVariablen.TexthöhenaccessArray'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.TexthöhenAccess (TexthöhenSchleifenwert),
                                    style => StilExtern);
         
      end loop TexthöhenSchleife;
      
   end Texthöhen;
   
   
   
   procedure Allgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.TestKleinAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.TestMittelAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.TestGroßAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ÜberschriftAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.VersionsnummerAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ZeilenumbruchAccess,
                                 style => StilExtern);
            
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.Spielmeldung,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.BildrateAccess,
                                 style => StilExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.DiplomatieAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinheitenseitenleisteAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EingabenanzeigeAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinheitenbauinformationenAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GebäudebauinformationenAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtkarteAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtumgebungAccess,
                                 style => StilExtern);
      -- Später das Zeug überall sortieren. äöü
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                    style => StilExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                    style => StilExtern);
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                    style => StilExtern);
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                    style => StilExtern);
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                    style => StilExtern);
         
      end loop MeldungenSchleife;
      
      
      
      WürdigungenSchleife:
      for WürdigungenSchleifenwert in TextaccessVariablen.WürdigungenAccess'Range loop

         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.WürdigungenAccess (WürdigungenSchleifenwert),
                                    style => StilExtern);

      end loop WürdigungenSchleife;
      
      
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in TextaccessVariablen.BeschäftigungenAccess'Range loop

         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.BeschäftigungenAccess (BeschäftigungenSchleifenwert),
                                    style => StilExtern);

      end loop BeschäftigungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      -- Ohne Überschrift.
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in TextaccessVariablen.HauptmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.HauptmenüAccess (HauptmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop HauptmenüSchleife;
      
      
            
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in TextaccessVariablen.SpielmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpielmenüAccess (SpielmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop SpielmenüSchleife;
                
      
      
      -- Mit Überschrift.
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in TextaccessVariablen.OptionsmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.OptionsmenüAccess (OptionsmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop OptionsmenüSchleife;
      
      
            
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in TextaccessVariablen.EinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinstellungsmenüAccess (EinstellungsmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop EinstellungsmenüSchleife;
      
      
            
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in TextaccessVariablen.EditorenmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EditorenmenüAccess (EditorenmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop EditorenmenüSchleife;
      
      
            
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in TextaccessVariablen.SpieleinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpieleinstellungsmenüAccess (SpieleinstellungsmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop SpieleinstellungsmenüSchleife;
      
      
            
      DebugmenüSchleife:
      for DebugmenüSchleifenwert in TextaccessVariablen.DebugmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.DebugmenüAccess (DebugmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop DebugmenüSchleife;
            
      
            
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in TextaccessVariablen.GrafikmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GrafikmenüAccess (GrafikmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop GrafikmenüSchleife;
      
      
            
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in TextaccessVariablen.KartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KartengrößeAccess (KartengrößeSchleifenwert),
                                    style => StilExtern);
         
      end loop KartengrößeSchleife;
      
      
            
      KartenartSchleife:
      for KartenartSchleifenwert in TextaccessVariablen.KartenartAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KartenartAccess (KartenartSchleifenwert),
                                    style => StilExtern);
         
      end loop KartenartSchleife;
            
      
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in TextaccessVariablen.KartentemperaturAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KartentemperaturAccess (KartentemperaturSchleifenwert),
                                    style => StilExtern);
         
      end loop KartentemperaturSchleife;
            
      
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in TextaccessVariablen.SchwierigkeitsgradAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SchwierigkeitsgradAccess (SchwierigkeitsgradSchleifenwert),
                                    style => StilExtern);
         
      end loop SchwierigkeitsgradSchleife;
            
      
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in TextaccessVariablen.RessourcenmengeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.RessourcenmengeAccess (RessourcenmengeSchleifenwert),
                                    style => StilExtern);
         
      end loop RessourcenmengeSchleife;
            
      
            
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in TextaccessVariablen.DiplomatiemenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.DiplomatiemenüAccess (DiplomatiemenüSchleifenwert),
                                    style => StilExtern);
         
      end loop DiplomatiemenüSchleife;
            
            
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in TextaccessVariablen.KartenpoleAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KartenpoleAccess (KartenpoleSchleifenwert),
                                    style => StilExtern);
         
      end loop KartenpoleSchleife;
      
      
            
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in TextaccessVariablen.SoundmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SoundmenüAccess (SoundmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop SoundmenüSchleife;
            
      
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in TextaccessVariablen.HandelsmenüAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.HandelsmenüAccess (HandelsmenüSchleifenwert),
                                    style => StilExtern);
         
      end loop HandelsmenüSchleife;
      
      
                               
      -- Doppelte Menüs.
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in TextaccessVariablen.SpeziesauswahlAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpeziesauswahlAccess (SpeziesauswahlSchleifenwert),
                                    style => StilExtern);
         
      end loop SpeziesauswahlSchleife;
      
      
            
      KartenformSchleife:
      for KartenformSchleifenwert in TextaccessVariablen.KartenformAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KartenformAccess (KartenformSchleifenwert),
                                    style => StilExtern);
         
      end loop KartenformSchleife;
      
      
            
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       style => StilExtern);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      -- Steuerungsmenü.
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                    style => StilExtern);
         
      end loop SteuerungSchleife;
      
      
      
      -- SpeichernLadenmenü
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                    style => StilExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                    style => StilExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                    style => StilExtern);
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                    style => StilExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                       style => StilExtern);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                             style => StilExtern);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                       style => StilExtern);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                             style => StilExtern);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       style => StilExtern);
            
            Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       style => StilExtern);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.AktuellesBauprojekt,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 style => StilExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    style => StilExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SetauswahlAccess,
                                 style => StilExtern);
      
   end Sprachauswahl;
   
   
   
   procedure StadtInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    style => StilExtern);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    style => StilExtern);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    style => StilExtern);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    style => StilExtern);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtnameKarteAccess,
                                 style => StilExtern);
      
      
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TextaccessVariablen.BasisgrundAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.BasisgrundAccess (BasisgrundSchleifenwert),
                                    style => StilExtern);
         
      end loop BasisgrundSchleife;
      
      
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TextaccessVariablen.ZusatzgrundAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.ZusatzgrundAccess (ZusatzgrundSchleifenwert),
                                    style => StilExtern);
         
      end loop ZusatzgrundSchleife;
      
      
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in TextaccessVariablen.FlüsseAccess'Range loop 
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.FlüsseAccess (FlüsseSchleifenwert),
                                    style => StilExtern);
         
      end loop FlüsseSchleife;
      
      
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TextaccessVariablen.RessourcenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.RessourcenAccess (RessourcenSchleifenwert),
                                    style => StilExtern);
         
      end loop RessourcenSchleife;
      
      
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TextaccessVariablen.FeldeffekteAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.FeldeffekteAccess (FeldeffekteSchleifenwert),
                                    style => StilExtern);
         
      end loop FeldeffekteSchleife;
      
      
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TextaccessVariablen.VerbesserungenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.VerbesserungenAccess (VerbesserungenSchleifenwert),
                                    style => StilExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegeSchleifenwert in TextaccessVariablen.WegeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.WegeAccess (WegeSchleifenwert),
                                    style => StilExtern);
         
      end loop WegeSchleife;
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    style => StilExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    style => StilExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    style => StilExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    style => StilExtern);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                    style => StilExtern);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                    style => StilExtern);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                    style => StilExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftstilGrafik;
