with Sf.Graphics.Text;

with TextaccessVariablen;

package body TextaccesseSchriftrahmenGrafik is

   procedure SchriftrahmenSetzen
     (RahmendickeExtern : in Float)
   is begin
      
      Allgemeines (RahmendickeExtern => RahmendickeExtern);
      Menüs (RahmendickeExtern => RahmendickeExtern);
      Spezies (RahmendickeExtern => RahmendickeExtern);
      ZusatztextKartengröße (RahmendickeExtern => RahmendickeExtern);
      Sprachauswahl (RahmendickeExtern => RahmendickeExtern);
      StadtInformationen (RahmendickeExtern => RahmendickeExtern);
      EinheitenInformationen (RahmendickeExtern => RahmendickeExtern);
      KarteWichtiges (RahmendickeExtern => RahmendickeExtern);
      KarteAllgemeines (RahmendickeExtern => RahmendickeExtern);
      Karte (RahmendickeExtern => RahmendickeExtern);
      EinheitStadtAuswahl (RahmendickeExtern => RahmendickeExtern);
      AnzeigeEingabe (RahmendickeExtern => RahmendickeExtern);
      Ladezeiten (RahmendickeExtern => RahmendickeExtern);
      Befehle (RahmendickeExtern => RahmendickeExtern);
      
   end SchriftrahmenSetzen;
   
   
   
   procedure Allgemeines
     (RahmendickeExtern : in Float)
   is begin
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ÜberschriftAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.VersionsnummerAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ZeilenumbruchAccess,
                                            thickness => RahmendickeExtern);
            
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.Spielmeldung,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.BildrateAccess,
                                            thickness => RahmendickeExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.DiplomatieAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinheitenseitenleisteAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EingabenanzeigeAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinheitenbauinformationenAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.GebäudebauinformationenAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.StadtkarteAccess,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.StadtumgebungAccess,
                                            thickness => RahmendickeExtern);
      -- Später das Zeug überall sortieren. äöü
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop OutroSchleife;
      
      
      
      ZeugSchleife:
      for ZeugSchleifenwert in TextaccessVariablen.ZeugAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ZeugAccess (ZeugSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop ZeugSchleife;
      
      
      
      FragenSchleife:
      for FragenSchleifenwert in TextaccessVariablen.FragenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.FragenAccess (FragenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop FragenSchleife;
      
      
      
      MeldungenSchleife:
      for MeldungenSchleifenwert in TextaccessVariablen.MeldungenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.MeldungenAccess (MeldungenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop MeldungenSchleife;
      
      
      
      WürdigungenSchleife:
      for WürdigungenSchleifenwert in TextaccessVariablen.WürdigungenAccess'Range loop

         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.WürdigungenAccess (WürdigungenSchleifenwert),
                                               thickness => RahmendickeExtern);

      end loop WürdigungenSchleife;
      
      
      
      BeschäftigungenSchleife:
      for BeschäftigungenSchleifenwert in TextaccessVariablen.BeschäftigungenAccess'Range loop

         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.BeschäftigungenAccess (BeschäftigungenSchleifenwert),
                                               thickness => RahmendickeExtern);

      end loop BeschäftigungenSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (RahmendickeExtern : in Float)
   is begin
      
      -- Ohne Überschrift.
      HauptmenüSchleife:
      for HauptmenüSchleifenwert in TextaccessVariablen.HauptmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.HauptmenüAccess (HauptmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop HauptmenüSchleife;
      
      
            
      SpielmenüSchleife:
      for SpielmenüSchleifenwert in TextaccessVariablen.SpielmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpielmenüAccess (SpielmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SpielmenüSchleife;
                
      
      
      -- Mit Überschrift.
      OptionsmenüSchleife:
      for OptionsmenüSchleifenwert in TextaccessVariablen.OptionsmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.OptionsmenüAccess (OptionsmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop OptionsmenüSchleife;
      
      
            
      EinstellungsmenüSchleife:
      for EinstellungsmenüSchleifenwert in TextaccessVariablen.EinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinstellungsmenüAccess (EinstellungsmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop EinstellungsmenüSchleife;
      
      
            
      EditorenmenüSchleife:
      for EditorenmenüSchleifenwert in TextaccessVariablen.EditorenmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EditorenmenüAccess (EditorenmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop EditorenmenüSchleife;
      
      
            
      SpieleinstellungsmenüSchleife:
      for SpieleinstellungsmenüSchleifenwert in TextaccessVariablen.SpieleinstellungsmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpieleinstellungsmenüAccess (SpieleinstellungsmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SpieleinstellungsmenüSchleife;
      
      
            
      DebugmenüSchleife:
      for DebugmenüSchleifenwert in TextaccessVariablen.DebugmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.DebugmenüAccess (DebugmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop DebugmenüSchleife;
            
      
            
      GrafikmenüSchleife:
      for GrafikmenüSchleifenwert in TextaccessVariablen.GrafikmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.GrafikmenüAccess (GrafikmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop GrafikmenüSchleife;
      
      
            
      KartengrößeSchleife:
      for KartengrößeSchleifenwert in TextaccessVariablen.KartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartengrößeAccess (KartengrößeSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KartengrößeSchleife;
      
      
            
      KartenartSchleife:
      for KartenartSchleifenwert in TextaccessVariablen.KartenartAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartenartAccess (KartenartSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KartenartSchleife;
            
      
      
      KartentemperaturSchleife:
      for KartentemperaturSchleifenwert in TextaccessVariablen.KartentemperaturAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartentemperaturAccess (KartentemperaturSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KartentemperaturSchleife;
            
      
      
      SchwierigkeitsgradSchleife:
      for SchwierigkeitsgradSchleifenwert in TextaccessVariablen.SchwierigkeitsgradAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SchwierigkeitsgradAccess (SchwierigkeitsgradSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SchwierigkeitsgradSchleife;
            
      
      
      RessourcenmengeSchleife:
      for RessourcenmengeSchleifenwert in TextaccessVariablen.RessourcenmengeAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.RessourcenmengeAccess (RessourcenmengeSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop RessourcenmengeSchleife;
            
      
            
      DiplomatiemenüSchleife:
      for DiplomatiemenüSchleifenwert in TextaccessVariablen.DiplomatiemenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.DiplomatiemenüAccess (DiplomatiemenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop DiplomatiemenüSchleife;
            
            
      
      KartenpoleSchleife:
      for KartenpoleSchleifenwert in TextaccessVariablen.KartenpoleAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartenpoleAccess (KartenpoleSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KartenpoleSchleife;
      
      
            
      SoundmenüSchleife:
      for SoundmenüSchleifenwert in TextaccessVariablen.SoundmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SoundmenüAccess (SoundmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SoundmenüSchleife;
            
      
      
      HandelsmenüSchleife:
      for HandelsmenüSchleifenwert in TextaccessVariablen.HandelsmenüAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.HandelsmenüAccess (HandelsmenüSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop HandelsmenüSchleife;
      
      
                               
      -- Doppelte Menüs.
      SpeziesauswahlSchleife:
      for SpeziesauswahlSchleifenwert in TextaccessVariablen.SpeziesauswahlAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpeziesauswahlAccess (SpeziesauswahlSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SpeziesauswahlSchleife;
      
      
            
      KartenformSchleife:
      for KartenformSchleifenwert in TextaccessVariablen.KartenformAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartenformAccess (KartenformSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KartenformSchleife;
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                                  thickness => RahmendickeExtern);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      -- Steuerungsmenü.
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SteuerungSchleife;
      
      
      
      -- SpeichernLadenmenü
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
     (RahmendickeExtern : in Float)
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                               thickness => RahmendickeExtern);
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                               thickness => RahmendickeExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                  thickness => RahmendickeExtern);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                        thickness => RahmendickeExtern);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  thickness => RahmendickeExtern);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                        thickness => RahmendickeExtern);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                                  thickness => RahmendickeExtern);
            
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                                  thickness => RahmendickeExtern);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.AktuellesBauprojekt,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.AktuellesForschungsprojekt,
                                            thickness => RahmendickeExtern);
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                            thickness => RahmendickeExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (RahmendickeExtern : in Float)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
     (RahmendickeExtern : in Float)
   is begin
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SprachauswahlAccess,
                                            thickness => RahmendickeExtern);
      
   end Sprachauswahl;
   
   
   
   procedure StadtInformationen
     (RahmendickeExtern : in Float)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                               thickness => RahmendickeExtern);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (RahmendickeExtern : in Float)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                               thickness => RahmendickeExtern);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (RahmendickeExtern : in Float)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                               thickness => RahmendickeExtern);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (RahmendickeExtern : in Float)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                               thickness => RahmendickeExtern);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (RahmendickeExtern : in Float)
   is begin
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.StadtnameKarteAccess,
                                            thickness => RahmendickeExtern);
      
      
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TextaccessVariablen.BasisgrundAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.BasisgrundAccess (BasisgrundSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop BasisgrundSchleife;
      
      
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TextaccessVariablen.ZusatzgrundAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.ZusatzgrundAccess (ZusatzgrundSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop ZusatzgrundSchleife;
      
      
      
      FlüsseSchleife:
      for FlüsseSchleifenwert in TextaccessVariablen.FlüsseAccess'Range loop 
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.FlüsseAccess (FlüsseSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop FlüsseSchleife;
      
      
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TextaccessVariablen.RessourcenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.RessourcenAccess (RessourcenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop RessourcenSchleife;
      
      
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TextaccessVariablen.FeldeffekteAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.FeldeffekteAccess (FeldeffekteSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop FeldeffekteSchleife;
      
      
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TextaccessVariablen.VerbesserungenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.VerbesserungenAccess (VerbesserungenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegeSchleifenwert in TextaccessVariablen.WegeAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.WegeAccess (WegeSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop WegeSchleife;
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
     (RahmendickeExtern : in Float)
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (RahmendickeExtern : in Float)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (RahmendickeExtern : in Float)
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (RahmendickeExtern : in Float)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftrahmenGrafik;
