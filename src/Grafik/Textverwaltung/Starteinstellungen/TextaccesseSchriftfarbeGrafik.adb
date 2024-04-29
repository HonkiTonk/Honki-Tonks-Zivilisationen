with Sf.Graphics.Text;

with TextaccessVariablen;

package body TextaccesseSchriftfarbeGrafik is

   procedure SchriftfarbeSetzen
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor;
      SonstigeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Allgemeines (ÜberschriftExtern => ÜberschriftExtern,
                   StandardExtern    => StandardExtern,
                   SonstigeExtern    => SonstigeExtern);
      
      Menüs (StandardExtern => StandardExtern);
      
      Spezies (ÜberschriftExtern => ÜberschriftExtern,
               StandardExtern    => StandardExtern);
      
      ZusatztextKartengröße (StandardExtern => StandardExtern);
      
      Sprachauswahl (StandardExtern => StandardExtern);
      
      StadtInformationen (StandardExtern => StandardExtern);
      
      EinheitenInformationen (StandardExtern => StandardExtern);
      
      KarteWichtiges (StandardExtern => StandardExtern);
      
      KarteAllgemeines (StandardExtern => StandardExtern);
      
      Karte (StandardExtern => StandardExtern);
      
      EinheitStadtAuswahl (StandardExtern => StandardExtern);
      
      AnzeigeEingabe (StandardExtern => StandardExtern);
      
      Ladezeiten (StandardExtern => StandardExtern);
      
      Befehle (StandardExtern => StandardExtern);
      
   end SchriftfarbeSetzen;
   
   
   
   procedure Allgemeines
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor;
      SonstigeExtern : in Sf.Graphics.Color.sfColor)
   is begin
        
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ÜberschriftAccess,
                                 color => ÜberschriftExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.VersionsnummerAccess,
                                 color => SonstigeExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZeilenumbruchAccess,
                                 color => SonstigeExtern);
      
      -- Für die Texthöhe brauche ich keine Farbe, mal ausgeklammert drin lassen um mich später ni9cht zu verwirren.
      -- Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TexthöheAccess,
      --                           color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.Spielmeldung,
                                 color => StandardExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.DiplomatieAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenseitenleisteAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EingabenanzeigeAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenbauinformationenAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudebauinformationenAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtkarteAccess,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtumgebungAccess,
                                 color => StandardExtern);
      -- Später das Zeug überall sortieren. äöü
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                    color => StandardExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                    color => StandardExtern);
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                    color => StandardExtern);
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                    color => StandardExtern);
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                    color => StandardExtern);
         
      end loop MeldungenSchleife;
      
      
      
      WürdigungenSchleife:
      for WürdigungenSchleifenwert in TextaccessVariablen.WürdigungenAccess'Range loop

         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.WürdigungenAccess (WürdigungenSchleifenwert),
                                    color => StandardExtern);

      end loop WürdigungenSchleife;
      
      
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in TextaccessVariablen.BeschäftigungenAccess'Range loop

         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.BeschäftigungenAccess (BeschäftigungenSchleifenwert),
                                    color => StandardExtern);

      end loop BeschäftigungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      -- Ohne Überschrift.
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in TextaccessVariablen.HauptmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.HauptmenüAccess (HauptmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop HauptmenüSchleife;
      
      
            
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in TextaccessVariablen.SpielmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpielmenüAccess (SpielmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop SpielmenüSchleife;
                
      
      
      -- Mit Überschrift.
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in TextaccessVariablen.OptionsmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.OptionsmenüAccess (OptionsmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop OptionsmenüSchleife;
      
      
            
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in TextaccessVariablen.EinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinstellungsmenüAccess (EinstellungsmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop EinstellungsmenüSchleife;
      
      
            
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in TextaccessVariablen.EditorenmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EditorenmenüAccess (EditorenmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop EditorenmenüSchleife;
      
      
            
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in TextaccessVariablen.SpieleinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpieleinstellungsmenüAccess (SpieleinstellungsmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop SpieleinstellungsmenüSchleife;
      
      
            
      DebugmenüSchleife:
      for DebugmenüSchleifenwert in TextaccessVariablen.DebugmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.DebugmenüAccess (DebugmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop DebugmenüSchleife;
            
      
            
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in TextaccessVariablen.GrafikmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GrafikmenüAccess (GrafikmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop GrafikmenüSchleife;
      
      
            
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in TextaccessVariablen.KartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartengrößeAccess (KartengrößeSchleifenwert),
                                    color => StandardExtern);
         
      end loop KartengrößeSchleife;
      
      
            
      KartenartSchleife:
      for KartenartSchleifenwert in TextaccessVariablen.KartenartAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenartAccess (KartenartSchleifenwert),
                                    color => StandardExtern);
         
      end loop KartenartSchleife;
            
      
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in TextaccessVariablen.KartentemperaturAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartentemperaturAccess (KartentemperaturSchleifenwert),
                                    color => StandardExtern);
         
      end loop KartentemperaturSchleife;
            
      
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in TextaccessVariablen.SchwierigkeitsgradAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SchwierigkeitsgradAccess (SchwierigkeitsgradSchleifenwert),
                                    color => StandardExtern);
         
      end loop SchwierigkeitsgradSchleife;
            
      
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in TextaccessVariablen.RessourcenmengeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RessourcenmengeAccess (RessourcenmengeSchleifenwert),
                                    color => StandardExtern);
         
      end loop RessourcenmengeSchleife;
            
      
            
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in TextaccessVariablen.DiplomatiemenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.DiplomatiemenüAccess (DiplomatiemenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop DiplomatiemenüSchleife;
            
            
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in TextaccessVariablen.KartenpoleAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenpoleAccess (KartenpoleSchleifenwert),
                                    color => StandardExtern);
         
      end loop KartenpoleSchleife;
      
      
            
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in TextaccessVariablen.SoundmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SoundmenüAccess (SoundmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop SoundmenüSchleife;
            
      
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in TextaccessVariablen.HandelsmenüAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.HandelsmenüAccess (HandelsmenüSchleifenwert),
                                    color => StandardExtern);
         
      end loop HandelsmenüSchleife;
      
      
                               
      -- Doppelte Menüs.
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in TextaccessVariablen.SpeziesauswahlAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesauswahlAccess (SpeziesauswahlSchleifenwert),
                                    color => StandardExtern);
         
      end loop SpeziesauswahlSchleife;
      
      
            
      KartenformSchleife:
      for KartenformSchleifenwert in TextaccessVariablen.KartenformAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformAccess (KartenformSchleifenwert),
                                    color => StandardExtern);
         
      end loop KartenformSchleife;
            
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => StandardExtern);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      -- Steuerungsmenü.
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                    color => StandardExtern);
         
      end loop SteuerungSchleife;
      
      
      
      -- SpeichernLadenmenü
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                    color => StandardExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                    color => StandardExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
   
   
   
   procedure Spezies
     (ÜberschriftExtern : in Sf.Graphics.Color.sfColor;
      StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                    color => StandardExtern);
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                    color => StandardExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
                     
            case
              GebäudetextSchleifenwert
            is
            when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => ÜberschriftExtern);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => StandardExtern);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => StandardExtern);
            end case;
            
         end loop GebäudetextSchleife;
      
      
            
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
            
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => ÜberschriftExtern);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => StandardExtern);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => StandardExtern);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => StandardExtern);
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => StandardExtern);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AktuellesBauprojekt,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                 color => StandardExtern);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 color => StandardExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => StandardExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
   
   
   procedure Sprachauswahl
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                 color => StandardExtern);
      
   end Sprachauswahl;
   
   
   
   procedure StadtInformationen
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    color => StandardExtern);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    color => StandardExtern);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    color => StandardExtern);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    color => StandardExtern);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtnameKarteAccess,
                                 color => StandardExtern);
      
      
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TextaccessVariablen.BasisgrundAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.BasisgrundAccess (BasisgrundSchleifenwert),
                                    color => StandardExtern);
         
      end loop BasisgrundSchleife;
      
      
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TextaccessVariablen.ZusatzgrundAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatzgrundAccess (ZusatzgrundSchleifenwert),
                                    color => StandardExtern);
         
      end loop ZusatzgrundSchleife;
      
      
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in TextaccessVariablen.FlüsseAccess'Range loop 
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.FlüsseAccess (FlüsseSchleifenwert),
                                    color => StandardExtern);
         
      end loop FlüsseSchleife;
      
      
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TextaccessVariablen.RessourcenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RessourcenAccess (RessourcenSchleifenwert),
                                    color => StandardExtern);
         
      end loop RessourcenSchleife;
      
      
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TextaccessVariablen.FeldeffekteAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.FeldeffekteAccess (FeldeffekteSchleifenwert),
                                    color => StandardExtern);
         
      end loop FeldeffekteSchleife;
      
      
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TextaccessVariablen.VerbesserungenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.VerbesserungenAccess (VerbesserungenSchleifenwert),
                                    color => StandardExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegeSchleifenwert in TextaccessVariablen.WegeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.WegeAccess (WegeSchleifenwert),
                                    color => StandardExtern);
         
      end loop WegeSchleife;
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    color => StandardExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
                  
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    color => StandardExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
                  
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    color => StandardExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
            
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    color => StandardExtern);
         
      end loop KIZeitenSchleife;
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (1),
                                 color => StandardExtern);
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (1),
                                 color => StandardExtern);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (StandardExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                    color => StandardExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftfarbeGrafik;
