with Sf.Graphics.Text;

with TextaccessVariablen;
with TextDatentypen;

package body TextaccesseSchriftgroesseGrafik is
   
   procedure SchriftgrößeSetzen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      Texthöhen (ÜberschriftExtern => ÜberschriftExtern,
                  StandardExtern    => StandardExtern,
                  KleinExtern       => KleinExtern);
      
      Allgemeines (ÜberschriftExtern => ÜberschriftExtern,
                   StandardExtern    => StandardExtern,
                   KleinExtern       => KleinExtern);
      
      Menüs (StandardExtern => StandardExtern);
      
      Spezies (ÜberschriftExtern => StandardExtern,
               StandardExtern    => StandardExtern);
      
      ZusatztextKartengröße (StandardExtern => StandardExtern);
      
      Sprachauswahl (StandardExtern => StandardExtern);
      
      StadtInformationen (StandardExtern => StandardExtern);
      
      EinheitenInformationen (StandardExtern => StandardExtern);
      
      KarteWichtiges (StandardExtern => StandardExtern);
      
      KarteAllgemeines (StandardExtern => StandardExtern);
      
      Karte (ÜberschriftExtern => ÜberschriftExtern);
      
      EinheitStadtAuswahl (StandardExtern => StandardExtern);
      
      AnzeigeEingabe (StandardExtern => StandardExtern);
      
      Ladezeiten (StandardExtern => StandardExtern);
      
      Befehle (StandardExtern => StandardExtern);
      
   end SchriftgrößeSetzen;
   
   
   
   procedure Texthöhen
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Überschrift_Enum),
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Standard_Enum),
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöhenAccess (TextDatentypen.Klein_Enum),
                                         size => KleinExtern);
      
   end Texthöhen;
   
   
   
   procedure Allgemeines
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32;
      KleinExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ÜberschriftAccess,
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.VersionsnummerAccess,
                                         size => ÜberschriftExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeilenumbruchAccess,
                                         size => KleinExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.Spielmeldung,
                                         size => StandardExtern);
                  
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BildrateAccess,
                                         size => StandardExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.DiplomatieAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenseitenleisteAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EingabenanzeigeAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenbauinformationenAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudebauinformationenAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtkarteAccess,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtumgebungAccess,
                                         size => StandardExtern);
      -- Später das Zeug überall sortieren. äöü
            
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            size => StandardExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                            size => StandardExtern);
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                            size => StandardExtern);
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                            size => StandardExtern);
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                            size => StandardExtern);
         
      end loop MeldungenSchleife;
      
      
      
      WürdigungenSchleife:
      for WürdigungenSchleifenwert in TextaccessVariablen.WürdigungenAccess'Range loop

         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.WürdigungenAccess (WürdigungenSchleifenwert),
                                            size => StandardExtern);

      end loop WürdigungenSchleife;
      
      
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in TextaccessVariablen.BeschäftigungenAccess'Range loop

         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BeschäftigungenAccess (BeschäftigungenSchleifenwert),
                                            size => StandardExtern);

      end loop BeschäftigungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      -- Ohne Überschrift.
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in TextaccessVariablen.HauptmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.HauptmenüAccess (HauptmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop HauptmenüSchleife;
      
      
            
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in TextaccessVariablen.SpielmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpielmenüAccess (SpielmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop SpielmenüSchleife;
                
      
      
      -- Mit Überschrift.
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in TextaccessVariablen.OptionsmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.OptionsmenüAccess (OptionsmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop OptionsmenüSchleife;
      
      
            
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in TextaccessVariablen.EinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinstellungsmenüAccess (EinstellungsmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop EinstellungsmenüSchleife;
      
      
            
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in TextaccessVariablen.EditorenmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EditorenmenüAccess (EditorenmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop EditorenmenüSchleife;
      
      
            
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in TextaccessVariablen.SpieleinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpieleinstellungsmenüAccess (SpieleinstellungsmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop SpieleinstellungsmenüSchleife;
      
      
            
      DebugmenüSchleife:
      for DebugmenüSchleifenwert in TextaccessVariablen.DebugmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.DebugmenüAccess (DebugmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop DebugmenüSchleife;
            
      
            
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in TextaccessVariablen.GrafikmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GrafikmenüAccess (GrafikmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop GrafikmenüSchleife;
      
      
            
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in TextaccessVariablen.KartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartengrößeAccess (KartengrößeSchleifenwert),
                                            size => StandardExtern);
         
      end loop KartengrößeSchleife;
      
      
            
      KartenartSchleife:
      for KartenartSchleifenwert in TextaccessVariablen.KartenartAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenartAccess (KartenartSchleifenwert),
                                            size => StandardExtern);
         
      end loop KartenartSchleife;
            
      
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in TextaccessVariablen.KartentemperaturAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartentemperaturAccess (KartentemperaturSchleifenwert),
                                            size => StandardExtern);
         
      end loop KartentemperaturSchleife;
            
      
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in TextaccessVariablen.SchwierigkeitsgradAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SchwierigkeitsgradAccess (SchwierigkeitsgradSchleifenwert),
                                            size => StandardExtern);
         
      end loop SchwierigkeitsgradSchleife;
            
      
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in TextaccessVariablen.RessourcenmengeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RessourcenmengeAccess (RessourcenmengeSchleifenwert),
                                            size => StandardExtern);
         
      end loop RessourcenmengeSchleife;
            
      
            
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in TextaccessVariablen.DiplomatiemenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.DiplomatiemenüAccess (DiplomatiemenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop DiplomatiemenüSchleife;
            
            
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in TextaccessVariablen.KartenpoleAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenpoleAccess (KartenpoleSchleifenwert),
                                            size => StandardExtern);
         
      end loop KartenpoleSchleife;
      
      
            
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in TextaccessVariablen.SoundmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SoundmenüAccess (SoundmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop SoundmenüSchleife;
            
      
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in TextaccessVariablen.HandelsmenüAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.HandelsmenüAccess (HandelsmenüSchleifenwert),
                                            size => StandardExtern);
         
      end loop HandelsmenüSchleife;
      
      
                               
      -- Doppelte Menüs.
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in TextaccessVariablen.SpeziesauswahlAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesauswahlAccess (SpeziesauswahlSchleifenwert),
                                            size => StandardExtern);
         
      end loop SpeziesauswahlSchleife;
      
      
            
      KartenformSchleife:
      for KartenformSchleifenwert in TextaccessVariablen.KartenformAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformAccess (KartenformSchleifenwert),
                                            size => StandardExtern);
         
      end loop KartenformSchleife;
            
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => StandardExtern);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      -- Steuerungsmenü.
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                            size => StandardExtern);
         
      end loop SteuerungSchleife;
      
      
      
      -- SpeichernLadenmenü
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            size => StandardExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                            size => StandardExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
     (ÜberschriftExtern : in Sf.sfUint32;
      StandardExtern : in Sf.sfUint32)
   is begin
            
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                            size => StandardExtern);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                            size => StandardExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => ÜberschriftExtern);
               
               when others =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => StandardExtern);
         
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => StandardExtern);
            end case;
         
         end loop GebäudetextSchleife;


      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => ÜberschriftExtern);
               
            when others =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => StandardExtern);
         
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => StandardExtern);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungstextSchleife:
         for ForschungstextSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => StandardExtern);
               
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => StandardExtern);
         
         end loop ForschungstextSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesBauprojekt,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                         size => StandardExtern);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         size => StandardExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => StandardExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
            
      
   
   procedure Sprachauswahl
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SprachauswahlAccess,
                                         size => StandardExtern);
            
   end Sprachauswahl;
   
   
   
   procedure StadtInformationen
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                            size => StandardExtern);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                            size => StandardExtern);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                            size => StandardExtern);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                            size => StandardExtern);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (ÜberschriftExtern : in Sf.sfUint32)
   is begin
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtnameKarteAccess,
                                         size => ÜberschriftExtern);
      
      
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TextaccessVariablen.BasisgrundAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.BasisgrundAccess (BasisgrundSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop BasisgrundSchleife;
      
      
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TextaccessVariablen.ZusatzgrundAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatzgrundAccess (ZusatzgrundSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop ZusatzgrundSchleife;
      
      
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in TextaccessVariablen.FlüsseAccess'Range loop 
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.FlüsseAccess (FlüsseSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop FlüsseSchleife;
      
      
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TextaccessVariablen.RessourcenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RessourcenAccess (RessourcenSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop RessourcenSchleife;
      
      
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TextaccessVariablen.FeldeffekteAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.FeldeffekteAccess (FeldeffekteSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop FeldeffekteSchleife;
      
      
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TextaccessVariablen.VerbesserungenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.VerbesserungenAccess (VerbesserungenSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegeSchleifenwert in TextaccessVariablen.WegeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.WegeAccess (WegeSchleifenwert),
                                            size => ÜberschriftExtern);
         
      end loop WegeSchleife;
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
     (StandardExtern : in Sf.sfUint32)
   is begin
            
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                            size => StandardExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            size => StandardExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (StandardExtern : in Sf.sfUint32)
   is begin
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                            size => StandardExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                            size => StandardExtern);
         
      end loop KIZeitenSchleife;
               
            
         
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RundenendeAccess (1),
                                         size => StandardExtern);
      
      
               
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeichernLadenAccess (1),
                                         size => StandardExtern);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (StandardExtern : in Sf.sfUint32)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                            size => StandardExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftgroesseGrafik;
