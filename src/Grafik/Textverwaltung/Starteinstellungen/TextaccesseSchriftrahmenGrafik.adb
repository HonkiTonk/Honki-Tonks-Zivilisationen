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
      Kartenformauswahl (RahmendickeExtern => RahmendickeExtern);
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
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (RahmendickeExtern : in Float)
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                                  thickness => RahmendickeExtern);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                               thickness => RahmendickeExtern);
         
      end loop SteuerungSchleife;
      
      
      
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
   
   
   
   procedure Kartenformauswahl
     (RahmendickeExtern : in Float)
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                               thickness => RahmendickeExtern);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
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
      
      Sf.Graphics.Text.setOutlineThickness (text      => TextaccessVariablen.KarteAccess,
                                            thickness => RahmendickeExtern);
      
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
